# **DSP Laboratory; Week -04**
## **Pulse Rate of PPG using DFT;**
## Aim-

To calculate the pulse rate of the PPG signal using DFT and autocorrelation function and find out the error using both the methods.


# Discrete Fourier Transform

Discrete Fourier transform (DFT) converts a finite sequence of equally-spaced samples of a function into a same-length sequence of equally-spaced samples of the discrete-time Fourier transform (DTFT), which is a complex-valued function of frequency.


<img src="equations\ddftt.png"> 

which can be expanded to,

<img src="equations\dft2.JPG">

# Concept
1. Moving Average filter is applied to smooth the signal and remove high frequency components (noise)
2. Find out the DFT of the signal and find the index k for which we get the first peak in magnitude response.

The corresponding frequency for a k index is-

<img src="equations\fre.JPG" width="80">

where

k = index,
Fs = Sampling Frequency,
N = Length of the signal

<img src="equations\pulse.JPG" width="180">


# **1. Pulse Period using DFT**
Find the datafile [HERE](Exp03_PPG_25hz_75samples.csv).

Code
```cpp
float x[75] = {-87.17307638,-109.5495333,11.00037444,......,24.89964724,-5.472668004,-17.77934267};
double w_cos[75][75];
double w_sin[75][75];
double y_real[75];
double y_imag[75];

const double pi = 3.14159;
void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
}

void loop() {
  double resp[75];
  int N=75;
  // put your main code here, to run repeatedly:
  for(int i=0;i<N;i++)
  {
    for(int j=0;j<N;j++)
    {
      w_cos[i][j]=cos((2*pi/N)*i*j);
      w_sin[i][j]=-sin((2*pi/N)*i*j);
       
    }
  }

  double x_fil[N];
  int L=8;
  for(int i=0;i<75;i++)
  {
    x_fil[i]=0;
    for(int j=0;j<L;j++)
    {
      if(i-j>=0)
        x_fil[i]+=x[i-j];
    }
  }
  
  for(int i=0;i<N;i++)
  {
    y_real[i]=0;
    y_imag[i]=0;
    for(int j=0;j<N;j++)
    {
      y_real[i]+=x_fil[j]*w_cos[i][j];
      y_imag[i]+=x_fil[j]*w_sin[i][j];
      resp[i] = sqrt(y_real[i]*y_real[i]+y_imag[i]*y_imag[i]);
    }
    Serial.println(resp[i]);

    }

    double max=0;
    int k;
  for(int i=0;i<N;i++)
  {
    if(resp[i]>max)
    {
      max=resp[i];
      k = i;
    }
  }
  //Serial.println(k*Fs/N*60)*
 
  }

```
## *Plot*

<img style="float: right;" src="gifs\ppg1.webp">
Blue:  Original ppg;

<img style="float: right;" src="gifs\dft.gif">
Blue: DFT Function; 




# **2. Pulse period using Autocorrelation**

Find the datafile [HERE](data/Exp03_PPG_25hz_75samples.csv).

Code
```cpp
float x[75] = {-87.17307638,-109.5495333,......,24.89964724,-5.472668004,-17.77934267};

void setup() {// put your setup code here, to run once:
   Serial.begin(9600); //Setting up the baud rate 
}

void loop() { // put your main code here, to run repeatedly:
 
  float mean;
  //Moving Average filter
  for(int i=0;i<75;i++)  //for loop for 75 times
  {
  mean = mean+x[i];

    //Serial.println(x[i]); //plotting input x
  }
  //subtracting mean
  for(int i=0;i<75;i++)
    {
      x[i]=x[i]-mean/75;
    }

 
    float energy=0;
    for(int i=0;i<500;i++)
    {
      energy = energy+x[i]*x[i];
    }
    
  //ACF
  float acf[500];
    for(int i=0;i<500;i++)
  {
    acf[i]=0; //Initializing all zero
  }
    for(int k=0;k<500;k++)
    {
      for(int i=0;i<500;i++)
      {
      if((i+k)<500)
      acf[k] = acf[k]+x[i]*x[i+k];
      }
      acf[k] = acf[k]/energy;
    Serial.println(acf[k]); //plotting output y
    }

 //first zero crossing
    int zero;
    for(int z=0;z<499;z++)
    {
      if(acf[z]*acf[z+1]<0)
      {
      zero = z;
      break;
      }
    }
    //first maxima after z
    int maxima=0;
    for(int k=zero;k<499;k++)
    {
      if((acf[k]>0&&acf[k+1]>0)&&(acf[k+1]<acf[k]))
      {
        maxima = k+1;
        break;
      }
    }
    float numerator = 60*100;
    float ans = numerator/maxima;
    //Serial.println(ans);
    }

```

# Results

| Pulse Rate using DFT  (in Beats/Min)     |  Pulse Rate using Autocorrelation  (in Beats/Min)   |  Error | 
| ----------- | ----------- | ----------- |
|    71   |    80    |  12.67% | 



## Matlab Implementation

``` matlab
x = load('Exp03_PPG_25hz_75samples.mat');
data = x.x3;
filter_window = 10;
filtered_data = zeros(size(data));
F = 25;

% Moving Average
for i = 1:size(data,2)
    x = 0;
    if i <= filter_window
        x = sum(data(1:i));
    else
        x = sum(data(i-filter_window:i));
    end
    filtered_data(i) = x / filter_window;
end

% DFT and DFT Matrix
dft = fft(filtered_data);
dft_matrix = dftmtx(size(filtered_data,2));
[~, index] = max(abs(dft));


figure(1);
plot(abs(dft),'k','LineWidth',2);
title('Magnitude Response');
xlabel('Frequency'); ylabel('Magnitude Value');
set(gca,'FontSize',16);
axis tight; grid on;

% Calculation of Pulse Rate
display(60*index*F/size(filtered_data,2));

% Pulse rate through autocorrelation

corr = xcorr(filtered_data - mean(filtered_data));
corr = corr(76:end);

figure(1);
plot(corr,'k','LineWidth',2);
set(gca,'FontSize',16);
xlabel('Time');
ylabel('Magnitude Value');
title('Autocorrelation');
axis tight; grid on;

% Zero Crossing 

zcr_i = 0;
for i=1:size(corr, 2)
    if corr(i+1) * corr(i) < 0
        zcr_i = i + 1;
        break
    end
end

% Pulse Rate using Autocorrelation

[~, index_C] = max(corr(zcr_i:end));
index_C = zcr_i + index_C;
display(60/(index_C/25));
```

<img src="gifs\mdft.png">

*DFT magnitude spectrum plot using matlab.*

</br>

<img src="gifs\mauto.png">

*Autocorrelation plot using matlab.*

</br>

# Results (MATLAB)

| Pulse Rate using DFT  (in Beats/Min)     |  Pulse Rate using Autocorrelation  (in Beats/Min)   |  Error | 
| ----------- | ----------- | ----------- |
|        80 |     68.1   |  17.47% |
