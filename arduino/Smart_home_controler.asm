#include<time.h>
#include<EEPROM.h>

#define FAN 13
#define LIGHT 12

#define PEZIO_PIN 1

int count = 0;
int P_Data;
int Threshold = 5;
const int secretknock[3] = {1,1,1,1};
const int secretcount = 3;
const int secrettimedelay = 750;

float Start_Time, End_Time, Time_Lapse;

int FanState = HIGH;
int LightState = HIGH;
const int OFF = HIGH;
const int ON = LOW;
String Input;
void setup() {
  
  Serial.begin(9600);
  pinMode(FAN, OUTPUT);   
  //digitalWrite(FAN, EEPROM.read(0));
  pinMode(LIGHT, OUTPUT);   
  digitalWrite(LIGHT, HIGH);

  Start_Time = millis();
}

void loop() {

//  EEPROM.write(0,FanState);
 // Serial.print(EEPROM.read(0));
  Start_Time = End_Time;
  P_Data = analogRead(PEZIO_PIN);
  if(P_Data > Threshold)  {
    End_Time = millis();
    Time_Lapse = End_Time - Start_Time;
    if(secretknock[count] == 1 && Time_Lapse < secrettimedelay) {
      count++;
      Serial.println(P_Data);
      Serial.println(Time_Lapse);
    }
    else  {
      count = 0;
    }
    delay(100);
  }
  if(count == secretcount){
    Serial.println("Toggle");
    if(FanState == ON && LightState == ON){
      Serial.println("OFF_BOTH");
      digitalWrite(FAN, OFF);
      digitalWrite(LIGHT, OFF);
      FanState = OFF;
      LightState = OFF;
    }
    else if(FanState == OFF && LightState == OFF){
      Serial.println("ON_LIGHT");
      digitalWrite(FAN, ON);
      digitalWrite(LIGHT, ON);
      FanState = ON;
      LightState = ON;
    }
    else if(FanState == OFF && LightState == ON) {
      Serial.println("OFF_LIGHT");
      digitalWrite(LIGHT, OFF);
      LightState = OFF;
    }
    else if(FanState == ON && LightState == OFF) {
      Serial.println("OFF_FAN");
      digitalWrite(FAN, OFF);
      FanState = OFF;
    }
    count = 0;
  }
  else if(count == secretcount) {
    count = 0;
    Serial.println("Reset");
  }

  
  //Bluetooth commands
  if(Serial.available())  {
    Input = Serial.readString();
    Serial.println(Input);

    if(Input == "ON_FAN") {
      digitalWrite(FAN, ON);
      FanState = ON;
    }
    if(Input == "OFF_FAN")  {
      digitalWrite(FAN, OFF);
      FanState = OFF;
    }
    if(Input == "ON_LIGHT") {
      digitalWrite(LIGHT, ON);
      LightState = ON;
    }
    if(Input == "OFF_LIGHT")  {
      digitalWrite(LIGHT, OFF);
      LightState = OFF;
    }
    if(Input == "ON_BOTH")  {
      digitalWrite(FAN, ON);
      FanState = ON;
      digitalWrite(LIGHT, ON);
      LightState = ON;
    }
    if(Input == "OFF_BOTH")  {
      digitalWrite(FAN, OFF);
      FanState = OFF;
      digitalWrite(LIGHT, OFF);
      LightState = OFF;
    }
  }
}
