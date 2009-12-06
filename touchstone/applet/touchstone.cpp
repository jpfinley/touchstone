// Capacitive Setup
// 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil
#include <CapSense.h>
#include "WProgram.h"
void setup();
void loop();
void checkIfIAmTouched();
void talkToOtherDevice();
void listenForOtherDevice();
void makeThingsHotter();
void makeThingsColder();
void lightLEDs();
CapSense cs_4_5 = CapSense(4,5);

// Variable Setup
int incomingByte = 0;
int localLED = 9;                 // LED connected to digital pin 13
int remoteLED = 10;               // LED connected to digital pin 13
int localHeat = 0;
int remoteHeat = 0;

void setup(){
  Serial.begin(9600);
  pinMode(localLED, OUTPUT);      // sets the digital pin as output
  pinMode(remoteLED, OUTPUT);     // sets the digital pin as output
}

void loop(){
  checkIfIAmTouched();
  talkToOtherDevice();
  listenForOtherDevice();
  lightLEDs();
}

//**************************************************//

void checkIfIAmTouched(){
  long total2 = cs_4_5.capSense(30);
  if (total2 > 100){
    makeThingsHotter();
  }
  else{
    makeThingsColder();
  }
  delay(10);
}

void talkToOtherDevice(){
  Serial.write(localHeat);
}

void listenForOtherDevice(){
  //Read the serial buffer, light up the LED
  if (Serial.available() > 0){
    remoteHeat = Serial.read();
    Serial.flush();
  }
}

void makeThingsHotter(){
  if (localHeat < 255){
    localHeat++;
  }
}

void makeThingsColder(){
  if (localHeat > 1){
    localHeat--;
  }
}

void lightLEDs(){
  //if both heats are at 255
  //heartbeat
  //else 
  analogWrite(localLED, localHeat);
  analogWrite(remoteLED, remoteHeat);
}


int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

