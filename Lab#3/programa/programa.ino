#include <PCD8544.h>

// Pines analógicos
#define PIN_A2 A2
#define PIN_A3 A3
#define PIN_A4 A4
#define PIN_A5 A5
#define PIN_MODO 8
#define PIN_SIGNO1 0
#define PIN_SIGNO2 1
#define PIN_SIGNO3 11
#define PIN_SIGNO4 12

// A custom glyph (a smiley)...
static const byte glyph[] = { B00010000, B00110100, B00110000, B00110100, B00010000 };
static PCD8544 lcd;
int estadoAnterior = LOW; 
String MODO = "DC";
String signo1 = "";
String signo2 = "";
String signo3 = "";
String signo4 = "";
int Volt1;
int Volt2;
int Volt3;
int Volt4;

void setup() {
  pinMode(PIN_MODO, INPUT);

  pinMode(PIN_SIGNO1, INPUT);
  pinMode(PIN_SIGNO2, INPUT);
  pinMode(PIN_SIGNO3, INPUT);
  pinMode(PIN_SIGNO4, INPUT);

  lcd.begin(84, 48);

}


void loop() {

  lcd.clear();
  int V1 = analogRead(PIN_A4);
  int V2 = analogRead(PIN_A5);
  int V3 = analogRead(PIN_A2);
  int V4 = analogRead(PIN_A3);

  int S1 = digitalRead(PIN_SIGNO1);
  int S2 = digitalRead(PIN_SIGNO2);
  int S3 = digitalRead(PIN_SIGNO3);
  int S4 = digitalRead(PIN_SIGNO4);

  int estadoActual = digitalRead(PIN_MODO);
  
  if (estadoActual != estadoAnterior) {
    
    if (estadoActual == LOW) {
      if (MODO=="DC"){
        MODO = "AC";
      }
      else if (MODO=="AC"){
        MODO = "DC";
      }
    }
    estadoAnterior = estadoActual;
  }



  if(MODO=="DC"){
    
    if(S1 == HIGH){
      signo1="-";
    }
    else{
      signo1="";
    }

    if(S2 == HIGH){
      signo2="-";
    }
    else{
      signo2="";
    }
    
    if(S3 == HIGH){
      signo3="-";
    }
    else{
      signo3="";
    }
    
    if(S4 == HIGH){
      signo4="-";
    }
    else{
      signo4="";
    }

    Volt1=V1/42;
    Volt2=V2/42;
    Volt3=V3/42;
    Volt4=V4/42;

  }
  else if(MODO=="AC"){


    
  }


  lcd.setCursor(0, 0);
  lcd.print("VOLTIMETRO");
  lcd.setCursor(0, 1);
  lcd.print("MODO: ");
  lcd.print(MODO);

  lcd.setCursor(0, 2);
  lcd.print("V1: ");
  lcd.print(signo1);
  lcd.print(Volt1,DEC);

  lcd.setCursor(0, 3);
  lcd.print("V2: ");
  lcd.print(signo2);
  lcd.print(Volt2,DEC);

  lcd.setCursor(0, 4);
  lcd.print("V3: ");
  lcd.print(signo3);
  lcd.print(Volt3,DEC);

  lcd.setCursor(0, 5);
  lcd.print("V4: ");
  lcd.print(signo4);
  lcd.print(Volt4,DEC);
  delay(200);
}




