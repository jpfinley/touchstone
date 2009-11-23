//adding a comment

#define BUTTON 7
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

