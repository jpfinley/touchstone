// Capacitive Setup
// 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and/or foil
#include <CapSense.h>
#include "WProgram.h"
void setup();
void loop();
void calculateLEDvalue();
void lightLED();
CapSense cs_4_5 = CapSense(4,5);

// Variable Setup
int redLED = 10;                 // LED connected to digital pin 13
int redLightValue = 0;

void setup(){
  Serial.begin(9600);
  pinMode(redLED, OUTPUT);      // sets the digital pin as output
}

void loop(){
  calculateLEDvalue();
//  lightLED();
}

//**************************************************//

void calculateLEDvalue(){
  for(int i = 0; i < 255; i++){
    redLightValue = i;
    analogWrite(redLED, redLightValue);
    delay(5);
  }
  
}

void lightLED(){
  analogWrite(redLED, redLightValue);
}


int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

