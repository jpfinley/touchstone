#include <CapSense.h>

/*
 * CapitiveSense Library Demo Sketch
 * Paul Badger 2008
 * Uses a high value resistor e.g. 10M between send pin and receive pin
 * Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
 * Receive pin is the sensor pin - try different amounts of foil/metal on this pin
 */

#include "WProgram.h"
void setup();
void loop();
int redLED = 9;                 // LED connected to digital pin 13
int blueLED = 10;                 // LED connected to digital pin 13
int heat = 0;
int cold = 1023;


CapSense   cs_4_5 = CapSense(4,5);        // 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil


void setup()                    
{
   Serial.begin(9600);
   pinMode(redLED, OUTPUT);      // sets the digital pin as output
   pinMode(blueLED, OUTPUT);      // sets the digital pin as output

}

void loop()                    
{
    long start = millis();
    long total2 =  cs_4_5.capSense(30);

    Serial.print(heat);
    Serial.print(" ");
    Serial.print(cold);
    Serial.print("\t");                    // tab character for debug windown spacing
    Serial.print("\t");
    Serial.println(total2);                  // print sensor output 2 */


   // delay(10);                             // arbitrary delay to limit data to serial port
    
    
    
    if (total2 > 10) {
      if (heat < 1023) {
      heat ++;
      cold --;
      }
    }
    else {
      if (heat > 1) {
      heat --;
      cold ++;
      }
    }
    
    analogWrite(redLED, (heat / 4));   // sets the LED on
    analogWrite(blueLED, (cold / 4));   // sets the LED on
    
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

