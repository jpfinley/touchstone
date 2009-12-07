// Capacitive setup //
#include <CapSense.h>
// 10M resistor between pins 4 & 6
// pin 6 is sensor pin, add a wire and or foil
#include "WProgram.h"
void setup();
void loop();
void checkIfIAmTouched();
void talkToOtherDevice();
void listenForOtherDevice();
void makeThingsHotter();
void makeThingsColder();
void checkForPulse();
void lightLEDs();
CapSense cs_4_5 = CapSense(4,5);
long touchThreshold = cs_4_5.capSense(30);
  
// Variable Setup
int localLED = 9;                 // LED connected to digital pin 13
int remoteLED = 10;               // LED connected to digital pin 13
int localHeat = 0;                // the heat value for this arduino
int remoteHeat = 0;               // the heat value for the other arduino
int rate = 20;                    // Jeff's mystery timer
boolean bothHandsAreTouching = false;

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
  if(touchThreshold > 100){
    makeThingsHotter();
    talkToOtherDevice();
  }
  else{
    makeThingsColder();
  }
  delay(10);
}

void talkToOtherDevice(){
  Serial.write('t');
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
}

void makeThingsHotter(){
  if(localHeat < 255){
    localHeat++;
  }
}

void makeThingsColder(){
  if(localHeat > 0){
    localHeat--;
  }
}

void checkForPulse(){
//  if (localHeat > 245 && remoteHeat > 245){
//    bothHandsAreTouching = true;
//  }
//  else {
//    bothHandsAreTouching = false;
//  }
}

void lightLEDs(){
  analogWrite(localLED, localHeat);
  analogWrite(remoteLED, remoteHeat);
}

//void heartPulse(){
//  for(int i = 100; i < 255; i++) {
//    analogWrite(remoteLED,i);
//    analogWrite(localLED,i);
//    delay(((60000/rate)*.1)/255);
//  } 
//  for(int i = 255; i > 100; i--){
//    analogWrite(remoteLED,i);
//    analogWrite(localLED,i);
//    delay(((60000/rate)*.2)/255);
//  }
//  for(int i = 100; i < 255; i++) {
//    analogWrite(remoteLED,i);
//    analogWrite(localLED,i);
//    delay(((60000/rate)*.1)/255);
//  } 
//  for(int i = 255; i > 100; i--){
//    analogWrite(remoteLED,i);
//    analogWrite(localLED,i);
//    delay(((60000/rate)*.6)/255);
//  }
//}







int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

