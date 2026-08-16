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

    Atomic typer, parallellisering og prosesser                                                                                         Fakultet for arkitektur og design


                                                                                                                                                                 Fakultet for arkitektur og design
                                                                                                                                                                 Institutt for design


                                                                                                                                                                                                      KONTRASTER

                                                                                                                                        Fakultet for arkitektur og design
                                                                                                                                                                                                      Husk alltid å vurder lesbarheten på logoen ved å sjekke
                                                                     Se alle logovarianter på Innsida                                   Institutt for design                                          at det er god nok kontrast mot bakgrunnen.


6                                                                                                                                                                                                                                                                           7




    Ole C. Eidheim
    January 13, 2026
    Department of Computer Science
Oversikt



Atomic-typer



CPU/GPU parallellisering



Prosesser




                           1/24
Atomic-typer
- trenger ikke å bli beskyttet av mutex

   Ulempe: bare enkle datatyper som int og float kan gjøres atomic.
   # include < atomic >
   # include < iostream >
   # include < thread >

   using namespace std ;

   int main () {
     atomic < int > sum (0);

       thread t1 ([& sum ]() {
          for ( int c = 0; c < 1000; c ++)
             sum ++;
       });
       thread t2 ([& sum ]() {
          for ( int c = 0; c < 1000; c ++)
             sum ++;
       });
       t1 . join ();
       t2 . join ();

       cout << sum << endl ; // Output : 2000
   }
                                                                      2/24
Atomic-typer
- handtering av tilstand i flere tråder
   # include < iostream >
   # include < thread >

   using namespace std ;

   enum class State { sitting , standing_up , standing };

   int main () {
     atomic < State > state ( State :: sitting );

       thread ([& state ] { /* Draw animation frames based on state */ });

       while ( true ) { // Handle input
         if ( /* keypress */ ) {
           // Stand up if sitting :
           auto expected = State :: sitting ;
           if ( state . c o m p a r e _ e x c h a n g e _ s t r o n g ( expected , State :: standing_up )) {
              // Standing up , play squeaky chair sound
           }
         }
       }                    Legg merke til den spesielle funksjonen
   }
                              compare exchange strong(), og at vi slipper å bruke mutex
                              selv om vi både leser og skriver til state.                                     3/24
Mer om atomic-typer
- referansetelling

  • En form for garbage    # include < iostream >
                           # include < thread >
    collection der et
                           using namespace std ;
    objekt blir frigjort
    når det ikke lenger   int main () {
                             thread t ;
    blir brukt               {
                                 std :: shared_ptr < int > ref_counted ( new int (42));
  • Kan være nyttig i            t = thread ([ ref_counted ] {      // ref_counted is copied to thread
    trådprogrammering             this_thread :: sleep_for (1 s ); // Wait 1 second
                                   cout << " value from thread : " << * ref_counted << endl ;
    der en ikke vet i              cout << " count from thread : " << ref_counted . use_count () << endl ;
                                   // The last ref_counted object is destroyed at end of thread ,
    hvilken tråd et               // and its int value is then freed from memory
    objekt brukes for            });
                                 cout << " value : " << * ref_counted << endl ;
    siste gang                   cout << " count : " << ref_counted . use_count () << endl ;
                                 // One ref_counted object is destroyed at end of scope ,
Eksempler:                       // and its use_count is reduced by 1
                             }
  • C++:                     t . join ();
    std::shared ptr        }
                           // Output :
  • Rust: std::sync::Arc   // value : 42
                           // count : 2
    (Atomically            // value from thread : 42
    Reference Counted)     // count from thread : 1
                                                                                                      4/24
Mer om atomic-typer
- referansetelling, men ikke trådsikker
# include < iostream >                                               int main () {
# include < thread >                                                   thread t ;
using namespace std ;                                                  {
                                                                         RefCountedInt ref_counted (42);
class RefCountedInt {
public :                                                                 // ref_counted is copied to thread
  class Object {                                                         t = thread ([ ref_counted ] {
  public :                                                                 this_thread :: sleep_for (1 s );
     int value ;                                                           cout << ref_counted . object - > count << endl ;
     int count ;                                                         });
     Object ( int value_ ) : value ( value_ ) , count (1) {}
  };                                                                     cout << ref_counted . object - > count << endl ;
  Object * object ;                                                    }
                                                                       t . join ();
     RefCountedInt ( int value ) : object ( new Object ( value )) {    }
        cout << " constructor " << endl ;                              // Output :
     }                                                                 // constructor
     ~ RefCountedInt () {                                              // copy constructor
        cout << " destructor " << endl ;                               // 2
        object - > count - -;                                          // destructor
        if ( object - > count == 0) {                                  // 1
          cout << " deleting object " << endl ;                        // destructor
          delete object ;                                              // deleting object
        }
     }
     RefCountedInt ( const RefCountedInt & other ) {            Ikke så farlig om du ikke forstår all koden i
        cout << " copy constructor " << endl ;
        object = other . object ;                               venstre kolonne, men se forskjellene på neste
        object - > count ++;                                    slide.
     }                                                                                                                        5/24
};
Mer om atomic-typer
- trådsikker referansetelling med atomic
# include < iostream >                                              int main () {
# include < thread >                                                  thread t ;
using namespace std ;                                                 {
                                                                        RefCountedInt ref_counted (42);
class RefCountedInt {
public :                                                                 // ref_counted is copied to thread
  class Object {                                                         t = thread ([ ref_counted ] {
  public :                                                                 this_thread :: sleep_for (1 s );
     int value ;                                                           cout << ref_counted . object - > count << endl ;
     atomic < int > count ;                                              });
     Object ( int value_ ) : value ( value_ ) , count (1) {}
  };                                                                     cout << ref_counted . object - > count << endl ;
  Object * object ;                                                    }
                                                                       t . join ();
     RefCountedInt ( int value ) : object ( new Object ( value )) {    }
        cout << " constructor " << endl ;                              // Output :
     }                                                                 // constructor
     ~ RefCountedInt () {                                              // copy constructor
        cout << " destructor " << endl ;                               // 2
        auto previous _count = object - > count . fetch_sub (1);       // destructor
        if ( previous_count == 1) {                                    // 1
          cout << " deleting object " << endl ;                        // destructor
          delete object ;                                              // deleting object
        }
     }
     RefCountedInt ( const RefCountedInt & other ) {             Legg merke til den spesielle funksjonen
        cout << " copy constructor " << endl ;
        object = other . object ;                                fetch sub().
        object - > count ++;
     }                                                                                                                        6/24
};
Oversikt



Atomic-typer



CPU/GPU parallellisering



Prosesser




                           7/24
Parallellisering CPU vs GPU




                              8/24
CPU parallellisering
- skal parallellisere dette



   # include < iostream >
   # include < vector >

   using namespace std ;

   int main () {
     vector < int > a = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
     vector < int > b = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
     vector < int > c (10);

       for ( int i = 0; i < 10; i ++) {
         c [ i ] = a [ i ] + b [ i ];
       }

       // c : 0 2 4 3 5 7 6 8 10 9
   }




                                                                   9/24
CPU parallellisering
- manuell tungvint løsning, kun CPU
   # include < iostream >
   # include < thread >
   # include < vector >

   using namespace std ;

   int main () {
     vector < int > a = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
     vector < int > b = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
     vector < int > c (10);

       vector < thread > threads ;
       for ( int thread_number = 0; thread_number < 5; thread_number ++) {
         threads . emplace_back ([ thread_number , &a , &b , & c ] {
           for ( int i = thread_number * 2; i <= thread_number * 2 + 1; i ++)
              c [ i ] = a [ i ] + b [ i ];
         });
       }

       for ( auto & t : threads )
         t . join ();

       // c : 0 2 4 3 5 7 6 8 10 9
   }
                                                                                10/24
Suboptimal CPU parallellisering
- OpenMP (Open Multi-Processing)


  # include < iostream >
  # include < vector >

  using namespace std ;

  int main () {
    vector < int > a = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
    vector < int > b = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
    vector < int > c (10);

  # pragma omp parallel for
     for ( int i = 0; i < 10; i ++) {
       c [ i ] = a [ i ] + b [ i ];
     }

    // c : 0 2 4 3 5 7 6 8 10 9
  }
  // Compile with g ++ and add the flag - fopenmp




                                                                  11/24
CPU parallellisering
- std::algorithm før c++17 ingen parallellisering


   # include < algorithm >
   # include < iostream >
   # include < vector >

   using namespace std ;

   int main () {
     vector < int > a = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
     vector < int > b = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
     vector < int > c (10);

       transform ( a . begin () , a . end () , b . begin () , c . begin () ,
                   []( int a_element , int b_element ) {
         return a_element + b_element ;
       });

       // c : 0 2 4 3 5 7 6 8 10 9
   }




                                                                               12/24
CPU(/fremtidig GPU?) parallellisering
- std::algorithm c++17

   # include   < algorithm >
   # include   < execution >
   # include   < iostream >
   # include   < vector >

   using namespace std ;

   int main () {
     vector < int > a = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
     vector < int > b = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
     vector < int > c (10);

     transform ( execution :: par , a . begin () , a . end () , b . begin () , c . begin () ,
                 []( int a_element , int b_element ) {
       return a_element + b_element ;
     });

     // c : 0 2 4 3 5 7 6 8 10 9
   }
   // Compile using a newer g ++ version with the flags : - ltbb - std = c ++17



                                                                                                13/24
GPU parallellisering
- Komplisert OpenCL (Open Computing Language) kode
  int a [10] = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
  int b [10] = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
  int c [10];

  string kernel_code =
      " void kernel simple_add ( global const int * a , global const int * b , global int * c ) { "
      "    c [ get_global_id (0)] = a [ get_global_id (0)] + b [ get_global_id (0)]; "
      "}";

  cl :: Program program ( /* choose kernel_code and OpenCL parameters */ );
  cl :: Kernel kernel_add = cl :: Kernel ( program , " simple_add " );

  cl :: CommandQueue queue ( /* OpenCL parameters */ );
  cl :: Buffer device_a ( /* OpenCL parameter */ , CL_MEM_READ_WRITE ,                 sizeof ( int ) * 10);
  cl :: Buffer device_b ( /* OpenCL parameter */ , CL_MEM_READ_WRITE ,                 sizeof ( int ) * 10);
  cl :: Buffer device_c ( /* OpenCL parameter */ , CL_MEM_READ_WRITE ,                 sizeof ( int ) * 10);
  queue . e n qu e ue Wr i te B uf fe r ( device_a , CL_TRUE , 0 , sizeof ( int ) *    10 , a );
  queue . e n qu e ue Wr i te B uf fe r ( device_b , CL_TRUE , 0 , sizeof ( int ) *    10 , b );
  kernel_add . setArg (0 , device_a );
  kernel_add . setArg (1 , device_b );
  kernel_add . setArg (2 , device_c );

  // The program is run on the chosen device , e . g . GPU :
  queue . e n q u e u e N D R a n g e K e r n e l ( kernel_add , cl :: NullRange , cl :: NDRange (10) , cl :: NullRange );
  queue . finish ();
  queue . en que ueR ead Buf fer ( device_c , CL_TRUE , 0 , sizeof ( int ) * 10 , c );
                                                                                                                             14/24
  // c : 0 2 4 3 5 7 6 8 10 9
GPU parallellisering
- Boost.Compute (se eksempelet her)
   # include < boost / compute / algorithm / transform . hpp >
   # include < boost / compute / container / vector . hpp >
   # include < iostream >

   using namespace std ;
   namespace compute = boost :: compute ;

   int main () {
     auto device = compute :: system :: defau lt_device ();
     compute :: context context ( device );
     compute :: command_queue queue ( context , device );

       vector < int > a = {0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9};
       vector < int > b = {0 , 1 , 2 , 0 , 1 , 2 , 0 , 1 , 2 , 0};
       vector < int > c (10);

       compute :: vector < int > device_a ( a . size () , context );
       compute :: vector < int > device_b ( b . size () , context );
       compute :: copy ( a . begin () , a . end () , device_a . begin () , queue );
       compute :: copy ( b . begin () , b . end () , device_b . begin () , queue );

       compute :: vector < int > device_c ( c . size () , context );
       compute :: transform ( device_a . begin () , device_a . end () ,
                               device_b . begin () , device_c . begin () , compute :: plus < int >() , queue );
       compute :: copy ( device_c . begin () , device_c . end () , c . begin () , queue );

       // c : 0 2 4 3 5 7 6 8 10 9
                                                                                                                  15/24
   }
Andre CPU/GPU parallelliseringsbiblioteker



     • ArrayFire
         • Startet i 2014
         • C++ bibliotek
         • Støtter CUDA, OpenCL og CPU
     • Kompute
         • Startet i 2020
         • C++ bibliotek
         • Støtter CUDA, OpenCL og Vulkan
     • wgpu
         • Startet i 2022
         • Rust bibliotek
         • Støtter Vulkan, Metal, DX12, WebGPU



                                                 16/24
Oversikt



Atomic-typer



CPU/GPU parallellisering



Prosesser




                           17/24
Prosesser




     • Tråder
         • Kjører i delt minneområde
                 • Programmeringsfeil kan føre til at en tråd får tilgang til minneområdet til en annen
                   tråd
         • Krasj i en tråd krasjer hele programmet
     • Prosesser
         • Kjører i separate minneområder
                 • Sikrere mot programmeringsfeil, men kommunikasjon mellom prosesser er mer
                   ressurskrevende
         • En krasj vil ikke påvirke andre prosesser




                                                                                                             18/24
Prosesser, lese data fra prosess
- eksempler med tiny-process-library



   # include " process . hpp "
   # include < iostream >

   using namespace std ;
   using namespace TinyPro cessLib ;

   int main () {
     Process process ( " echo Hello World " , {} ,
                       []( const char * bytes , size_t n ) {
                          cout << string ( bytes , n ); // Output : Hello World
                       });

       cout << process . ge t_ e xi t_ st a tu s () << endl ;   // Output : 0
   }




                                                                                  19/24
Prosesser, lese data fra prosess
- eksempler med tiny-process-library


   # include " process . hpp "
   # include < iostream >

   using namespace std ;
   using namespace TinyPro cessLib ;

   int main () {
     Process process ( " cat n o n e x i s t e n t _ f i l e " , {} ,
                       []( const char * bytes , size_t n ) {
                          cout << string ( bytes , n ); // No output
                       } , []( const char * bytes , size_t n ) {
                          // Output : n o n e x i s t e n t _ f i l e : No such file or directory
                          cout << string ( bytes , n );
                       });

       cout << process . ge t_ e xi t_ st a tu s () << endl ; // Output : 1
   }




                                                                                                    20/24
Prosesser, lese data fra inline prosess
- eksempler med tiny-process-library

   # include " process . hpp "
   # include < iostream >

   using namespace std ;
   using namespace TinyPro cessLib ;

   int main () {
     Process process ([] { // Does not work on Windows
                             // where an executable file is needed
        cout << " Hello " << endl ;
        cerr << " World " << endl ;
        exit (10);
     } , []( const char * bytes , size_t n ) {
        cout << string ( bytes , n ); // Output : Hello
     } , []( const char * bytes , size_t n ) {
        cout << string ( bytes , n ); // Output : World
     });

       cout << process . get_ e xi t_ st a tu s () << endl ; // Output : 10
   }



                                                                              21/24
Prosesser, inline prosess
- eksempler med tiny-process-library

   Hva skjer her?
   # include " process . hpp "
   # include < iostream >

   using namespace std ;
   using namespace TinyPro cessLib ;

   int main () {
     int a = 42;

       Process process ([& a ] { // Does not work on Windows
                                  // where an executable file is needed
          a ++;
          cout << a << endl ;
          exit (0);
       } , []( const char * data , size_t n ) {
          cout << string ( data , n );
       });

       cout << process . get_ e xi t_ st a tu s () << endl ; // Output : 0

       cout << a << endl ;
   }
                                                                             22/24
Prosesser, inline prosess
- eksempler med tiny-process-library

   Hva skjer her?
   # include " process . hpp "
   # include < iostream >

   using namespace std ;
   using namespace TinyPro cessLib ;

   int main () {
     int a = 42;

       Process process ([& a ] { // Does not work on Windows
                                  // where an executable file is needed
          a ++;
          cout << a << endl ;
          exit (0);
       } , []( const char * data , size_t n ) {
          cout << string ( data , n ); // Output : 43
       });

       cout << process . get_ e xi t_ st a tu s () << endl ; // Output : 0

       cout << a << endl ; // Output 42
   }
                                                                             23/24
Prosesser, skrive til og lese data fra prosess
- eksempler med tiny-process-library


   # include " process . hpp "
   # include < iostream >

   using namespace std ;
   using namespace TinyPro cessLib ;

   int main () {
     Process process ( " cat " , {} ,
                       []( const char * bytes , size_t n ) {
                          cout << string ( bytes , n ); // Output : Hello World
                       } , nullptr /* no stderr */ , true /* open stdin */ );

       process . write ( " Hello World \ n " );
       process . close_stdin ();

       cout << process . ge t_ e xi t_ st a tu s () << endl ; // Output : 0
   }




                                                                                  24/24
