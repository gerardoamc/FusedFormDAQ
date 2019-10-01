// tutorial de conexión Matlab-arduino obtenido en : https://www.youtube.com/watch?v=ymWXCPenNM4
// -----------------------------------------
/* sample for digital weight scale of hx711
 * library design: Weihong Guan (@aguegu)
 * library host on
 *https://github.com/aguegu/ardulibs/tree/3cdb78f3727d9682f7fd22156604fc1e4edd75d1/hx711
 */
 //--------------------------------
// encoder readings tutorial from https://www.youtube.com/watch?v=Y6BjnfwfzKE
//---------------------------
//thermistor setup from: https://makersportal.com/blog/2019/1/15/arduino-thermistor-theory-calibration-and-experiment
// resistor values and imlementation from schematics on Ramps v1.4 https://reprap.org/mediawiki/images/f/f6/RAMPS1.4schematic.png

// Hx711.DOUT - pin #A2
// Hx711.SCK - pin #A3


#include <Hx711.h>
Hx711 scale(A2, A3);
int  force=0;
int mode=-1;
//int therm1=0;
//int therm2=0;
float  counter1=0; //this variable accepts negative values
long counter = 0;

// thermistor definition
int therm1_pin=A4;
int therm2_pin=A5;
int therm_ref_pin=A6;  // reads actual voltage output of circuit to scale up/down the thermistor measurements

void setup() {
  // initialize serial communication @ 9600 bps
  Serial.begin(9600);
  //check serial communication
  Serial.println('a'); // send character to PC
  char a='b';
  while (a!='a')
  {
  // wait for a specific sharacter from the PC
  a=Serial.read();
  }
  
  //Setting up interrupt
  //A rising pulse from encodenren activated ai0(). AttachInterrupt 0 is DigitalPin nr 2 on moust Arduino.
  attachInterrupt(0, ai0, RISING);
   
  //B rising pulse from encodenren activated ai1(). AttachInterrupt 1 is DigitalPin nr 3 on moust Arduino.
  attachInterrupt(1, ai1, RISING);
 // setting up thermistor pin mode
  pinMode(therm1_pin,INPUT);
  pinMode(therm2_pin,INPUT);
  pinMode(therm_ref_pin,INPUT);

}

void loop() {
  if(Serial.available()>0) // check if data has been sent by the PC
  {
    mode=Serial.read();// check if there is a request for sensor value
    if (mode=='R')// used for different modes for various operations. R is used for reading sensor value
    {
      force=scale.getGram();
      counter1=counter;//0.02884615*
      // read the input on analog pins:
      float therm11 = analogRead(therm1_pin);
      float therm21 = analogRead(therm2_pin);
      float therm_ref = analogRead(therm_ref_pin);
      float therm1=1023*therm11/therm_ref;
      float therm2=1023*therm21/therm_ref;
      Serial.println(force);
      Serial.println(counter1);
      Serial.println(therm1);
      Serial.println(therm2);
      //Serial.println(therm_ref);
    }
    delay(20); // wait 20 milliseconds before the next loop of analog to digital converter to settle after the last reading
  }
}

  void ai0() {
  // ai0 is activated if DigitalPin nr 2 is going from LOW to HIGH
  // Check pin 3 to determine the direction
  if(digitalRead(3)==LOW) {
  counter++;
  }else{
  counter--;
  }
  }
   
  void ai1() {
  // ai0 is activated if DigitalPin nr 3 is going from LOW to HIGH
  // Check with pin 2 to determine the direction
  if(digitalRead(2)==LOW) {
  counter--;
  }else{
  counter++;
  }
  }
