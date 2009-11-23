//Touchstone

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

  //Transmit the button's state
  if(buttonValue == HIGH){
    Serial.print(1);
    delay(50);
  }
  else{
    Serial.print(0);
    delay(50);
  }

  //Read the serial buffer, light up the LED
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



