//Touchstone
//Jeff Kirsch and John Finley

#define LED 13
#define BUTTON 7
#include "WProgram.h"
void setup();
void loop();
int incomingByte = 0;
int buttonValue = 0;

void setup(){
  Serial.begin(9600);
  pinMode(BUTTON, INPUT);
  pinMode(LED, OUTPUT);
}

void loop(){
  buttonValue = digitalRead(BUTTON);

  //Transmit the button's state
  if(buttonValue == HIGH){
    Serial.print(1);
    delay(10);
  }
  else{
    Serial.print(0);
    delay(10);
  }    

  //Read the serial buffer, light up the LED
  if(Serial.available() > 0) {
    incomingByte = Serial.read();
    Serial.println(incomingByte, DEC);

    if(incomingByte == 49){ //49 is ASCII for the number zero.
      digitalWrite(LED, HIGH);  //light it up
    }
    else{
      digitalWrite(LED, LOW);
    }
  }
}


int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

