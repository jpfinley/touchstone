int i = 0;
int rate = 20;

int remoteHot = 10;
int remoteCool = 11;
int localHot = 6;
int localCool = 9;

int fadePin = 3;
int localPin = 4;
int remotePin = 5;

int fadeVal = 0;
int localVal = 0;
int remoteVal = 0;

int maxVal = 255;

void setup(){
  Serial.begin(9600);
  pinMode(remoteHot, OUTPUT);
  pinMode(remoteCool, OUTPUT);
  pinMode(localHot, OUTPUT);
  pinMode(localCool, OUTPUT);
}

void loop(){
  readVals();
  adjustFade();
  loveConnection();
  
}

void adjustFade(){
  
}

void readVals(){
 fadeVal = analogRead(fadePin);
 localVal = analogRead(localPin);
 remoteVal = analogRead(remotePin);
 fadeVal = map(fadeVal, 0, 1023, 0, 255);
 localVal = map(localVal, 0, 1023, 0, fadeVal);
 remoteVal = map(remoteVal, 0, 1023, 0, fadeVal);
 Serial.println(fadeVal);
}

void loveConnection(){
  if (localVal == 255 && remoteVal == 255){
    heartPulse();
  }
  else {
    writeLights();
  }
  
}


void heartPulse(){
  
  analogWrite(remoteCool, 0);
  analogWrite(localCool, 0);
  
  for(i = 100; i < 255; i++) {
   analogWrite(remoteHot,i);
   analogWrite(localHot,i);
   delay(((60000/rate)*.1)/255);
 }
 
 for (i = 255; i > 100; i--){
   analogWrite(remoteHot,i);
   analogWrite(localHot,i);
   delay(((60000/rate)*.2)/255);
 }
 
 for(i = 100; i < 255; i++) {
   analogWrite(remoteHot,i);
   analogWrite(localHot,i);
   delay(((60000/rate)*.1)/255);
 }
 
 for (i = 255; i > 100; i--){
   analogWrite(remoteHot,i);
   analogWrite(localHot,i);
   delay(((60000/rate)*.6)/255);
 }
 
 
}

void writeLights(){
 analogWrite(remoteHot, remoteVal);
 //analogWrite(remoteCool, (fadeVal - remoteVal));
 analogWrite(localHot, localVal);
 //analogWrite(localCool, (fadeVal - localVal));
}
