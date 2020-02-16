# **DSP Laboratory; Week -05**
## **Respiratory Rate Extraction using FFT and IFFT;**
## Aim-

To separate the respiratory sigal from PPG signal using FFT and IFFT and find out the respiartory rate.

# Fast Fourier Transform (FFT)

A fast Fourier transform (FFT) is an algorithm that computes the discrete Fourier transform (DFT) of a sequence, or its inverse (IDFT). Fourier analysis converts a signal from its original domain (often time or space) to a representation in the frequency domain and vice versa.

Splitting the given sequence into two halves-

<img src="equations\fft.gif"> 

which can be written as,

<img src="equations\fft2.gif">

# Concept
1. Moving Average filter is applied to smooth the signal and remove high frequency components (noise)
2. DFT of the signal is found using FFT algorithm. Removing the respiratory signal frequency components and taking IFFT will result in the ppg pulse. Similarly, removing the components of ppg will result in extracting the respiratory signal.
3. For the respiratory rate, find the index k for which we get the first peak in magnitude response of 'ppg component removed' frequency response.


<center>

|`Frequency Range` | Frequency of Respiratory Signal:  0.05 to 0.5 Hz (3 - 30 bpm) </br> Frequency of PPG Signal: 0.5 to 5 Hz (30 - 300 bpm)|
|-|-|

</center>


The corresponding frequency for a k index is-
<center>
<img src="equations\fre.JPG" width="120">
</center>

where

k = index,
Fs = Sampling Frequency,
N = Length of the signal
<center>
<img src="equations\pulse.JPG" width="200">
</center>

# **2. Separation of PPG and Respiratory signal**

Find the datafile [HERE](data/ppgwithRespiration_25hz_30seconds.csv).

Here we have used the arduino [FFT library](data/arduinoFFT-master). 

Code
```cpp

#include <arduinoFFT.h>
#include <math.h>
arduinoFFT FFT = arduinoFFT();
float x[750] = { -293.9933169,-571.4949447,-287.7493388,407.5377746,670.4527126,
 .... 574.9055267,188.1593344,-191.0241869,-192.5122974}
const uint16_t SAMPLES = 1024; //This value MUST ALWAYS be a power of 2
const double SAMPLING_FREQUENCY = 25;
double mean=0;
const double pi = 3.14159;
double resp[SAMPLES];
double resp1[SAMPLES];
double recon[SAMPLES];
double myfft[SAMPLES];
double w_cos[1024][1024];
double w_sin[1024][1024];
double y_real[SAMPLES];
double y_real2[SAMPLES];
double y[750];
void setup() 
{
  Serial.begin(9600);
}

void loop() {
  double vReal[SAMPLES], vImag[SAMPLES];

    for (int i = 0; i < SAMPLES; i++)
  {
    vReal[i] = 0;
    vImag[i] = 0;
  }
  
    for (int i = 0; i < 750; i++)
  {
    y[i] = 0;
  }

  //////////////////////////////////////////////////////////

  //Moving Average
  int l = 1;
  mean=0;
  for(int i=0;i<750;i++)  //for loop for SAMPLES times
  {
    for(int j=0;j<l;j++)
    {
      if(i>j)
      {
        y[i]=y[i]+x[i-j];
      }
     }
    mean = mean+y[i];
  }
  
   //////////////////////////////////////////////////////////
   
  //Subtracting the Mean from the signal
  for(int i=0;i<750;i++)
    {
      y[i]=y[i]-mean/750;
    }
    

    for (int i = 0; i < 750; i++)
    {
    vReal[i] = y[i];
    //Serial.println(vReal[i]);    
    //Serial.print(',');
    //Serial.print(x[i]);
    }

    
  //////////////////////////////////////////////////////////
  
  /*FFT*/                                                                // builtin FFT library and methods
  //FFT.Windowing(vReal, SAMPLES, FFT_FORWARD);       //Forward FFT
  FFT.Compute(vReal, vImag, SAMPLES, FFT_FORWARD);
  //FFT.ComplexToMagnitude(vReal, v2Imag, SAMPLES);                       //Converting R+iI to real magnitude
  //double x = FFT.MajorPeak(vReal, SAMPLES, SAMPLING_FREQUENCY);
  
  for (int i = 0; i < (SAMPLES); i++)
  {
    resp[i]=sqrt(vImag[i]*vImag[i]+vReal[i]*vReal[i]);
    //Serial.print(resp[i]);    //View only this line in serial plotter to visualize the bins
    //Serial.print(',');
  }

  //////////////////////////////////////////////////////////
  //Filtering in Frequency Domain
  int k = 21;

  double v2Real[SAMPLES], v2Imag[SAMPLES];

    for (int i = 0; i < SAMPLES; i++)
  {
    v2Real[i] = vReal[i];
    v2Imag[i] = vImag[i];
  }

    double maxi = 0;
    int index = 0;
    
    for(int i=0;i<k;i++)
    {
      if(resp[i+4]>maxi)
        {
          maxi = resp[i];
          index = i;    //The maxima of Respiratory signal in frequency domain
        }
        
        vReal[i]=0;
        vReal[SAMPLES-i]=0;
        vImag[i]=0;
        vImag[SAMPLES-i]=0;
    }
        for(int i=k;i<750-k;i++)
    {
        v2Real[i]=0;
        v2Imag[i]=0;
    }

//       for (int i = 0; i < (SAMPLES); i++)
//        {
//        resp[i]=sqrt(v2Imag[i]*v2Imag[i]+vReal[i]*vReal[i]);
//        Serial.print(resp[i]/1000);    //View only this line in serial plotter to visualize the bins
//        Serial.print(',');
//        resp1[i]=sqrt(v2Imag1[i]*v2Imag1[i]+v2Real[i]*v2Real[i]);
//        Serial.println(resp1[i]/1000-200);    //View only this line in serial plotter to visualize the bins
//        Serial.print(',');`
//      }
  
    FFT.Compute(vReal, vImag, SAMPLES, FFT_REVERSE); //Backward FFT
    FFT.Compute(v2Real, v2Imag, SAMPLES, FFT_REVERSE); //Backward FFT

    FFT.ComplexToMagnitude(vReal, vImag, SAMPLES); //Converting R+iI to real magnitude
    FFT.ComplexToMagnitude(v2Real, v2Imag, SAMPLES); //Converting R+iI to real magnitude

  for (int i = 0; i < 750; i++)
  {
    Serial.print(x[i]/2+850);
    Serial.print(',');
    Serial.print(v2Real[i]-850);
    Serial.print(',');
    Serial.println(vReal[i]-300);
  }
  //Serial.println(SAMPLING_FREQUENCY*index/SAMPLES*60);

  //delay(1000);  //Repeat the process every second OR:

}

```
## *Plot*

<img style="float: right;" src="gifs\actual.gif">
Blue:  Original ppg;


<img style="float: right;" src="gifs\fft.gif">
Blue:  FFT of original signal;


<img style="float: right;" src="gifs\fft2.gif">
Blue: Respiratory component removed frequency response;
Red: PPG component removed frequency response

<img style="float: right;" src="gifs\extracted.gif">
Blue: Extracted Rerspiratory Signal ;
Red: Extracted PPG Signal ;



# Results

| Index of the maxima in ppg fft plot     |  Frequency Value   |  Rate | 
| ----------- | ----------- | ----------- |
|        11 |    0.268   |  16.11 bpm |



## Matlab Implementation

``` matlab
x = load('ppgwithRespiration_25hz_30seconds.mat');
x = x.xppg;

L = 10; Fs = 25;

k = 21;
y = fft(x);

f_ppg = y(:,1:750);
f_res = y(:,1:750);
f_ppg(:,k:750-k) = zeros(1,750-2*k+1);

f_res(:,1:k) = zeros(1,k);
f_res(:,751-k:750) = zeros(1,k);

[~,index] = max(f_ppg(:,2:k));

x_ppg = ifft(f_ppg);
x_res = ifft(f_res);

figure;
subplot(6,1,1)
plot(x);
title('Actual PPG with Respiratory signal')
xlabel('Samples');ylabel('Magnitude')
grid on; axis tight;

subplot(6,1,2)
plot(abs(y));
grid on; axis tight;
xlabel('Samples');ylabel('Magnitude')
title('FFT of the Signal')

subplot(6,1,3)
plot(abs(f_ppg));
grid on; axis tight;
xlabel('Samples');ylabel('Magnitude')
title('FFT of Signal with PPG removed')

subplot(6,1,4)
plot(abs(f_res));
grid on; axis tight;
xlabel('Samples');ylabel('Magnitude')
title('FFT of Signal with Respiratory removed')

subplot(6,1,5)
plot(abs(x_res));
grid on; axis tight;
xlabel('Samples');ylabel('Magnitude')
title('Extracted PPG signal')

subplot(6,1,6)
plot(abs(x_ppg));
grid on; axis tight;
xlabel('Samples');ylabel('Magnitude')
title('Extracted Respiratory signal')

```

<img src="gifs\matlabplot.png">

</br>

# Results (MATLAB)

| Index of the maxima in ppg fft plot     |  Frequency Value   |  Rate | 
| ----------- | ----------- | ----------- |
|        10 |    0.244   |  14.64 bpm |


