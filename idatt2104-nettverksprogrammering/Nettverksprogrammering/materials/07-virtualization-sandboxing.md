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

    Virtualisering                                                                                                                      Fakultet for arkitektur og design


                                                                                                                                                                 Fakultet for arkitektur og design
                                                                                                                                                                 Institutt for design


                                                                                                                                                                                                      KONTRASTER

                                                                                                                                        Fakultet for arkitektur og design
                                                                                                                                                                                                      Husk alltid å vurder lesbarheten på logoen ved å sjekke
                                                                     Se alle logovarianter på Innsida                                   Institutt for design                                          at det er god nok kontrast mot bakgrunnen.


6                                                                                                                                                                                                                                                                           7




    Ole C. Eidheim
    February 17, 2026
    Department of Computer Science
Oversikt



Virtualisering og sandboxing



Unikernels



Øving P5




                               1/15
Virtualisering vs sandboxing: isolering av system eller applikasjoner




                                             • OS-nivå virtualisering (applikasjon
                                               sandboxing)
   • Full Virtualisering (sandboxing av et   • Eksempler:
     helt system)                                 • Docker
                                                  • Desktopapplikasjoner med Flatpak
   • Eksempler: VirtualBox og VMWare
                                                  • Nettsider i en nettleser (?)
                                                                                       2/15
OS-nivå virtualisering, filsystem: chroot


   # Prepare new root folder :
   mkdir new_root
   cd new_root
   mkdir bin lib64 usr usr / lib
   cp / bin / bash bin /
   cp / bin / ls bin /
   ldd / bin / bash
   # Copy all the output libraries , excluding linux - vdso . so .1 ,
   # to one of the corresponding lib - folders in new_root /.
   # For instance : cp / usr / lib / libreadline . so .8 usr / lib
   ldd / bin / ls
   # Copy all the output libraries , excluding linux - vdso . so .1 ,
   # to one of the corresponding lib - folders in new_root /.

   # Change root folder :
   sudo chroot . / bin / bash # / bin / bash is run after changing root

   # Test new root folder
   ls / # Output : / bin / lib64 / usr




                                                                          3/15
OS-nivå virtualisering, filsystem og prosesser: Linux namespaces




 • chroot: isolerer kun filsystemet
 • Linux Namespaces: isolerer på alle nivå
   gjennom ulike namespace typer, for
   eksempel:
      • mnt: som chroot men kan kombineres
        med for eksempel pid
      • pid: isolerer prosesser, for eksempel:
           • Prosess med id 7 kan se alle prosesser
           • Prosess 9 kan bare se 8, 9 og 10, men
             ser disse som 1, 2 og 3




                                                                    4/15
OS-nivå virtualisering, prosesser: Linux namespaces
   // Must be run as root

   # include   < iostream >
   # include   < sched .h >
   # include   < stdlib .h >
   # include   < sys / wait .h >
   # include   < unistd .h >

   using namespace std ;

   int main () {
     char child_stack [1048576]; // Stack for the child process , 1024 * 1024 bytes

       // Create child process in new PID namespace
       pid_t pid = clone ([]( void *) {
          cout << " Child namespace PID : " << getpid () << endl ; // Output : 1
          return 0;
       } , child_stack + 1048576 /* stack grows downwards */ , CLONE_NEWPID , nullptr );

       cout << " Main PID : " << getpid () << endl ;       // Example output : 9838
       cout << " Parent namespace PID : " << pid << endl ; // Example output : 9839

       waitpid ( pid , nullptr , 0); // Wait for child process to exit
   }

                                                                                           5/15
OS-nivå virtualisering: Docker

   Bruker Linux namespaces og kan da gjenbruke vertsoperativsystemet:




                                                                        6/15
OS-nivå virtualisering: Docker eksempel




     • Kan bruke ferdige oppsatte docker images fra https://hub.docker.com
     • For eksempel her startes bash i et docker image som inneholder siste Debian
       stable:
         • docker run -ti --rm debian:latest /bin/bash
              • -ti: for å kunne lese og skrive til bash i en terminal
              • --rm: slett docker containeren ved avslutning




                                                                                     7/15
OS-nivå virtualisering: bygge egne Docker images



   Eksempel Dockerfile:
   # Use Debian stable as base image
   FROM debian : stable
   # Upgrade packages
   RUN apt - get -y update
   # Install python
   RUN apt - get -y install python3


   Bygges med:
   docker build -t python - image .


   Kjøres med:
   docker run -- rm python - image python3 -c " print (\" Hello World \") "
   # eller for å starte bash i kontaineren :
   docker run - ti -- rm python - image / bin / bash



                                                                              8/15
OS-nivå virtualisering: Flatpak, pakkede desktop applikasjoner




   Bruker Linux namespaces og kan kjøres i alle Linux distribusjoner
                                                                       9/15
Oversikt



Virtualisering og sandboxing



Unikernels



Øving P5




                               10/15
Unikernels

     • Unikernel applikasjoner bruker et minimalistisk operativsystem (unikernel) med
       kun de nødvendige bibliotekene for å kjøre applikasjonen (library operating
       system)
         • Mindre ressurskrevende og potensielt sikrere




                                                                                        11/15
Unikernels: kodeeksempel fra IncludeOS


   # include <os >
   # include < iostream >
   # include < net / interfaces >

   void Service :: start () {
     // Get the IP stack thats already been automatically configured
     auto inet = net :: Interfaces :: get (0);
     // Setup a TCP echo server on port 7 ( echo port )
     auto server = inet . tcp (). listen (7);

       server . on_connect ([] ( auto conn ) {
         // Log incomming connections on the console :
         std :: cout << " Connection " << conn - > to_string () << " established \ n " ;
         // When data is received , echo back
         conn - > on_read (1024 , [ conn ]( auto buf ) {
           conn - > write ( buf );
         });
       });
   }




                                                                                           12/15
Oversikt



Virtualisering og sandboxing



Unikernels



Øving P5




                               13/15
Øving P5, forberedelse: installasjon og oppsett av Docker


   Instruksjonene er for den anbefalte Linux distribusjonen Manjaro, men andre
   distribusjoner (eller operativsystemer som støtter Docker) kan brukes.


   Dokumentasjon: https://wiki.archlinux.org/index.php/Docker
   sudo   pacman - Syuu # Update system
   sudo   pacman -S docker # Install docker
   sudo   systemctl start docker # Start docker service
   sudo   systemctl enable docker # Enable docker service to be started on bootup

   # To enable running docker as a regular user ,
   # add yourself ( $USER ) to docker group :
   sudo usermod - aG docker $USER
   # Finally , log out and back in to reevaluate group memberships




   Se neste slide

                                                                                    14/15
Øving P5

• Lag en nettside som lar deg (kompilere og) kjøre
  kildekode som blir skrevet inn
    • Resultatet skal vises på nettsiden
• Bruk Docker til å (kompilere og) kjøre kildekoden
  trygt på serversiden
• Valgfritt programmeringsspråk (JavaScript og
  Python kan også brukes)
    • Gjelder både implementasjonen av web
      applikasjonen og programmeringsspråk som skal
      (kompileres og) kjøres i web applikasjonen




                                                       15/15
