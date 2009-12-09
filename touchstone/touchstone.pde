/*
 _____                _         _                   
|_   _|__  _   _  ___| |__  ___| |_ ___  _ __   ___ 
  | |/ _ \| | | |/ __| '_ \/ __| __/ _ \| '_ \ / _ \
  | | (_) | |_| | (__| | | \__ \ || (_) | | | |  __/
  |_|\___/ \__,_|\___|_| |_|___/\__\___/|_| |_|\___|
                                                    
by John P. Finley, Angela Huang, and Jeff Kirsch

December 9th, 2009 for Presentation to Rob Faludi's
Fundamentals of Physical Computing class at the
School of Visual Arts MFA Interaction Design program,
December 2009.

http://interactiondesign.sva.edu/classes/physicalcomputing/

Portions based on Heartbeat LED by elCalvoMike 12-6-2008
*/

// Variable Setup
#define localLED 9                // Local LED attached to PWM 9
#define remoteLED 10              // Remote LED attached to PWM 9

int incomingByte = 0;             // variable to store the read value
int localHeat = 0;                // variable to store the read value
int remoteHeat = 0;               // variable to store the read value

int i = 0;                        // variable to store the read value
int rate = 20;                    // variable to store the read value

int analogPin = 0;                // variable to store the read value
int val = 0;                      // variable to store the read value

// The setup opens serial comm and initializes our LED pins.
void setup(){
  Serial.begin(9600);             // open serial communication
  pinMode(localLED, OUTPUT);      // sets the digital pin as output
  pinMode(remoteLED, OUTPUT);     // sets the digital pin as output
}

// The rundown:
// First, see if the device is being touched. Modify
// the heat counters appropriately. Then write that
// value to the serial for the other device to read.
// Read the other device's heat vlaue over serial.
// Light up the two LEDs based on those values.
void loop(){
  checkIfIAmTouched();
  talkToOtherDevice();
  listenForOtherDevice();
  lightLEDs();
}

//**************************************************//
//**************************************************//

// Ask the FSR if there is anything happening.
// If we are getting a value, we are being touched,
// so increment the heat counter. If we have no
// value, we are being left alone so decrement.
// Delay to prevent doom.
void checkIfIAmTouched(){
  if (analogRead(analogPin) > 0 ){
    makeThingsHotter();
  }
  else{
    makeThingsColder();
  }
  delay(10);
}

// Print out this devices' heat value to the other device.
void talkToOtherDevice(){
  Serial.write(localHeat);
}

// Read the serial buffer. If there is something there,
// assign that value as the heat of the remote device.
// Flush the serial port to prevent doom.
void listenForOtherDevice(){
  if (Serial.available() > 0){
    remoteHeat = Serial.read();
    Serial.flush();
  }
}

// Increment this device's heat value unless it
// hits a ceiling of 255.
void makeThingsHotter(){
  if (localHeat < 255){
    localHeat++;
  }
}

// Decrement this device's heat value unless it
// hits zero.
void makeThingsColder(){
  if (localHeat > 0){
    localHeat--;
  }
}

// Light both the LEDs with their proper values.
// If both heat values are at maximum, we are holding
// hands; time to start the heartbeat animation.
// If no, just give the value that has been determined
// by makeThingsHotter() or Colder().
void lightLEDs(){
  if(localHeat == 255 && remoteHeat == 255){
    heartPulse();
  }
  else{
    analogWrite(localLED, localHeat);
    analogWrite(remoteLED, remoteHeat);
  }
}

// Hearbeat simulation animiation.
// From full brightness go down slightly,
// then up and then down for a while.
// Inspired by elCalvoMike.
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

