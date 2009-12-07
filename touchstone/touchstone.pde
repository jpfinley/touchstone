// Capacitive setup //
#include <CapSense.h>
// 10M resistor between pins 4 & 6
// pin 6 is sensor pin, add a wire and or foil
CapSense cs_4_5 = CapSense(4,5);

// Variable Setup
int localLED = 9;                 // LED connected to digital pin 13
int remoteLED = 10;               // LED connected to digital pin 13
int localHeat = 0;                // the heat value for this arduino
int remoteHeat = 0;               // the heat value for the other arduino
int rate = 20;                    // Jeff's mystery timer
int pulse = 0;

void setup(){
  Serial.begin(9600);
  pinMode(localLED, OUTPUT);      // sets the digital pin as output
  pinMode(remoteLED, OUTPUT);     // sets the digital pin as output
}

void loop(){
  checkIfIAmTouched();
  listenForOtherDevice();
  lightLEDs();
}

//**************************************************//

void checkIfIAmTouched(){
  long touchThreshold = cs_4_5.capSense(30);
  if(touchThreshold > 100){
    Serial.write('t');
    if(localHeat < 255){
      localHeat++;
    }
  }
  else{
    if(localHeat > 0){
      localHeat--;
    }
  }
  delay(10);
}

void listenForOtherDevice(){
  if (Serial.available() > 0){
    if(Serial.read() == 't'){
      if(remoteHeat < 255){
        remoteHeat++;
      }
    }
  }
  else{
    if(remoteHeat > 0){
      remoteHeat--;
    }
  }
  delay(10);
}

void lightLEDs(){
  if(localHeat > 245 && remoteHeat > 245){
    pulse = -100;
  }
  else{
    pulse = 0;
  }
  analogWrite(localLED, localHeat);
  analogWrite(remoteLED, remoteHeat);
  delay(10);
  analogWrite(localLED, localHeat - pulse);
  analogWrite(remoteLED, remoteHeat - pulse);
  delay(50);
}

