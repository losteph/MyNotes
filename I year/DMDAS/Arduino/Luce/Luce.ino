#include <WiFi.h>
#include <WiFiUdp.h>

const char* ssid = "Galaxy 22";        // Nome della rete WiFi
const char* password = "giuseppe"; // Password WiFi

WiFiUDP udp;
const int udpPort = 1236; // Porta UDP su cui il server ascolta
char packetBuffer[255];   // Buffer per memorizzare i dati ricevuti

unsigned long previousMillis = 0;
bool connesso = 0;
float luminosita = 0;
float  somma = 0;
float percentuale;


void setup() {
    Serial.begin(115200);
    delay(1000);
}


void loop() {

   if (connesso == 0){
    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connessione WiFi...");
    }

    Serial.println("Connesso al WiFi!");
    Serial.print("IP del server: ");
    Serial.println(WiFi.localIP());
    udp.begin(udpPort); // Avvia il server UDP sulla porta specificata
    Serial.println("Server UDP in ascolto...");
    connesso = true;
   }else if(WiFi.status() != WL_CONNECTED){
    Serial.println("Connessione persa! Tentativo di riconnessione...");
    connesso = false;
  }else{
  //incremento tramte timer ogni secondo 
   unsigned long currentMillis = millis();
   if (currentMillis - previousMillis >= 1000) { // Ogni secondo
    previousMillis = currentMillis;
    }
    int packetSize = udp.parsePacket(); // Controlla se ci sono dati UDP ricevuti
    if (packetSize) {
        Serial.print("Ricevuto pacchetto di ");
        Serial.print(packetSize);
        Serial.println(" byte");
        
        // Legge il pacchetto ricevuto
        int len = udp.read(packetBuffer, 255);
        if (len > 0) {
            packetBuffer[len] = '\0'; // Termina la stringa ricevuta
        }
        Serial.print("Messaggio ricevuto: ");
        Serial.println(packetBuffer);

        // Determina la risposta in base alla richiesta ricevuta
        String richiesta = String(packetBuffer);

        Serial.println(richiesta);
        
        if (richiesta.indexOf("ReqDati") != -1) {
            // Invia la risposta al client
            somma = 0;
             udp.beginPacket(udp.remoteIP(), udp.remotePort());
             for(int i = 0;i <10;i++){
              somma += analogRead(36);
              delay(20);
             }

             luminosita = somma/10.0;
             
             percentuale = (luminosita/4095.0)*100;
             
             Serial.println(percentuale);
             udp.print(percentuale);
             udp.endPacket();
        }else if(richiesta.indexOf("Info") != -1 ){ 
          // Invia la risposta al client
            String res = "ResInfo" + WiFi.localIP().toString();
            udp.beginPacket(udp.remoteIP(), udp.remotePort());
            Serial.println(res);
            udp.print(res);
            udp.endPacket();
        }else{
          String mes = "non va";
          udp.beginPacket(udp.remoteIP(), udp.remotePort());
            udp.print(mes);
            udp.endPacket();
        }
        Serial.println("Risposta inviata!");
    }
  }
}
