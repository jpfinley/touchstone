/* Touchstone by John P. Finley, Angela Huang, and Jeff Kirsch

December 9th, 2009 for Presentation

Portions based on Heartbeat LED by elCalvoMike 12-6-2008
*/
// Variable Setup

#define localLED 9                 // Local LED attached to PWM 9
#define remoteLED 10               // Remote LED attached to PWM 9

int incomingByte = 0;
int localHeat = 0;
int remoteHeat = 0;

int i = 0;
int rate = 20;

int analogPin = 0;
int val = 0;         // variable to store the read value

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
  //val = analogRead(analogPin);   // read the input pin
  if (analogRead(analogPin) > 0 ){
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
  if (localHeat > 0){
    localHeat--;
  }
}

void lightLEDs(){
  if(localHeat == 255 && remoteHeat == 255){
    heartPulse();
  }
  else{
    analogWrite(localLED, localHeat);
    analogWrite(remoteLED, remoteHeat);
  }
}

void pulseMe(){
  analogWrite(localLED, localHeat);
  analogWrite(remoteLED, remoteHeat);
  delay(30);
  analogWrite(localLED, 100);
  analogWrite(remoteLED, 100);
  delay(50);
}

void heartPulse(){
  
 for (i = 255; i > 100; i--){
   analogWrite(remoteLED,i);
   analogWrite(localLED,i);
   delay(((60000/rate)*.1)/255);
 }
 
 for(i = 100; i < 255; i++) {
   analogWrite(remoteLED,i);
   analogWrite(localLED,i);
   delay(((60000/rate)*.2)/255);
 }
 
 for (i = 255; i > 100; i--){
   analogWrite(remoteLED,i);
   analogWrite(localLED,i);
   delay(((60000/rate)*.1)/255);
 }
 
 for(i = 100; i < 255; i++) {
   analogWrite(remoteLED,i);
   analogWrite(localLED,i);
   delay(((60000/rate)*.6)/255);
 }
 
 
}
