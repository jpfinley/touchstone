#include <CapSense.h>

/*
 * CapitiveSense Library Demo Sketch
 * Paul Badger 2008
 * Uses a high value resistor e.g. 10M between send pin and receive pin
 * Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
 * Receive pin is the sensor pin - try different amounts of foil/metal on this pin
 */

int ledPin = 9;                 // LED connected to digital pin 13


CapSense   cs_4_5 = CapSense(4,5);        // 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil


void setup()                    
{
   Serial.begin(9600);
   pinMode(ledPin, OUTPUT);      // sets the digital pin as output

}

void loop()                    
{
    long start = millis();
    long total2 =  cs_4_5.capSense(30);

   /* Serial.print(millis() - start);        // check on performance in milliseconds
    Serial.print("\t");                    // tab character for debug windown spacing
    Serial.print("\t");
    Serial.println(total2);                  // print sensor output 2 */


   // delay(10);                             // arbitrary delay to limit data to serial port
    
    analogWrite(ledPin, total2 * 1.5);   // sets the LED on
    
    /* if (total2 > 60) {
      digitalWrite(ledPin, HIGH);   // sets the LED on
      Serial.print(49, BYTE);
    }
    else {
      digitalWrite(ledPin, LOW);   // sets the LED off
    }*/
    
    
}
