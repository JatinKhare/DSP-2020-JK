# **DSP Laboratory; Week -02**
## **PPG signal realtime processing**


# *1. PPG Sensor*

# *2. Moving Averare filtering of ppg signal*
The moving average filter is a simple Low Pass FIR (Finite Impulse Response). It takes some samples of input and takes the mean of those to produce a single output. As the length of the filter increases, the smoothness of the output increases.
<hr />


## *Moving Average (MA) Filter: Time Domain Equation and Transfer Function*

<img src="equations\eqma.png" width="309" height="63"> 

``` cpp
int analoginputpin = A0;
float input[500];

void setup()   // put your setup code here, to run once:
{
    Serial.begin(9600);         //  setup serial
}
void loop()                     // put your main code here, to run repeatedly:
{
  int l = 10;
  float y[500], y1[500];    //initializing array to store output.
  for(int i=0;i<500;i++)
  {
    input[i] = analogRead(analoginputpin);  // read the input pin
    delay(10);
    
    for(int j=0;j<l;j++)
    {
      if(i>j)
      {
        y[i]=y[i]+input[i-j];
      }
      y[i]=y[i]/l;
    }
    Serial.print(input[i]/2); //plotting input x
    Serial.print(',');
    Serial.println(y[i]*3+300);  //plotting output y
  }
    
}

```


<img style="float: right;" src="gifs\ma.gif">





``` cpp
int analoginputpin = A0;
float input[500];

void setup()   // put your setup code here, to run once:
{
    Serial.begin(9600);         //  setup serial
}
void loop()                     // put your main code here, to run repeatedly:
{
  int l = 10;
  float y[500], y1[500];    //initializing array to store output.
  for(int i=0;i<500;i++)
  {
    input[i] = analogRead(analoginputpin);  // read the input pin
    delay(10);
    Serial.print(input[i]/2); //plotting input x
    Serial.print(',');
    //    first order difference filter

    y1[i]=input[i]-input[i-1];
    Serial.println(y1[i]-200); //plotting output y
  }
    
}

```

<img style="float: right;" src="gifs\df.gif">




``` cpp
int analoginputpin = A0;
float input[500];

void setup()   // put your setup code here, to run once:
{
    Serial.begin(9600);         //  setup serial
}
void loop()                     // put your main code here, to run repeatedly:
{
  int l = 10;
  float y[500], y1[500];    //initializing array to store output.
  for(int i=0;i<500;i++)
  {
    input[i] = analogRead(analoginputpin);  // read the input pin
    delay(10);
    Serial.print(input[i]/2); //plotting input x
    //Central Point Difference filter

    y1[i]=input[i]-input[i-2];
    Serial.print(',');
    Serial.println(y1[i]-200); //plotting output y
  }
    
}

```

<img style="float: right;" src="gifs\sf.gif">






# *3. First Order filtering of ppg signal*

# *4. Second Order filtering of ppg signal*


# *5. ECG signal*

## **Signal 01 - 103**
1. Smoothing using Moving Average
## **Arduino Code**
Find the datafile [HERE](data/ECG_103_1000samples_100hz).
<img style="float: right;" src="gifs\103ma.gif">

2. First Order Difference order filter
Find the datafile [HERE](data/ECG_103_1000samples_100hz).
<img style="float: right;" src="gifs\103df.gif">
3. Central Point Difference filter

Find the datafile [HERE](data/ECG_103_1000samples_100hz).
<img style="float: right;" src="gifs\103sf.gif">

## **Signal 02 - 119**
1. Smoothing using Moving Average

Find the datafile [HERE](data/ECG_119_1000samples_100hz).
<img style="float: right;" src="gifs\119ma.gif">

2. First Order Difference order filter

Find the datafile [HERE](data/ECG_119_1000samples_100hz).

<img style="float: right;" src="gifs\119df.gif">

3. Central Point Difference filter

Find the datafile [HERE](data/ECG_119_1000samples_100hz).

<img style="float: right;" src="gifs\119sf.gif">
