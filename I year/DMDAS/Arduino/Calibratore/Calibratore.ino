#include <WiFi.h>
#include <WiFiUdp.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include "DHT.h"


#define DHTPIN 23      // Pin digitale a cui è collegato il sensore
#define DHTTYPE DHT11  // Tipo di sensore: DHT11 o DHT22
#define PULMOD 12
#define BOTTONE 15
#define MAX_VALORI 3


bool buttonPressed = false;          // Indica se il BOTTONE è attualmente premuto
unsigned long buttonPressStart = 0;  // Quando abbiamo premuto il pulsante
const unsigned long PRESS_THRESHOLD = 3000; // 3 secondi per il reset
unsigned long debounceTime = 0;      // Per evitare rimbalzi
const unsigned long DEBOUNCE_DELAY = 200;
bool connesso = 0;
const int ONE_WIRE_BUS = 4;  // provare a passarlo a define
const char* ssid = "Galaxy 22";        // Nome della rete WiFi
const char* password = "giuseppe";    // Password WiFi
const int udpPort = 1234; // Porta UDP su cui il server ascolta
char packetBuffer[255];   // Buffer per memorizzare i dati ricevuti
unsigned long previousMillis = 0;
float valdallas[MAX_VALORI] = { 0 };  // Vettore per salvare le temperature
float valldht11[MAX_VALORI] = { 0 };
int indice = 0;  // Indice per il vettore
bool stato = 0;
bool lastState = 1; 

WiFiUDP udp;
DHT dht(DHTPIN, DHTTYPE);
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensore18(&oneWire);



void setup() {
    Serial.begin(115200);
    delay(1000); 
    
    pinMode(PULMOD,INPUT_PULLUP); // PIN DA MODIFICARE PRIMA DI ACCENDERE ESP BOTTONE PER LA MODALITA TARATORE O SERVER
    sensore18.begin();
    Serial.println("Inizializzazione DS18B20 completata");
    pinMode(BOTTONE, INPUT_PULLUP);
    pinMode(2, OUTPUT);     // led interno all'esp
    dht.begin();
}



void loop() {

bool tarato = false;
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  sensore18.requestTemperatures();
  float tempC = sensore18.getTempCByIndex(0);
  float risultaticoeff[2];
  float valoretarato;
  float media[10];

  bool currentState = digitalRead(PULMOD);
  if (lastState == 1 && currentState == 0) {
    stato = !stato;
    delay(50); 
  }
  lastState = currentState;

  // Siamo in modalità taratore
  if (stato == 0) {
    Serial.println("Mod Taratore");

    Serial.print("Temperatura attuale (dallas18): ");
    Serial.print(tempC);
    Serial.print(" °C     ");
    Serial.print("Temperatura attuale (dht11): ");
    Serial.print(temperature);
    Serial.println(" °C");

    bool bottone = digitalRead(BOTTONE);

    if (bottone == HIGH && !buttonPressed && (millis() - debounceTime > DEBOUNCE_DELAY)) {
      buttonPressed = true;
      buttonPressStart = millis();
      debounceTime = millis();
    }
    if (bottone == LOW && buttonPressed && (millis() - debounceTime > DEBOUNCE_DELAY)) {
      buttonPressed = false;
      debounceTime = millis();

      unsigned long pressDuration = millis() - buttonPressStart;

      if (pressDuration >= PRESS_THRESHOLD) {
        // ---- RESET ----
        Serial.println("Reset dei valori...");
        for (int i = 0; i < MAX_VALORI; i++) {
          valdallas[i] = 0;
          valldht11[i] = 0;
        }
        indice = 0;

        lampeggia();
        lampeggia();
        lampeggia();
      }else{
        if (indice < MAX_VALORI) {
          valdallas[indice] = tempC;
          valldht11[indice] = temperature;
          indice++;
          Serial.println("Valore salvato!");
          lampeggia();
        }else{
          Serial.println("Memoria piena, impossibile salvare altri valori.");
          lampeggia();
          lampeggia();
        }
      }
    }

    Serial.print("Valori salvati dallas18: ");
    for (int i = 0; i < MAX_VALORI; i++) {
      Serial.print(valdallas[i]);
      Serial.print(" ");
    }
    Serial.println();

    Serial.print("Valori salvati dht11: ");
    for (int i = 0; i < MAX_VALORI; i++) {
      Serial.print(valldht11[i]);
      Serial.print(" ");
    }
    Serial.println();

    // Calcolo stima solo se abbiamo riempito il vettore
    if (indice == MAX_VALORI) {
      stimacoeff(valdallas, valldht11, risultaticoeff);
      if (risultaticoeff[1] != 0) {
        valoretarato = (temperature - risultaticoeff[0]) / risultaticoeff[1];
        Serial.print("Valore STIMATO DHT11 : ");
        Serial.println(valoretarato);
        tarato = true;
      }else{
        Serial.println("Errore: b1 = 0, impossibile calcolare valore tarato.");
      }
    }
  }else{
  Serial.println("MODALITA SERVER:");

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
    connesso = false;
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
        
     String richiesta = String(packetBuffer);

     Serial.println(richiesta);
        
     if (richiesta.indexOf("ReqDati") != -1) {
         // Invia la risposta al client
         float somma = 0;
         udp.beginPacket(udp.remoteIP(), udp.remotePort());    
         //aggiungere controllo se è stato tarato allmeno una volta fai cosi altrimenti mandagli il valore del dallas18 
         Serial.print("Temperatura tarata media del DHT11: ");
         for(int i =0;i<10;i++){
          valoretarato = (temperature - risultaticoeff[0]) / risultaticoeff[1];
          media[i]= valoretarato;
          delay(10);
         }
         for(int i =0;i<10;i++){
          somma = media[i] + somma;
         }
         Serial.print(somma/10);
         Serial.print(" °C  ");
         Serial.print("Umidita : " );
         Serial.println(humidity);
         Serial.print("Stringa inviata: ");
         String output = String(humidity) + String(somma/10, 2);
         Serial.println(output);
         delay(random(0, 50));  // Aspetta tra 100 e 500 ms prima di trasmettere
         udp.print(output); //se non va rimettere somma/10
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
}



void lampeggia() {
  digitalWrite(2, HIGH);
  delay(75);
  digitalWrite(2, LOW);
  delay(25);
}



void stimacoeff(float *puntdallas18, float *puntlm35, float *risultati) {
  float mediay = 0, mediax = 0;
  float sommaNum = 0, sommaDen = 0;
  float b1 = 0, b0 = 0;

  // Calcolo delle medie
  for (int i = 0; i < MAX_VALORI; i++) {
    mediay += puntlm35[i];
    mediax += puntdallas18[i];
  }
  mediay /= MAX_VALORI;
  mediax /= MAX_VALORI;

  // Calcolo del numeratore e denominatore
  for (int i = 0; i < MAX_VALORI; i++) {
    float diffx = puntdallas18[i] - mediax;
    float diffy = puntlm35[i] - mediay;
    sommaNum += diffx * diffy;    // Numeratore
    sommaDen += diffx * diffx;    // Denominatore
  }

  if (sommaDen != 0) {
    b1 = sommaNum / sommaDen;  // Coefficiente angolare
    b0 = mediay - b1 * mediax; // Intercetta
  } else {
    Serial.println("Errore: divisione per zero.");
    b1 = 0;
    b0 = mediay;
  }

  risultati[0] = b0;
  risultati[1] = b1;

  Serial.print("b0: ");
  Serial.println(b0);
  Serial.print("b1: ");
  Serial.println(b1);
}