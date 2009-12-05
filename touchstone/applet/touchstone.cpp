// Capacitive Setup
#include <CapSense.h>
#include "WProgram.h"
void setup();
void loop();
void checkIfIAmTouched();
void listenForOtherDevice();
void makeThingsColder();
void makeThingsHotter();
void lightLEDs();
CapSense   cs_4_5 = CapSense(4,5);        // 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil

// Variable Setup
int incomingByte = 0;
int redLED = 9;                 // LED connected to digital pin 13
int blueLED = 10;                 // LED connected to digital pin 13
int heat = 0;
int cold = 1023;

void setup(){
  Serial.begin(9600);
  pinMode(redLED, OUTPUT);      // sets the digital pin as output
  pinMode(blueLED, OUTPUT);      // sets the digital pin as output
}

void loop(){
  checkIfIAmTouched();
  listenForOtherDevice();
  lightLEDs();
}

//**************************************************//

void checkIfIAmTouched(){
  long total2 = cs_4_5.capSense(30);
  if (total2 > 50){
    Serial.write("D");
  }
}

void listenForOtherDevice(){
  //Read the serial buffer, light up the LED
  if (Serial.available() > 0){
    if (Serial.read() == 'D'){
      makeThingsHotter();
    }    
    Serial.flush();
    delay(10);
  }
  else {
   //Serial.println("Cooling!");
   //makeThingsColder();
  }
}

void makeThingsColder(){
  if (heat > 1){
    heat --;
    cold ++;
  }
}

void makeThingsHotter(){
  if (heat < 1023) {
    heat ++;
    cold --;
  }
}

void lightLEDs(){
  analogWrite(blueLED, cold / 4);
  analogWrite(redLED, heat / 4);
}


int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

