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

    WebSocket                                                                                                                           Fakultet for arkitektur og design


                                                                                                                                                                 Fakultet for arkitektur og design
                                                                                                                                                                 Institutt for design


                                                                                                                                                                                                      KONTRASTER

                                                                                                                                        Fakultet for arkitektur og design
                                                                                                                                                                                                      Husk alltid å vurder lesbarheten på logoen ved å sjekke
                                                                     Se alle logovarianter på Innsida                                   Institutt for design                                          at det er god nok kontrast mot bakgrunnen.


6                                                                                                                                                                                                                                                                           7




    Ole C. Eidheim
    February 20, 2025
    Department of Computer Science
WebSocket protokollen




    • Toveis-kommunikasjon mellom server og klient
        • Kan brukes i nettlesere som alternativ til HTTP
             • Nettlesere støtter ikke vanlige sockets
    • Definert i rfc6455
        • Internet standard skrevet og godkjent av Internet Engineering Task Force




                                                                                     1/6
WebSocket protokollen, handshake:
bruker HTTP først




   GET / HTTP /1.1
   Upgrade : websocket
   Connection : Upgrade
   Sec - WebSocket - Key : x 3 J J H M b D L 1 E z L k h 9 G B h X D w ==
   Sec - WebSocket - Version : 13

   HTTP /1.1 101 Switching Protocols
   Upgrade : websocket
   Connection : Upgrade
   Sec - WebSocket - Accept : H S m r c 0 s M l Y U k A G m m 5 O P p G 2 H a G W k =




                                                                                        2/6
WebSocket protokollen, handshake:
Sec-WebSocket-Key og Sec-WebSocket-Accept


  For å sjekke om serveren faktisk støtter WebSocket:
  Fra klient:
  key = Sec-WebSocket-Key = "x3JJHMbDL1EzLkh9GBhXDw=="



  Fra server (kontrolleres av klient etterpå):
  Sec-WebSocket-Accept = Base64encode(SHA1(key+"258EAFA5-E914-47DA-95CA-C5AB0DC85B11"))

  , der 258EAFA5-E914-47DA-95CA-C5AB0DC85B11 er en konstant fra rfc6455 standarden
  = Base64encode(SHA1("x3JJHMbDL1EzLkh9GBhXDw==258EAFA5-E914-47DA-95CA-C5AB0DC85B11"))

  = "HSmrc0sMlYUkAGmm5OPpG2HaGWk="



                                                                                          3/6
WebSocket protokollen, handshake og meldinger

GET / HTTP /1.1
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Key : x 3 J J H M b D L 1 E z L k h 9 G B h X D w ==
Sec - WebSocket - Version : 13

HTTP /1.1 101 Switching Protocols
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Accept : H S m r c 0 s M l Y U k A G m m 5 O P p G 2 H a G W k =




                                                                                     4/6
WebSocket protokollen, handshake og meldinger

GET / HTTP /1.1
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Key : x 3 J J H M b D L 1 E z L k h 9 G B h X D w ==
Sec - WebSocket - Version : 13

HTTP /1.1 101 Switching Protocols
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Accept : H S m r c 0 s M l Y U k A G m m 5 O P p G 2 H a G W k =

.....*..j




                                                                                     4/6
WebSocket protokollen, handshake og meldinger

GET / HTTP /1.1
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Key : x 3 J J H M b D L 1 E z L k h 9 G B h X D w ==
Sec - WebSocket - Version : 13

HTTP /1.1 101 Switching Protocols
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Accept : H S m r c 0 s M l Y U k A G m m 5 O P p G 2 H a G W k =

.....*..j..hei tilbake




                                                                                     4/6
WebSocket protokollen, handshake og meldinger

GET / HTTP /1.1
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Key : x 3 J J H M b D L 1 E z L k h 9 G B h X D w ==
Sec - WebSocket - Version : 13

HTTP /1.1 101 Switching Protocols
Upgrade : websocket
Connection : Upgrade
Sec - WebSocket - Accept : H S m r c 0 s M l Y U k A G m m 5 O P p G 2 H a G W k =

.....*..j..hei tilbake
81 83 b4 b5 03 2a dc d0 6a 81 0b 68 65 69 20 74 69 6c 62 61 6b 65
   • Første byte: angir type melding, der 81 i dette tilfellet betyr tekstmelding
   • Andre byte: for små meldinger (< 126 bytes) angir de 7 minst signifikante bit’ene lengden. Den mest
     signifikante bit’en forteller om meldingen er maskert eller ikke
         • maskering: samme som symmetrisk kryptering, men ”nøkkelstrømmen” (masken) er gitt i de 4 neste bytene
                • Klient masken (”nøkkelstrømmen”): b4 b5 03 2a
         • Klient må alltid maskere meldinger til server, mens server skal aldri maskere meldinger
   • De etterfølgende bytene er meldingen
         • Første byte i melding fra klient (gjennom avmaskering): dc ˆ b4 = 68 = ’h’
                                                                                                                   4/6
WebSocket protokollen: dekoding av meldingen fra klient til server i JavaScript



   Gitt at lengden på meldingen er under 126 bytes:
   let bytes = Buffer . from ([0 x81 , 0 x83 , 0 xb4 , 0 xb5 , 0 x03 , 0 x2a , 0 xdc , 0 xd0 , 0 x6a ]);

   let length = bytes [1] & 127;
   let maskStart = 2;
   let dataStart = maskStart + 4;

   for ( let i = dataStart ; i < dataStart + length ; i ++) {
     let byte = bytes [ i ] ^ bytes [ maskStart + (( i - dataStart ) % 4)];
     console . log ( String . fromCharCode ( byte ));
   }

   //   Output :
   //   h
   //   e
   //   i




                                                                                                           5/6
WebSocket protokollen, handshake og meldinger




   GET / HTTP /1.1
   Upgrade : websocket
   Connection : Upgrade
   Sec - WebSocket - Key : x 3 J J H M b D L 1 E z L k h 9 G B h X D w ==
   Sec - WebSocket - Version : 13

   HTTP /1.1 101 Switching Protocols
   Upgrade : websocket
   Connection : Upgrade
   Sec - WebSocket - Accept : H S m r c 0 s M l Y U k A G m m 5 O P p G 2 H a G W k =


  .....*..j..hei tilbake
  81 83 b4 b5 03 2a dc d0 6a 81 0b 68 65 69 20 74 69 6c 62 61 6b 65
  heihei tilbake




                                                                                        6/6
