# **DSP Laboratory; Week -03**
## **Frequncy of PPG and Speech signal;**
## Aim-

To calculate the frequncy of the ppg signal and recorded speech signal using autocorrelation function.


# Autocorrelation
Autocorrelation, also known as serial correlation, is the correlation of a signal with a delayed copy of itself as a function of delay.

<img src="equations\auto.JPG"> 
where,
<img src="equations\range.JPG"> 
<img src="gifs\theory.JPG"> 




# **1. Frequency of PPG signal**
Find the datafile [HERE](PPG_Fs_100hz_2000samples.csv).

Code
```cpp
float x[2000] = {-148.6621707,-248.3187771,-267.1305467,.....,-214.9804372,-215.9746394,-210.90232
};
void setup() {// put your setup code here, to run once:
   Serial.begin(9600); //Setting up the baud rate 
}

void loop() { // put your main code here, to run repeatedly:
  
 float y[2000];  //array to store the moving average
  for(int i=0;i<2000;i++)
  {
    y[i]=0; //Initializing all zero
  }
  int l = 10;
  float mean;
  //Moving Average filter
  for(int i=0;i<2000;i++)  //for loop for 2000 times
  {
    for(int j=0;j<l;j++)
    {
      if(i>j)
      {
        y[i]=y[i]+x[i-j];
      }
     }
  mean = mean+y[i];

    //Serial.print(x[i]); //plotting input x
    //Serial.print(',');
    //Serial.println(y[i]/l+400); //plotting output y
  }
  //subtracting mean
  for(int i=0;i<2000;i++)
    {
      y[i]=y[i]-mean/2000;
    }


  float blocks[500];
  int no_block = 4;
  
  for(int j=0;j<no_block;j++)
  {
    for(int i=0;i<500;i++)
    {
      blocks[i]=y[i+500*j];
    }
    //Energy of signal
    float energy=0;
    for(int i=0;i<500;i++)
    {
      energy = energy+blocks[i]*blocks[i];
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
      acf[k] = acf[k]+blocks[i]*blocks[i+k];
      }
      acf[k] = acf[k]/energy;
    //Serial.println(20*acf[k]); //plotting output y
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
    Serial.println(ans);
    }
    
  }
```

# Results

## *Plot*

<img style="float: right;" src="gifs\ppg.gif">
Blue:  Original ppg; Red: Moving Average filtered ppg

<img style="float: right;" src="gifs\ppg_acf_filtered.gif">
Blue: Autocorrelation Function (Filtered ppg); 

<img style="float: right;" src="gifs\ppg_acf_non_filtered.gif">
Blue:  Autocorrelation Function (Non-filtered ppg); 

# Frequency Values

| Filtered ppg Frequency  (in Beats/Sec)     |  Non-Filtered ppg Frequency  (in Beats/Sec)   |  Error | 
| ----------- | ----------- | ----------- |
| 68.18      | 65.22       |  4.34% |
| 65.93   | 67.42        |  2.25% |
| 61.22   | 60.61        | 0.9% |
| 66.67  | 65.22        | 2.17%|
|Average: 65.50   | Average: 64.61        | Average Error: 2.35%|




# **2. Frequency of sppech signal**

Find the datafile [HERE](data/speechdata_4001samples_8000hzsampling.csv).

Code
```cpp
float x[2000] = {0.807525635,0.821929932,0.55090332,.....,0.01373291,0.009490967,0.0027771};
void setup() {// put your setup code here, to run once:
   Serial.begin(9600); //Setting up the baud rate 
}

void loop() { // put your main code here, to run repeatedly:
  
 float y[4000];  //array to store the moving average
  for(int i=0;i<4000;i++)
  {
    y[i]=0; //Initializing all zero
  }
  int l = 2;
  float mean;
  //Moving Average filter
  for(int i=0;i<4000;i++)  //for loop for 4000 times
  {
    for(int j=0;j<l;j++)
    {
      if(i>j)
      {
        y[i]=y[i]+x[i-j];
      }
     }
  mean = mean+y[i];

    //Serial.print(100*x[i]); //plotting input x
    //Serial.print(',');
    //Serial.println(100*y[i]/l+200); //plotting output y
  }
  //subtracting mean
  for(int i=0;i<4000;i++)
    {
      y[i]=y[i]-mean/4000;
    }


  float blocks[1000];
  int no_block = 4;
  
  for(int j=0;j<no_block;j++)
  {
    for(int i=0;i<1000;i++)
    {
      blocks[i]=y[i+1000*j];
    }
    //Energy of signal
    float energy=0;
    for(int i=0;i<1000;i++)
    {
      energy = energy+blocks[i]*blocks[i];
    }
    
  //ACF
  float acf[1000];
    for(int i=0;i<1000;i++)
  {
    acf[i]=0; //Initializing all zero
  }
    for(int k=0;k<1000;k++)
    {
      for(int i=0;i<1000;i++)
      {
      if((i+k)<1000)
      acf[k] = acf[k]+blocks[i]*blocks[i+k];
      }
      acf[k] = acf[k]/energy;
    Serial.println(20*acf[k]); //plotting output y
    }

 //first zero crossing
    int zero;
    for(int z=0;z<999;z++)
    {
      if(acf[z]*acf[z+1]<0)
      {
      zero = z;
      break;
      }
    }
    //first maxima after z
    int maxima=zero;
    for(int k=zero+1;k<999;k++)
    {
      if(acf[k]>acf[maxima])
      {
        maxima = k;
      }
    }
    float numerator = 8000;
    float ans = numerator/maxima;
    //Serial.println(ans);
    }
    
  }
 
```

# Results

## *Plot*

<img style="float: right;" src="gifs\speech.gif">
Blue:  Original ppg; Red: Moving Average filtered ppg

<img style="float: right;" src="gifs\speech_acf.gif">
Blue: Autocorrelation Function (Filtered ppg); 

# Frequency Values

| Fundamental Frequency (in Hz)     | 
| ----------- | 
| 148.15      |
| 153.85   | 
| 145.45   | 
| 142.86  | 
|Average:  147.57   | 
