# **DSP Laboratory; Week -02**
## **PPG signal realtime processing**
## Aim-

Write Arduino programs for studying the performance of-
* Moving Average Filter
* First order difference filter
* Three point central difference filter <br/>

[ * ] Analyze the performance of the filters using two pre-recorded ECG signals by live recording the ppg signal using a ppg Sensor <br/>
[ * ] Analyze the performance of the filters using two pre-recorded ECG signals.
<br/>

#  *PPG Signal and Sensor*
<strong>P</strong>hoto<strong>P</strong>lethysmo<strong>G</strong>ram (ppg) 
With each cardiac cycle the heart pumps blood to the periphery. Even though this pressure pulse is somewhat damped by the time it reaches the skin, it is enough to distend the arteries and arterioles in the tissues.

<img src="gifs\giff.gif" width="500" height="300"> 
[Souce: wiki]

The change in volume caused by the pressure pulse is detected by illuminating the skin with the light from a light-emitting diode (LED) and then measuring the amount of light either transmitted or reflected to a photodiode which can be eventually used to detect blood volume changes in the microvascular bed of tissue
<br/>

<img src="gifs\ppg_dia.jpg" width="350" height="300"> 
[Souce: wiki]

# *1. Moving Average filtering of ppg signal*
The moving average filter is a simple Low Pass FIR (Finite Impulse Response). It takes some samples of input and takes the mean of those to produce a single output. As the length of the filter increases, the smoothness of the output increases.
<hr />


## *Moving Average (MA) Filter: Time Domain Equation and Transfer Function*

<img src="equations\eqma.png" width="618" height="126"> 

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



# *2. First Order filtering of ppg signal*
The first-order difference filter is a FIR filter, where previous input is subtracted from the current input to get the current output. Also known as derivative filter, it essentisally emphasizes the high-slope components of the signal.<hr />
<img src="equations\eqfd.png" width="392" height="105"> <br/>

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
    input[i] = analogRead(analoginputpin); // read the input pin
    delay(10);
    Serial.print(input[i]/2); //plotting input x
    Serial.print(',');
    //first order difference filter
    y1[i]=input[i]-input[i-1];
    Serial.println(y1[i]-200); //plotting output y
  }
    
}

```

<img style="float: right;" src="gifs\df.gif">

# *3. Central Point Difference filtering of ppg signal*
The three-point central difference filter is also a FIR filter.

<img src="gifs\filter.gif" width="300" height="200"><br/>
[Source: Electronics Tutorials]

The main difference between a 1st and 2nd order low pass filter is that the stop band roll-off will be twice the 1st order filters at 40dB/decade.
<hr />
<img src="equations\eqsf.png" width="586" height="130">


``` cpp
int analoginputpin = A0;
float input[500];

void setup()   // put your setup code here, to run once:
{
    Serial.begin(9600);         //  setup serial
}
void loop()                     //  put your main code here, to run repeatedly:
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
<br/>
<br/>

# *ECG Signal and Machine*
Electrocardiography is the process of producing a graph of voltage versus time – of the electrical activity of the heart. 

The signal thus achieved is called <strong>E</strong>lectro<strong>C</strong>ardio<strong>G</strong>ram.

<img src="gifs\ecg.png" width="300" height="300"><br/>
[Source: wiki]

The overall goal of performing an ECG is to obtain information about the electrical function of the heart.

Electrocardiographs are recorded by machines that consist of a set of electrodes connected to a central unit. Usually, 10 electrodes are attached to the body to measure the specific electrical potential differences.

## **ECG Signal 01 - 103**

Find the datafile [HERE](data/ECG_103_1000samples_100hz).

Moving Average filter: 
<br/>

<img style="float: right;" src="gifs\103ma.gif">

First order difference filter:
<br/>

<img style="float: right;" src="gifs\103df.gif">

Central point difference filter:
<br/>

<img style="float: right;" src="gifs\103sf.gif">

## **ECG Signal 02 - 119**

Find the datafile [HERE](data/ECG_119_1000samples_100hz).

Moving Average filter: 
<br/>

<img style="float: right;" src="gifs\119ma.gif">

First order difference filter:
<br/>

<img style="float: right;" src="gifs\119df.gif">

Central point difference filter:
<br/>

<img style="float: right;" src="gifs\119sf.gif">
