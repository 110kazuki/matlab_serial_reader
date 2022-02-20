/*[Serial_output_tester]
*   Version : 2022/2/20，Author : Kazuki Ito
*--------------------------------------*/

//Setting
int const baudrate    = 115200;
int       cycle_speed = 100; //[Hz]

/*-------------------------------------*/
long      count       = 0;
double    nowt        = 0;

void setup() {
  Serial.begin(baudrate);

}

void loop() {
  nowt = millis()/1000.0; //[s]
  count++;

  //Serial format style '%0.2f,%d,%0.2f'
  Serial.print(nowt);
  Serial.print(",");
  Serial.print(count);
  Serial.print(",");
  Serial.println(sin(nowt));
  
  delay(1000/cycle_speed);
}
