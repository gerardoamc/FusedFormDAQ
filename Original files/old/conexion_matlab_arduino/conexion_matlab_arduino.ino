// tutorial de conexión Matlab-arduino obtenido en : https://www.youtube.com/watch?v=ymWXCPenNM4
// -----------------------------------------
/* sample for digital weight scale of hx711
 * library design: Weihong Guan (@aguegu)
 * library host on
 *https://github.com/aguegu/ardulibs/tree/3cdb78f3727d9682f7fd22156604fc1e4edd75d1/hx711
 */
 //--------------------------------

// Hx711.DOUT - pin #A2
// Hx711.SCK - pin #A3

#include <Hx711.h>
Hx711 scale(A2, A3);
int  force=0;
int mode=-1;

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
  
}

void loop() {
  if(Serial.available()>0) // check if data has been send by the PC
  {
    mode=Serial.read();// check if there is a request for sensor value
    if (mode=='R')// used for different modes for various operations. R is used for reading sensor value
    {
      force=scale.getGram();
      Serial.println(force);
    }
    delay(20); // wait 20 milliseconds before the next loop of analog to digital converter to settle after the last reading
  }
}
