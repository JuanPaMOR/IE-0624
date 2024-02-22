#include <Servo.h>
#include <SoftwareSerial.h>
SoftwareSerial BT(10, 11); 

Servo servo1;  
Servo servo2;  
Servo servo3;  
Servo servo4;  
Servo servo5;  
Servo servo6;  

int s1Vel = 15;
int s2Vel = 25; 
int s3Vel = 20;
int s4Vel = 20; 
int s5Vel = 15; 
int s6Vel = 15; 

int s1Act,s2Act,s3Act,s4Act,s5Act,s6Act;        
int s1Ant,s2Ant,s3Ant,s4Ant,s5Ant,s6Ant;         

String men,menS;


void setup(){
  Serial.begin(115200);
  BT.begin(9600);
  BT.setTimeout(10);
  servo1.attach(2,510,1200);
  servo2.attach(3,650,1400);  
  servo3.attach(4,650,1400);  
  servo4.attach(5,650,1400);  
  servo5.attach(6,800,1290);  
  servo6.attach(7,400,1290);  

  s1Ant=90;  
  s2Ant=90; 
  s3Ant=115; 
  s4Ant=140;  
  s5Ant=100;  
  s6Ant=60; 

  servo1.write(s1Ant);
  servo2.write(s2Ant); 
  servo3.write(s3Ant);
  servo4.write(s4Ant);
  servo5.write(s5Ant);
  servo6.write(s6Ant);
  
  delay(50);
}

void loop() {

     if(BT.available()>0){
      
        men = BT.readString();               

        if(men.startsWith("s1")){                
           menS = men.substring(2,men.length()); 
           s1Act = menS.toInt();                 

           if(s1Ant > s1Act){
              for(int j=s1Ant; j>=s1Act; j--){   
                  servo1.write(j);
                  delay(s1Vel);}}
           else{
              for(int j=s1Ant; j<=s1Act; j++){   
                  servo1.write(j);
                  delay(s1Vel);}}
                  
          s1Ant = s1Act;}                       
                           
        if(men.startsWith("s2")){                
           menS = men.substring(2,men.length());  
           s2Act = menS.toInt();                 
           Serial.println(s2Act); 
           if(s2Ant > s2Act){
              for(int j=s2Ant; j>=s2Act; j--){   
                  servo2.write(j);              
                  delay(s2Vel);}}
           else{
              for(int j=s2Ant; j<=s2Act; j++){   
                  servo2.write(j);            
                  delay(s2Vel);}}
                  
          s2Ant = s2Act;}                                   

        if(men.startsWith("s3")){                
           menS = men.substring(2,men.length());   
           s3Act = menS.toInt();                 
           
           if(s3Ant > s3Act){
              for(int j=s3Ant; j>=s3Act; j--){   
                  servo3.write(j);
                  delay(s3Vel);}}
           else{
              for(int j=s3Ant; j<=s3Act; j++){   
                  servo3.write(j);
                  delay(s3Vel);}}
                  
          s3Ant = s3Act;}                                      

        if(men.startsWith("s4")){                
           menS = men.substring(2,men.length());   
           s4Act = menS.toInt();                 
           
           if(s4Ant > s4Act){
              for(int j=s4Ant; j>=s4Act; j--){   
                  servo4.write(j);
                  delay(s4Vel);}}
           else{
              for(int j=s4Ant; j<=s4Act; j++){   
                  servo4.write(j);
                  delay(s4Vel);}}
                  
          s4Ant = s4Act;}  

        if(men.startsWith("s5")){                
           menS = men.substring(2,men.length());   
           s5Act = menS.toInt();                 
           Serial.println(s5Act);
           if(s5Ant > s5Act){
              for(int j=s5Ant; j>=s5Act; j--){   
                  servo5.write(j);
                  delay(s5Vel);}}
           else{
              for(int j=s5Ant; j<=s5Act; j++){   
                  servo5.write(j);
                  delay(s5Vel);}}
                  
          s5Ant = s5Act;} 

        if(men.startsWith("s6")){                
           menS = men.substring(2,men.length());   
           s6Act = menS.toInt();                 
           
           if(s6Ant > s6Act){
              for(int j=s6Ant; j>=s6Act; j--){   
                  servo6.write(j);
                  delay(s6Vel);}}
           else{
              for(int j=s6Ant; j<=s6Act; j++){   
                  servo6.write(j);
                  delay(s6Vel);}}
                  
          s6Ant = s6Act;}                   
     }         
}
