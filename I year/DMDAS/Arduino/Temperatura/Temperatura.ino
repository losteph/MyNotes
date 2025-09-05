#include <WiFi.h>
#include <WiFiUdp.h>
#include <OneWire.h>
#include <DallasTemperature.h>


const unsigned long DEBOUNCE_DELAY = 200;
const int ONE_WIRE_BUS = 4;  // provare a passarlo a define
const char* ssid = "Galaxy 22";        // Nome della rete WiFi
const char* password = "giuseppe"; // Password WiFi
const int udpPort = 1235; // Porta UDP su cui il server ascolta
char packetBuffer[255];   // Buffer per memorizzare i dati ricevuti
unsigned long previousMillis = 0;
bool connesso = false;

WiFiUDP udp;
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensore18(&oneWire);



void setup() {
    Serial.begin(115200);
    sensore18.begin();
    Serial.println("Inizializzazione DS18B20 completata");
}



void loop() {

  if(connesso == false){
    
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
    connesso = 0;
  }else{
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
         udp.beginPacket(udp.remoteIP(), udp.remotePort());    
         Serial.print("Temperatura DS18: ");
         sensore18.requestTemperatures();
         float tempC = sensore18.getTempCByIndex(0);
         Serial.print(tempC);
         Serial.println(" °C  ");
         udp.print(tempC); 
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
