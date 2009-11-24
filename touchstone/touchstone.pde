//Touchstone
//Jeff Kirsch and John Finley

#define LED 13
#define BUTTON 7
int incomingByte = 0;
int buttonValue = 0;

void setup(){
  Serial.begin(9600);
  pinMode(BUTTON, INPUT);
  pinMode(LED, OUTPUT);
}

void loop(){
  buttonValue = digitalRead(BUTTON);    
  transmitStatus();
  readSerial();
}

void transmitStatus() {
  //Transmit the button's state
  if(buttonValue == HIGH){
    Serial.print(1);
    delay(10);
  }
  else{
    Serial.print(0);
    delay(10);
  }
}

void readSerial() {
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
