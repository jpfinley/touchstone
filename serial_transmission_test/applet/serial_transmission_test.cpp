#define BUTTON 7
#include "WProgram.h"
void setup();
void loop();
int buttonValue = 0;

void setup() {
  Serial.begin(9600);
  pinMode(BUTTON, INPUT);
}

void loop() {
  buttonValue = digitalRead(BUTTON);

  if(buttonValue == HIGH){
    Serial.print(1);
    delay(50);
  }
  else{
    Serial.print(0);
    delay(50);
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

