#include <PCD8544.h>

#define PIN_A2 A2
#define PIN_A3 A3
#define PIN_A4 A4
#define PIN_A5 A5
#define PIN_MODO 8
#define PIN_SIGNO1 0
#define PIN_SIGNO2 1
#define PIN_SIGNO3 11
#define PIN_SIGNO4 12

static const byte glyph[] = { B00010000, B00110100, B00110000, B00110100, B00010000 };
static PCD8544 lcd;
int estadoAnterior = LOW; 
const int muestrasPorPeriodo = 100;

String MODO = "DC";
String signo1 = "";
String signo2 = "";
String signo3 = "";
String signo4 = "";
String rms = "";
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
  Serial.begin(9600);
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
    rms = "";
    
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
    int MaxV1 = 0;
    int MaxV2 = 0;
    int MaxV3 = 0;
    int MaxV4 = 0;
    rms = " rms";
 
    for (int i = 0; i < muestrasPorPeriodo; ++i) {
      V1 = analogRead(PIN_A4);
      MaxV1 = max(MaxV1, V1);
    }

    for (int i = 0; i < muestrasPorPeriodo; ++i) {
      V2 = analogRead(PIN_A5);
      MaxV2 = max(MaxV2, V2);
    }

    for (int i = 0; i < muestrasPorPeriodo; ++i) {
      V3 = analogRead(PIN_A2);
      MaxV3 = max(MaxV3, V3);
    }

    for (int i = 0; i < muestrasPorPeriodo; ++i) {
      V4 = analogRead(PIN_A3);
      MaxV4 = max(MaxV4, V4);
    }

    Volt1=(MaxV1/42)*0.707;
    Volt2=(MaxV2/42)*0.707;
    Volt3=(MaxV3/42)*0.707;
    Volt4=(MaxV4/42)*0.707;
  
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
  lcd.print(rms);

  lcd.setCursor(0, 3);
  lcd.print("V2: ");
  lcd.print(signo2);
  lcd.print(Volt2,DEC);
  lcd.print(rms);

  lcd.setCursor(0, 4);
  lcd.print("V3: ");
  lcd.print(signo3);
  lcd.print(Volt3,DEC);
  lcd.print(rms);

  lcd.setCursor(0, 5);
  lcd.print("V4: ");
  lcd.print(signo4);
  lcd.print(Volt4,DEC);
  lcd.print(rms);


  Serial.print(MODO);

  Serial.print(",");
  Serial.print(signo1);
  Serial.print(Volt1,DEC);

  Serial.print(",");
  Serial.print(signo2);
  Serial.print(Volt2,DEC);

  Serial.print(",");
  Serial.print(signo3);
  Serial.print(Volt3,DEC);


  Serial.print(",");
  Serial.print(signo4);
  Serial.print(Volt4,DEC);
  Serial.println();
  delay(200);
}




