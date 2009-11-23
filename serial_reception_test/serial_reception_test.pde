#define LED 13
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

