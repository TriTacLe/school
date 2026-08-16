    LOGO
                                                                     HISTORIE                                                       LOGOFARGER                                                        IKKE SLIK
                                                                     NTNUs logo ble laget i 1995 av Bruno Oldani Design Studio.                                                                       Man kan ikke endre på logoens form eller oppsett, eller
                                                                     Logoen består av de to elementene «emblemet» og boksta-                                       1. Hovedlogo med farge             endre farger på symbol og bokstaver. NTNUs logo er «ei
                                                                     vene «NTNU».                                                       Kunnskap for en bedre verden                                  hellig ku» og skal ikke tukles med. Her er noen eksempler
                                                                                                                                                                                                      på ting som ikke er lov:
                                                                                                                                                                   2. Sort logo
                                                                     Emblemet er et abstrakt symbol bestående av buede og
                                                                                                                                        Kunnskap for en bedre verden
                                                                     rette linjer, kvadrat og sirkel, som er ment å gi assosia-                                                                       1. Ikke bruk konturfarge 2. Feil skrifttype
                                                                     sjoner til både teknologi og humaniora. Uten å framheve                                       3. Hvit logo (negativ versjon)     3. Ikke strekk emblemet 4. Ikke tegn på, eller manipuler
                                                                     det ene på bekostning av det andre antyder det et balansert        Kunnskap for en bedre verden                                  emblemet 5. Ikke endre farge i emblemet 6. Ikke bruk
                                                                     samspill mellom fagene innenfor NTNU.                                                                                            farge på bokstavene/teksten
             Kunnskap for en bedre verden
                                                                     HOVEDLOGO MED VISJON                                           INSTITUTT- OG FAKULTETSLOGOER                                     1.                        2.

                                      Kunnskap for en bedre verden   Visjonen «Kunnskap for en bedre verden» brukes sammen          Alle enheter ved NTNU skal bruke de offisielle                                                    NTNU
                                                                                                                                                                                                                                       NTNU
                                                                                                                                                                                                                                      NTNU
                                                                                                                                                                                                                                       NTNUKunnskap
                                                                                                                                                                                                                                      Kunnskap for en for en bedre
                                                                                                                                                                                                                                                      bedre  verdenverden
                                                                     med logoen når man ikke skal synliggjøre enhetsnavn i          logoene. Disse finnes i både stående og liggende                                                  Kunnskap
                                                                                                                                                                                                                                           Kunnskap
                                                                                                                                                                                                                                               for en for
                                                                                                                                                                                                                                                      bedre
                                                                                                                                                                                                                                                          en bedre
                                                                                                                                                                                                                                                             verdenverden
                                                                     logoen. Logoens form skal ikke endres og sett bort fra de      versjon, med flere nivåer.

    Nettverksprogrammering                                           ulike logo-variantene som kan lastes ned fra Innsida kan
                                                                     det heller ikke gjøres endringer i elementenes oppsett,
                                                                     avstand eller farger. Er du i tvil, kan du kontakte kommuni-
                                                                                                                                                                  Fakultet for arkitektur og design
                                                                                                                                                                                                      3.                         4.




                                                                     kasjonsavdelingen på hjelp.ntnu.no.
    Kunnskap                                                                                                                                                                                          5.                        6.
    for en bedre
    verden

    Asynkrone kall                                                                                                                      Fakultet for arkitektur og design


                                                                                                                                                                 Fakultet for arkitektur og design
                                                                                                                                                                 Institutt for design


                                                                                                                                                                                                      KONTRASTER

                                                                                                                                        Fakultet for arkitektur og design
                                                                                                                                                                                                      Husk alltid å vurder lesbarheten på logoen ved å sjekke
                                                                     Se alle logovarianter på Innsida                                   Institutt for design                                          at det er god nok kontrast mot bakgrunnen.


6                                                                                                                                                                                                                                                                           7




    Ole C. Eidheim
    January 23, 2025
    Department of Computer Science
Oversikt


Condition variables


Funksjonsobjekter


Worker threads


Event loop


Øving P2




                      1/20
Condition variables
- vente på en betingelse

 Hva er problemet her?      # include < iostream >
                            # include < thread >

                            using namespace std ;

                            int main () {
                              bool wait ( true );

                                thread t ([& wait ] {
                                  while ( wait ) {
                                  }

                                  cout << " finished waiting " << endl ;
                                });

                                this_thread :: sleep_for (1 s );

                                wait = false ;

                                t . join ();
                            }


                                                                           2/20
Condition variables
- vente på en betingelse, forbedret 1

 Hva er problemet her?    # include < atomic >
                          # include < iostream >
                          # include < thread >

                          using namespace std ;

                          int main () {
                            atomic < bool > wait ( true ); // Use atomic

                              thread t ([& wait ] {
                                while ( wait ) {
                                }

                                cout << " thread : finished waiting " << endl ;
                              });

                              this_thread :: sleep_for (1 s );

                              wait = false ;

                              t . join ();
                          }
                                                                                  3/20
Condition variables
- vente på en betingelse, forbedret 2

 Hva er problemet her?    # include < atomic >
                          # include < iostream >
                          # include < thread >

                          using namespace std ;

                          int main () {
                            atomic < bool > wait ( true );

                              thread t ([& wait ] {
                                while ( wait )
                                  this_thread :: sleep_for (20 ms ); // Less CPU usage

                                cout << " thread : finished waiting " << endl ;
                              });

                              this_thread :: sleep_for (1 s );

                              wait = false ;

                              t . join ();
                          }
                                                                                         4/20
Condition variables
- vente på en betingelse, forbedret 3
                                # include < condition_variable >
 Vi slipper her å bruke        # include < iostream >
                                # include < thread >
 this thread::sleep for()
 i tråden, og på den måten   using namespace std ;

 unngår forsinkelser når      int main () {
                                  bool wait ( true );
 wait-variablen blir satt til     mutex wait_mutex ;
                                  c on d it i o n _ v a ri ab l e cv ;
 false.
                                    thread t ([& wait , & wait_mutex , & cv ] {
                                      unique_lock < mutex > lock ( wait_mutex );
                                      while ( wait )
                                        cv . wait ( lock ); // Unlock wait_mutex and wait .
 Merk også at atomic ikke                                  // When awaken , wait_mutex is locked .

 lenger er brukt. En                  cout << " thread : finished waiting " << endl ;
                                    });
 condition variable må
 brukes sammen med en               this_thread :: sleep_for (1 s );

 mutex, men denne                   {
                                        unique_lock < mutex > lock ( wait_mutex );
 mutexen kan vi i tillegg               wait = false ;
                                    }
 bruke til å beskytte              cv . notify_one (); // Awake waiting cv
 wait-variabelen.                   t . join ();                                                      5/20
                                }
Oversikt


Condition variables


Funksjonsobjekter


Worker threads


Event loop


Øving P2




                      6/20
Funksjonsobjekter
- lagring av funksjoner i en liste

   • Listen functions kan inneholde              # include < functional >
                                                 # include < iostream >
     funksjonsobjekter av typen void()           # include < list >
   • Vanlig å bruke en liste-konteiner for å   using namespace std ;
     lagre funksjonsobjekter, siden slike
                                                 void func () {
     konteiner kan være mindre                     cout << " func " << endl ;
                                                 }
     ressurskrevende å manipulere
                                                 int main () {
                                                   list < function < void () > > functions ;

                                                   functions . emplace_back ([] {
                                                     cout << " lambda " << endl ;
                                                   });
                                                   functions . emplace_back ( func );

                                                   for ( auto & f : functions )
                                                     f ();
                                                 }
                                                 // Output :
                                                 // lambda
                                                 // func                                       7/20
Oversikt


Condition variables


Funksjonsobjekter


Worker threads


Event loop


Øving P2




                      8/20
Worker threads




                 9/20
Enkel worker threads implementasjon
- første forsøk, hva er problemet her?


 # include   < functional >                 void r u n _ t a s k s _ i n _ w o r k e r _ t h r e a d s () {
 # include   < iostream >                     vector < thread > worker_threa ds ;
 # include   < list >                         for ( int i = 0; i < 4; i ++) {
 # include   < thread >                         work er_threads . emplace_back ([] {
 # include   < vector >                            while ( true ) {
                                                       if (! tasks . empty ()) {
 using namespace std ;                                     auto task = * tasks . begin (); // Copy task
                                                           tasks . pop_front (); // Remove task from list
 list < function < void () > > tasks ;                     task (); // Run task
                                                       }
 void post_tasks () {                              }
   for ( int i = 0; i < 10; i ++) {             });
     tasks . emplace_back ([ i ] {            }
       cout << " task " << i
              << " runs in thread "             for ( auto & thread : worker_threads )
              << this_thread :: get_id ()         thread . join ();
              << endl ;                     }
     });
   }                                        int main () {
 }                                            post_tasks ();
                                              r u n _ t a s k s _ i n _ w o r k e r _ t h r e a d s ();
                                            }




                                                                                                              10/20
Enkel worker threads implementasjon
- legg merke til TODO

 # include   < functional >                        void r u n _ t a s k s _ i n _ w o r k e r _ t h r e a d s () {
 # include   < iostream >                            vector < thread > worker_threa ds ;
 # include   < list >                                for ( int i = 0; i < 4; i ++) {
 # include   < mutex >                                 worker_threads . emplace_back ([] {
 # include   < thread >                                   while ( true ) {
 # include   < vector >                                       function < void () > task ;
                                                              {
 using namespace std ;                                            unique_lock < mutex > lock ( tasks_mutex );
                                                                  // TODO : use conditional variable
 list < function < void () > > tasks ;                            if (! tasks . empty ()) {
 mutex tasks_mutex ; // tasks mutex needed                            task = * tasks . begin (); // Copy task for later use
                                                                      tasks . pop_front ();                      // Remove task from list
 void post_tasks () {                                             }
   for ( int i = 0; i < 10; i ++) {                           }
     unique_lock < mutex > lock ( tasks_mutex );              if ( task )
     tasks . emplace_back ([ i ] {                                task (); // Run task outside of mutex lock
       cout << " task " << i                              }
              << " runs in thread "                    });
              << this_thread :: get_id ()            }
              << endl ;
     });                                               for ( auto & thread : worker_threads )
   }                                                     thread . join ();
 }                                                 }

                                                   int main () {
                                                     post_tasks ();
                                                     r u n _ t a s k s _ i n _ w o r k e r _ t h r e a d s ();
                                                   }
                                                                                                                                     11/20
Oversikt


Condition variables


Funksjonsobjekter


Worker threads


Event loop


Øving P2




                      12/20
Event loop


  En event loop er det samme som en worker thread med bare en tråd:




                                                                       13/20
Event loop vs worker threads
- bruk av felles ressurser i worker threads

   Eksempler med Simple-Web-Server:
   # include " server_http . hpp "

   using namespace std ;

   int main () {
     SimpleWeb :: Server < SimpleWeb :: HTTP > server ;
     server . config . port = 8080;
     server . config . t hr e a d _ p o o l _ s i ze = 4; // 4 worker threads handle requests

       server . resource [ " ^/ $ " ][ " GET " ] = []( auto response , auto request ) {
         static int n u m b e r _ o f _ r e q u e s t s = 0;
         static mutex n u m b e r _ o f _ r e q u e s t s _ m u t e x ;

            unique_lock < mutex > lock ( n u m b e r _ o f _ r e q u e s t s _ m u t e x );
            response - > write ( " Number of requests since the server was started : " +
                                 to_string (++ n u m b e r _ o f _ r e q u e s t s ));
       };

       server . start ();
   }

                                                                                                14/20
Event loop vs worker threads
- event loop forenkler programmeringen og er ofte kjappere


   Eksempler med Simple-Web-Server:
   # include " server_http . hpp "

   using namespace std ;

   int main () {
     SimpleWeb :: Server < SimpleWeb :: HTTP > server ;
     server . config . port = 8080;
     server . config . t hr e a d _ p o o l _ s i ze = 1; // 1 thread handles requests : event loop

       server . resource [ " ^/ $ " ][ " GET " ] = []( auto response , auto request ) {
          static int n u m b e r _ o f _ r e q u e s t s = 0;
          // No mutex needed
          response - > write ( " Number of requests since the server was started : " +
                               to_string (++ n u m b e r _ o f _ r e q u e s t s ));
       };

       server . start ();
   }



                                                                                                      15/20
Oversikt


Condition variables


Funksjonsobjekter


Worker threads


Event loop


Øving P2




                      16/20
Øving P2
 • Lag Workers klassen med
                                          Workers worker_threads (4);
   funksjonaliteten vist til høyre.       Workers event_loop (1);
 • Bruk condition variable.
                                          work er_threads . start (); // Create 4 internal threads
 • post()-metodene skal være trådsikre   event_loop . start ();      // Create 1 internal thread
   (kunne brukes problemfritt i flere
                                          work er_threads . post ([] {
   tråder samtidig).                       // Task A
 • Valg av programmeringssrpråk er       });
                                          worker_threads . post ([] {
   valgfritt, men ikke Python. Java,        // Task B
   C++ eller Rust anbefales, men andre      // Might run in parallel with task A
   programmeringsspråk som støtter       });

   condition variables går også fint.   event_loop . post ([] {
 • Legg til en Workers metode stop          // Task C
                                            // Might run in parallel with task A and B
   som avslutter workers trådene for     });
   eksempel når task-listen er tom.      event_loop . post ([] {
                                            // Task D
 • Legg til en Workers metode               // Will run after task C
   post timeout() som kjører task           // Might run in parallel with task A and B
   argumentet etter et gitt antall        });
   millisekund.
                                          work er_threads . join (); // Calls join () on the worker threads
      • Frivillig: forbedre               event_loop . join ();      // Calls join () on the event thread
        post timeout()-metoden med
                                                                                                       17/20
        epoll i Linux, se neste slides.
Frivillig: forbedret timeout() i Linux
- epoll: scalable I/O event notification mechanism

 • Implementasjon av post timeout():                Workers event_loop (1);
     • Den enkle måten er å kjøre en              event_loop . start ();
       sleep()-funksjon direkte, men da låses
                                                    event_loop . post_timeout ([] {
       denne worker thread’en                          cout << " task A " << endl ;
     • En litt bedre måte, og litt vanskeligere,   } , 2000); // Call task after 2000 ms
       er å lage en ny tråd og kjøre sleep()      event_loop . post_timeout ([] {
       og post() i denne tråden, men da kan           cout << " task B " << endl ;
                                                    } , 1000); // Call task after 1000 ms
       det potensielt bli opprettet svært mange
       tråder                                      event_loop . join ();
     • Det beste alternativet, men vanskeligst,
                                                    //   Output with sleep () in post_timeout ():
       er å bruke epoll (se neste slides)          //   task A
          • Merk at epoll-funksjonene er C          //   task B
                                                    //   Output with epoll ,
            funksjoner som kan være vanskelig å    //   or sleep () in separate thread :
            kalle fra andre programmeringsspråk    //   task B
                                                    //   task A
            enn C++ og Rust

                                                                                               18/20
Frivillig: forbedret timeout i Linux
- epoll bakgrunn


     • Unix/Linux: ”everything is a file”
         • Fil deskriptor (fd): en integer som refererer til en åpen ”fil”, for eksempel:
              • Standard input har fd 0
              • Standard output har fd 1
         • En kan lage en timer ”fil” med timerfd create()
              • ”innhold” i ”filen” blir tilgjengelig etter en gitt varighet (timeout) eller i intervall
         • En kan lage en nettverksoppkobling ”fil” med socket()
              • innhold i ”filen” blir tilgjengelig når du har mottatt data over nettverket
     • epoll wait() overvåker ”filer”, og returnerer ved I/O hendelser
         • En hendelse er for eksempel når data er tilgjengelig og kan leses fra en ”fil”
     • epoll ctl() legger til eller tar bort ”filer” som skal overvåkes av epoll wait().
         • epoll ctl() og epoll wait() er trådsikre og kan kalles i forskjellige tråder


                                                                                                           19/20
Frivillig: forbedret timeout i Linux
- epoll eksempel
# include   < iostream >
# include   < sys / epoll .h >
# include   < sys / timerfd .h >
# include   < vector >                                  Merk at epoll wait() blokkerer og må kjøres i en egen tråd.
using namespace std ;                                   Du trenger ikke bruke condition variable i denne tråden, siden
int main () {                                           epoll wait() allerede har denne funksjonaliteten.
  int epoll_fd = epoll_create1 (0);

    epoll_event timeout ;
    timeout . events = EPOLLIN ;
    timeout . data . fd = timerfd_create ( CLOCK_MONOTONIC , 0);
    itimerspec ts ;
    int ms = 2000;                                             // 2 seconds
    ts . it_value . tv_sec = ms / 1000;                        // Delay before initial event
    ts . it_value . tv_nsec = ( ms % 1000) * 1000000; // Delay before initial event
    ts . it_interval . tv_sec = 0;                             // Period between repeated events after initial delay , 0: disabled
    ts . it_interval . tv_nsec = 0;                            // Period between repeated events after initial delay , 0: disabled
    t im erfd_sett im e ( timeout . data . fd , 0 , & ts , nullptr );
    // Add timeout to epoll so that it is monitored by epoll_wait :
    epoll_ctl ( epoll_fd , EPOLL_CTL_ADD , timeout . data . fd , & timeout );

    vector < epoll_event > events (128); // Max events to process at once
    while ( true ) {
      cout << " waiting for events " << endl ;
      auto event_count = epoll_wait ( epoll_fd , events . data () , events . size () , -1);
      for ( int i = 0; i < event_count ; i ++) {
        cout << " event fd : " << events [ i ]. data . fd << endl ;
        if ( events [ i ]. data . fd == timeout . data . fd ) {
           cout << " 2 seconds has passed " << endl ;
           // Remove timeout from epoll so that it is no longer monitored by epoll_wait :
           epoll_ctl ( epoll_fd , EPOLL_CTL_DEL , timeout . data . fd , nullptr );
        }
      }
    }                                                                                                                        20/20
}
