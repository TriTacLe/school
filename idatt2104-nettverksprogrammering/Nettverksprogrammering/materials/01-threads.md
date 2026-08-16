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

    Programmeringsspråk og tråder                                                                                                     Fakultet for arkitektur og design


                                                                                                                                                                 Fakultet for arkitektur og design
                                                                                                                                                                 Institutt for design


                                                                                                                                                                                                      KONTRASTER

                                                                                                                                        Fakultet for arkitektur og design
                                                                                                                                                                                                      Husk alltid å vurder lesbarheten på logoen ved å sjekke
                                                                     Se alle logovarianter på Innsida                                   Institutt for design                                          at det er god nok kontrast mot bakgrunnen.


6                                                                                                                                                                                                                                                                           7




    Ole C. Eidheim
    January 6, 2026
    Department of Computer Science
Oversikt



Øving P1



Sammenligning av C++, Rust og Java



Prosesser og tråder




                                     1/16
Øving P1


    • Finn alle primtall mellom to gitte tall ved hjelp av et gitt antall tråder.
         • Skriv til slutt ut en sortert liste av alle primtall som er funnet
         • Pass på at de ulike trådene får omtrent like mye arbeid
         • Valgfritt programmeringsspråk, men bruk gjerne et programmeringsspråk dere
           ikke har prøvd før (ikke Python), eller for de som vil ha litt extra utfordring: Rust
           eller C++
              • De som vil bruke Rust eller C++ kan ta utgangspunkt i threads




    • Største primtall funnet (2016): 274207281 − 1
         • Great Internet Mersenne Prime Search
              • 348 708 000 GFLOP/sec (januar 2017)
              • Ole’s Mac: 640 GFLOP/sec (grafikkortet)


                                                                                                   2/16
Oversikt



Øving P1



Sammenligning av C++, Rust og Java



Prosesser og tråder




                                     3/16
Repitisjon: vector/array, list og iteratorer
- iteratorer generaliserer lesing og skriving til konteinere

                                            # include < iostream >
                                            # include < list >
                                            # include < vector >

                                            using namespace std ;

                                            int main () {
                                              {
                                                vector < char > vec = { ’A ’ , ’B ’ };
                                                auto it = vec . begin ();
                                                cout << * it ;             // Output :   A
                                                it ++;
                                                cout << * it << endl ; // Output :       B
                                              }
                                              {
                                                list < char > lst = { ’A ’ , ’B ’ };
                                                auto it = lst . begin ();
                                                cout << * it ;             // Output :   A
                                                it ++;
                                                cout << * it << endl ; // Output :       B
                                              }
                                            }

                                                                                             4/16
Sammenligning av Java, C++ og Rust

    • Eksempel: iterator-invalidation
        • Java gjør at du slipper å tenke på levetid, men det er lett å skrive andre typer feil
        • C++ har i utgangspunktet få begrensninger, og det er svært lett for uerfarne
          programmerere å gjøre feil
             • Derimot jobbes det mot bedre statiske sjekker som finner vanlige feil som nye
               programmerere gjør (se eksempel)
        • Rust setter strenge begrensninger på hvordan du kan skrive kode, og beskytter deg
          fra å gjøre vanlige feil
             • Men kan være vanskeligere å lese logikken i koden




                                                                                                     5/16
Sammenligning av Java, C++ og Rust

    • Eksempel: iterator-invalidation
        • Java gjør at du slipper å tenke på levetid, men det er lett å skrive andre typer feil
        • C++ har i utgangspunktet få begrensninger, og det er svært lett for uerfarne
          programmerere å gjøre feil
             • Derimot jobbes det mot bedre statiske sjekker som finner vanlige feil som nye
               programmerere gjør (se eksempel)
        • Rust setter strenge begrensninger på hvordan du kan skrive kode, og beskytter deg
          fra å gjøre vanlige feil
             • Men kan være vanskeligere å lese logikken i koden
    • Både C++ og Rust er systemprogrammeringsspråk som genererer svært kjappe og
      minneeffektive program og programvarebiblioteker
        • Rust er svært nytt men har noen nye idèer som er interessante
        • Stort sett alle program og programvarebiblioteker er per i dag indirekte eller direkte
          skrevet i C/C++
             • C er et lavnivå programmeringsspråk, C++ er en utvidelse av C som gjør at en kan
               skrive høynivå kode på en enklere måte

                                                                                                     5/16
Oversikt



Øving P1



Sammenligning av C++, Rust og Java



Prosesser og tråder




                                     6/16
Prosesser og tråder




                       7/16
Trådeksempel i C++: enkel demonstrasjon av bruk av felles data

   # include < iostream >
   # include < thread >

   using namespace std ;

   int main () {
     int sum = 0;

       thread t1 ([& sum ] {
         for ( int i = 0; i < 1000; i ++)
           sum ++;
       });
       thread t2 ([& sum ] {
         for ( int i = 0; i < 1000; i ++)
           sum ++;
       });

       t1 . join ();
       t2 . join ();

       cout << sum << endl ;
   }



                                                                  8/16
Samtidig lesing og skriving




                              9/16
Trådeksempel i C++, forbedret 1
   # include < iostream >
   # include < mutex >
   # include < thread >

   using namespace std ;

   int main () {
     int sum = 0;
     mutex sum_mutex ; // Used to make sure that only one thread accesses sum at any time

     thread t1 ([& sum , & sum_mutex ] {
       for ( int i = 0; i < 1000; i ++) {
         sum_mutex . lock (); // If sum_mutex is   already locked , wait until unlocked , then lock
         sum ++;
         sum_mutex . unlock (); // sum_mutex can   now be locked elsewhere
       }
     });
     thread t2 ([& sum , & sum_mutex ] {
       for ( int i = 0; i < 1000; i ++) {
         sum_mutex . lock (); // If sum_mutex is   already locked , wait until unlocked , then lock
         sum ++;
         sum_mutex . unlock (); // sum_mutex can   now be locked elsewhere
       }
     });

     t1 . join ();
     t2 . join ();

     cout << sum << endl ;
   }
   // Output : 2000                                                                                   10/16
Trådeksempel i C++, forbedret 2
   # include < iostream >
   # include < mutex >
   # include < thread >

   using namespace std ;

   int main () {
     int sum = 0;
     mutex sum_mutex ; // Used to make sure that only one thread accesses sum at any time

     thread t1 ([& sum , & sum_mutex ] {
       for ( int i = 0; i < 1000; i ++) {
         unique_lock < mutex > lock ( sum_mutex ); // Locks sum_mutex
         sum ++;
         // Unlocks sum_mutex when lock is destroyed at end of scope
       }
     });
     thread t2 ([& sum , & sum_mutex ] {
       for ( int i = 0; i < 1000; i ++) {
         unique_lock < mutex > lock ( sum_mutex ); // Locks sum_mutex
         sum ++;
         // Unlocks sum_mutex when lock is destroyed at end of scope
       }
     });

     t1 . join ();
     t2 . join ();

     cout << sum << endl ;
   }
   // Output : 2000                                                                         11/16
Trådeksempel i C++, forbedret 3

   Fra cpp-thread-safety-analysis:
   class Main { // Thread Safety Analysis only applies to classes
   public :
     int sum GUARDED_BY ( sum_mutex ) = 0; // Extra annontation to restrict access to sum
     Mutex sum_mutex ;

        Main () {
          thread t1 ([ this ] { // Captures current    instance ( this ) for access to sum and sum_mutex
             for ( int i = 0; i < 1000; i ++) {
               LockGuard lock ( sum_mutex ); // Must   lock the mutex to access sum
               sum ++;
             }
          });
          thread t2 ([ this ] { // Captures current    instance ( this ) for access to sum and sum_mutex
             for ( int i = 0; i < 1000; i ++) {
               LockGuard lock ( sum_mutex ); // Must   lock the mutex to access sum
               sum ++;
             }
          });

            t1 . join ();
            t2 . join ();

            LockGuard lock ( sum_mutex ); // Must lock the mutex to access sum
            cout << sum << endl ;
        }
   };

   int main () {
     Main ();
   } // Output : 2000                                                                                      12/16
Trådeksempel i Rust
   use std :: sync ::{ Arc , Mutex };
   use std :: thread ;

   fn main () {
     // Arc : thread - safe reference counted object .
     // Mutex : data and mutex combined , where the data cannot be access without locking the mutex
     let sum_mutex_arc = Arc :: new ( Mutex :: new (0));

     let s um _ mu t ex _a r c_ c op y = sum_mutex_arc . clone ();
     let t1 = thread :: spawn ( move || {
       for i in 0..1000 {
         // Access the data by locking the Mutex object
         let mut sum_locked = su m _m u te x_ a rc _ co py . lock (). unwrap ();
         * sum_locked += 1; // Access the locked data throught the operator *
         // The Mutex object is unlocked at end of scope
       }
     });
     let s um _ mu t ex _a r c_ c op y = sum_mutex_arc . clone ();
     let t2 = thread :: spawn ( move || {
       for i in 0..1000 {
         // Access the data by locking the Mutex object
         let mut sum_locked = su m _m u te x_ a rc _ co py . lock (). unwrap ();
         * sum_locked += 1; // Access the locked data throught the operator *
         // The Mutex object is unlocked at end of scope
       }
     });

     t1 . join ();
     t2 . join ();
     // Cannot access data without calling lock () , even though locking is unnecessary .
     println! ( " {} " , * sum_mutex_arc . lock (). unwrap ())
                                                                                               13/16
   } // Output : 2000
Deadlocks: uendelig venting på at en mutex skal bli låst opp

   Rust beskytter deg ikke mot deadlocks, men det gjør C++ Thread Safety Analysis
   class Main { // Thread Safety Analysis only applies to classes
   public :
     int sum GUARDED_BY ( sum_mutex ) = 0; // Extra annontation to restrict access to sum
     Mutex sum_mutex ;

        Main () {
          thread t1 ([ this ] {
             for ( int i = 0; i < 1000; i ++) {
               LockGuard lock1 ( sum_mutex );
               LockGuard lock2 ( sum_mutex ); // Warning : sum_mutex is already locked
               sum ++;
             }
          });

            t1 . join ();

            LockGuard lock ( sum_mutex );
            cout << sum << endl ;
        }
   };

   int main () {
     Main ();
   } // Output : 2000                                                                    14/16
Deadlocks: uendelig venting på at en mutex skal bli låst opp

   Rust beskytter deg ikke mot deadlocks, men det gjør C++ Thread Safety Analysis
   class Main { // Thread Safety Analysis only applies to classes
   public :
     int sum GUARDED_BY ( sum_mutex ) = 0; // Extra annontation to restrict access to sum
     Mutex sum_mutex ;

        Main () {
          thread t1 ([ this ] {
             for ( int i = 0; i < 1000; i ++) {
               sum_mutex . lock (); // Locks mutex instead of using lock guard
               sum ++;
               // Warning : sum_mutex is still locked
             }
          });

            t1 . join ();

            LockGuard lock ( sum_mutex );
            cout << sum << endl ;
        }
   };

   int main () {
     Main ();
   } // Output : 2000                                                               15/16
Tråder: overhead

   Ikke alltid fornuftig å dele oppgaver i tråder:




                                                       16/16
