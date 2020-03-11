# **DSP Laboratory; Week -06**
# High Pass Filter using Pole Zero Placement Method
## Aim-

Using the pole-zero placement method, design a filter to remove the synthetic baseline from a ppg signal with synthetic baseline frequency components of 0.1 Hz, 0.2 Hz and 0.25 Hz. 

# **1. The Pole Zero Placement Method**

It is a very simple but approximated method for designing filters. We use the z-plane plot to place the poles and zeros at appropriate locations and then find out the transfer function of the filter using the plot.

The z-plane plot is given by:

</br>

<center>
<img src="gifs\pzplace.png">
</center>


</br>
The Transfer Function is given by:

<center>
<img src="gifs\tf.png">
</center>

Source: dsprelated.com

## Concept

In order to remove the freuency components upto 0.4 Hz, we need to follow the following steps:

1. Place a zero at |z|=1, for the frequency 0 Hz. 
2. Place a pole for the frequency 0.4 Hz with |z| = r, where r is given by:
<center>

<img src="equations\r.JPG" width="200">

</center>
3. Transfer function gain b is then calculated using the cut-off frequency, Wc.

# **2. Baseline Filteration using Arduino**

Code

``` cpp

float x[]={-0.875693857,-0.919727917,-0.953165283,-0.973946454...-0.99913659,-1,-0.999465027,-0.985283842,}

const int n = sizeof(x)/sizeof(float);

float e[n];
float k;
float g;
float RMSE;
float SNR;
float sum_e=0;
float x_sq=0;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  float y[n]={0};
  for(int i=0;i<n;i++)
  {
    x[i]+=0.1*sin(2*PI*(0.1/80)*i)+0.2*sin(2*PI*(0.2/80)*i)+0.15*sin(2*PI*(0.25/80)*i);
  }
  k = 2*cos(PI/100);
  g = 0.3564;
  sum_e = 0;
  x_sq = 0;
  for(int i=3;i<n;i++){

    y[i]= 0.9384*y[i-1]+0.9843*x[i]-0.9843*x[i-1];

    //y[i] = g*(x[i]-(k+1)*x[i-1]+(k+1)*x[i-2]-x[i-3]);
    e[i] = y[i]-x[i];
    sum_e += e[i]*e[i];
    x_sq += x[i]*x[i];
  }
  RMSE = sqrt(sum_e/sizeof(x));
  SNR = 10*log(x_sq/sum_e);
  for(int i=0;i<n;i++)
  {
    Serial.print(x[i]);
    Serial.print(",");
    Serial.println(y[i]+5);
    //Serial.print("RMSE :");
    //Serial.print(RMSE);
    //Serial.print(",");
    //Serial.print("SNR :");
    //Serial.println(SNR);

  }
  
  // put your main code here, to run repeatedly:

}


```
## *Plot*

<img style="float: right;" src="gifs\ppg.gif">
Blue:  Original ppg with base line components;
Red: Filtered ppg Signal

</br>

<img style="float: right;" src="gifs\error.gif">
Blue: Error

# **3. Results**

| Root Mean Sqaure Error (RMSE)|  Signal to Noise Ratio (SNR) in dB | 
| ----------- | ----------- | 
|        0.28 |    2.15   | 



## Filter Visualization using Matlab 

``` matlab
r = 0.9686;
zer = [1]'; 
pol = [r*exp(-1i*pi/100)];
[b,a] = zp2tf(zer,pol,1);
fvtool(b,a);
fvtool(b,a,'Analysis','polezero');

```

<img src="gifs\pole_zero.png">


<img src="gifs\magnitude.png">


<img src="gifs\phase.png">


</br>
