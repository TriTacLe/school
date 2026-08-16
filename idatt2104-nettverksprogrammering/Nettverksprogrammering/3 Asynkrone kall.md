---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## Condition variables
```cpp
bool wait(true);
mutex wait_mutex;
condition_variable cv;

thread t([& wait, & wait_mutex, & cv] {
    unique_lock<mutex> lock(wait_mutex);
    while (wait)
        cv.wait(lock);
    cout << "thread: finished waiting" << endl;
});

this_thread::sleep_for(1s);

{
    unique_lock<mutex> lock(wait_mutex);
    wait = false;
}
cv.notify_one();

t.join();
```
`bool wait`er betingelsen som sjekkes
`mutex wait_mutex`brukes til å beskytte delte data `wait`
- Uten `mutex`kan tråder lese og skrive `wait`samtidig 
`unique_lock<mutex> lock(wait_mutex)
`contion_variable cv`er et objekt som lar tråden vente effektivt på en betingelse istedenfor busy-wait polling, sover tråden helt til `cv.notify_one()`
`cv.wait(lock)` låser opp mutexen slik at andre tråder kan endre `wait`. Trådene går i søvn. Hindrer tråden å forsette før betingelsene er faktisk oppfylt. Når `notify_one` kalles, låses mutexen automatisk på nytt før `wait()` returnerer
## Funksjonsobjekter
Lagring av funksjoner i en liste
```cpp
# include <functional>
# include <iostream>
# include <list>
using namespace std;

void func(){
	cout << "func" << endl ;
}
int main(){
	list<function<void()>>functions;
	
	functions.emplace_back ([] {
		cout << "lambda" << endl;
	});
	
	functions.emplace_back(func);
	
	for (auto &f : functions)
		f();
}
// Output :
// lambda
// func 
```
Lagrer funksjoner i en liste `functions`som kan inneholde funksjonsobjekter av typen `void()`
Vanlig å bruke list-konteinere for å lagre funksjonsobjekter, siden slike konteinere kan være mindre ressurskrevende å manipulere
`list<function<void()>> functions` oppretter en dynamisk liste (dobbelt lenket liste) som kan inneholde flere callable objekter
`emplace_back()`legger til en funksjon i i listen
Løkken itererer over alle elementene i listen og kjører hver funksjon.
## Worker threads
```cpp
#include <functional>
#include <iostream>
#include <list>
#include <mutex>
#include <thread>
#include <vector>
#include <condition_variable>

using namespace std;

list<function<void()>> tasks;   // Liste med oppgaver
mutex tasks_mutex;              // Beskytter listen
condition_variable cv;          // Vekker worker threads når nye oppgaver kommer 
bool done_posting = false;      // Flag for å stoppe trådene når alle oppgaver er postet

// Funksjon som legger til oppgaver
void post_tasks() {
    for (int i = 0; i < 10; i++) {
        {
            unique_lock<mutex> lock(tasks_mutex);
            tasks.emplace_back([i] {
                cout << "task " << i
                     << " runs in thread "
                     << this_thread::get_id()
                     << endl;
            });
        }
        cv.notify_one(); // Vekk en worker thread
        this_thread::sleep_for(50ms); // Simuler litt delay
    }

    // Merk: Vi er ferdig med å legge til oppgaver
    {
        unique_lock<mutex> lock(tasks_mutex);
        done_posting = true;
    }
    cv.notify_all(); // Vekk alle tråder som venter, så de kan avslutte
}

// Funksjon som starter worker threads
void run_tasks_in_worker_threads() {
    const int num_workers = 4;
    vector<thread> worker_threads;

    for (int i = 0; i < num_workers; i++) {
        worker_threads.emplace_back([] {
            while (true) {
                function<void()> task;

                {
                    unique_lock<mutex> lock(tasks_mutex);
		        // Vent til det finnes en oppgave eller vi er ferdig med posting
                    cv.wait(lock, [] { return !tasks.empty() || done_posting; });

                    // Hvis listen fortsatt er tom og alt er ferdig, stopp tråden
                    if (tasks.empty() && done_posting)
                        return;

                    // Ta ut første oppgave
                    task = *tasks.begin(); // copy task
                    tasks.pop_front(); // remove from list
                }

                // Kjør oppgaven utenfor mutex
                if (task)
                    task();
            }
        });
    }

    // Vent på at alle worker threads blir ferdig
    for (auto &thread : worker_threads)
        thread.join();
}

int main() {
    thread producer(post_tasks);     // Tråd som legger til oppgaver
    run_tasks_in_worker_threads();   // Start worker threads

    producer.join(); // Vent på at post_tasks-tråden blir ferdig
}
```
Thread pool / worker threads eksempel der man legger oppgaver i en liste `tasks` og lar flere tråder hente og kjøre dem.

Starter 4 tråder som kontinuerlig sjekker om det finnes oppgaver. Hver tråd:
1. Låser mutex
2. Tar første oppgave fra listen hvis den finnes
3. Låser opp mutex
4. Kjører oppgaven utenfor mutex for å ikke blokkere andre tråder
Burde bruke condition variables fordi hvis `tasks`er tom, låser de mutex, sjekker liste, låser opp igjen, og repeterer i en uendelig løkke. Bruker unødvendig CPU når det ikke finnes oppgaver. Condition variables lar tråden sove når listen er tom, vekke tråden når en ny oppgave legges til (`notify_one` eller `notify_all`)
## Event loop
En event loop er det samme som en worker thread med bare en tråd
Fire tråder
```cpp
server.config.thread_pool_size = 4; // 4 worker threads handle requests
server.resource["^/$"]["GET"] = [](auto response, auto request) {
    static int number_of_requests = 0;
    static mutex number_of_requests_mutex;
    unique_lock<mutex> lock(number_of_requests_mutex);
    response->write(
        "Number of requests since the server was started: " +
        to_string(++number_of_requests)
    );
};
```
- Her brukes mutex for å sikre at bare en tråd om gangen kan oppdatere `number_of_requests`
En tråd
```cpp
server.config.thread_pool_size = 1; // 1 thread handles requests : event loop
server.resource["^/$"]["GET"] = [](auto response, auto request) {
    static int number_of_requests = 0;
    // No mutex needed
    response->write(
        "Number of requests since the server was started: " +
        to_string(++number_of_requests)
    );
};
```
- Fordi ingen tråder kjører samtidig er det ingen risiko for race conditions og trenger ikke mutex og koden blir lettere
Siden bare

## Øving 2
```cpp
#include <condition_variable>
#include <iostream>
#include <thread>
#include <mutex>
#include <list>
#include <vector>
#include <functional>
#include <chrono>

using namespace std;

class Workers {
private:
    int n_threads;
    vector<thread> threads;
    condition_variable cv;
    mutex mtx;
    list<function<void()>> tasks;
    bool post_flag;

public:
    Workers(int n){
      n_threads = n;
      post_flag = false;
    }

    // Start thread in tasks
    void start() {
      // For every thread 
      for (int i = 0; i < n_threads; i++) {
        threads.emplace_back([this]() {
          while (true) {
            function<void()> task;
              {
                unique_lock<mutex> lock(mtx);
                cv.wait(lock, [this]() { return !tasks.empty() || post_flag;
              });

              if (tasks.empty() && post_flag) {
                return;
              }

                task = tasks.front();
                tasks.pop_front();
              }
            task();
            }
        });
      }
    }
    
    // ADding task to the task list (tasks) 
    void post(function<void()> task) {
      {
        unique_lock<mutex> lock(mtx);
        tasks.push_back(task);
      }
      cv.notify_one(); // En task tilgjengelig
    }

    void stop() {
      {
        unique_lock<mutex> lock(mtx);
        post_flag = true;
      }
      cv.notify_all();
   }

    void join() {
      for (auto& thread : threads) {
        thread.join();
      }
    }

    void post_timeout(function<void()> task, int ms) {
      this_thread::sleep_for(chrono::milliseconds(ms));
        task();
    }
};

int main() {
    Workers worker_threads(4);
    Workers event_loop(1);

    worker_threads.start();
    event_loop.start();

    worker_threads.post([] {
        cout << "Task A" << endl;
    });

    worker_threads.post([] {
        cout << "Task B" << endl;
    });

    event_loop.post([] {
        cout << "Task C" << endl;
    });

    event_loop.post([] {
        cout << "Task D" << endl;
    });


    worker_threads.post_timeout([] {
      cout << "Task E with timeout" << endl;
    }, 1000);


    worker_threads.stop();
    event_loop.stop();

    worker_threads.join();
    event_loop.join();

    return 0;
}
```
**Thread pool**
- En thread pool er en samling av worker-threads som er allerede opprettet og venter på å få arbeid (tasks) å utføre. I stedet for å lage nye threads hver gang du har en oppgave, gjenbruker du eksisterende threads.

- `threads`: Vector som holder selve thread-objektene
- `cv` (condition variable): Lar tråder vente til det er arbeid tilgjengelig
- `mtx` (mutex): Sørger for at bare én tråd om gangen kan endre `tasks`-listen
- `tasks`: En kø (FIFO) med funksjoner som skal kjøres

```cpp 
cv.wait(lock, [this]() { return !tasks.empty() || post_flag;
```
- Hvis FALSE $\to$ låser opp mutex, setter tråd i sovemodus (slipper CPU), venter på cv.notify
- Når notified (via `post()`) $\to$ våkner opp, låser mutex 
- Hvis TRUE (er tasks eller stop er kalt) $\to$ forsetter videre i koden.

Hvorfor kjøres task utenfor låsen?
- Hvis `task()`tar lang tid , ville mutex vært låst hele tiden
- Andre tråder kan ikke hente task fra køen
- Parallellisering

Main Thread: 
- Oppretter Workers(4)
- start() $\to$ spawner 4 worker threads 
	- Worker 1: cv.wait() $\to$ henter Task A $\to$ kjører $\to$  cv.wait() 
	- Worker 2: cv.wait() $\to$ henter Task B $\to$ kjører $\to$ cv.wait() 
	- Worker 3: cv.wait() $\to$ (ingen tasks) $\to$ cv.wait() 
	- Worker 4: cv.wait() $\to$ (ingen tasks) $\to$ cv.wait()
- post(Task A) $\to$ notify_one() $\to$ vekker Worker 1 
- post(Task B) $\to$ notify_one() $\to$ vekker Worker 2 
- stop() $\to$ post_flag=true $\to$ notify_all() $\to$ alle våkner og dør
- join() $\to$ venter på at alle 4 workers er døde 
main() avsluttes

## See also
- [[idatt2104-moc]]
