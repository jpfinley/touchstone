#include <CapSense.h>

int incomingByte = 0;
int redLED = 9;                 // LED connected to digital pin 13
int blueLED = 10;                 // LED connected to digital pin 13
int heat = 0;
int cold = 1023;


CapSense   cs_4_5 = CapSense(4,5);        // 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil


void setup(){
  Serial.begin(9600);
  pinMode(redLED, OUTPUT);      // sets the digital pin as output
  pinMode(blueLED, OUTPUT);      // sets the digital pin as output
}

void loop(){
  long total2 =  cs_4_5.capSense(30);

  delay(10);                             // arbitrary delay to limit data to serial port



  if (total2 > 100){
    Serial.write("D");
  }
  else{
    Serial.write("F");
  }

  analogWrite(blueLED, cold / 4);
  analogWrite(redLED, heat / 4);


  readSerial();
}


void readSerial(){
  //Read the serial buffer, light up the LED
  if (Serial.available() > 0) {
    if (Serial.read() == 'D'){
      //make things hotter
      if (heat < 1023) {
        heat ++;
        cold --;
      }
    }
    else if (Serial.read() == 'F'){
      //make things colder
      if (heat > 1) {
        heat --;
        cold ++;
      }
    }
    Serial.flush();
    delay(10);
  }
}

