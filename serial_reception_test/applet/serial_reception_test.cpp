#define LED 13
#include "WProgram.h"
void setup();
void loop();
int incomingByte = 0;

void setup() {
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

void loop() {
  if(Serial.available() > 0) {
    incomingByte = Serial.read();
    Serial.println(incomingByte, DEC);

    if(incomingByte == 49){
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

