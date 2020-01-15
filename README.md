# **Filter**
Write Arduino programs for studying the performance of the moving average (MA) filter and first-order derivative filter as described below:
1. Moving Average Filter: $𝑦[𝑛]=\frac{1}{𝐿+1}\sum_{k=0}^{L}𝑥[𝑛−𝑘]$
   
2. Derivative Filter, first-order difference: $𝑦[𝑛]=𝑥[𝑛]−𝑥[𝑛−1]$
   
3. Derivative Filter, three-point central difference: $𝑦[𝑛]=𝑥[𝑛]−𝑥[𝑛−2]$
   
<br/>

# *Moving Average Filter*



## **Code**
```cpp
//Input data; global declaration
float x[1000] = {-194.7293734,-228.7205774,-241.1012313,...-144.4504403,-139.3705715,-155.2151228};

void setup() // put your setup code here, to run once:
{
  Serial.begin(9600); //Setting up the baud rate
}
void loop() // put your main code here, to run repeatedly:
{
  float y[1000];  //array to store the moving average
  for(int i=0;i<1000;i++)
  {
    y[i]=0; //Initializing all zero
  }
  int l = 800;
  
  //Moving Average filter
  for(int i=0;i<1000;i++)  //for loop for 1000 times
  {
    for(int j=0;j<l;j++)
    {
      if(i>j)
      {
        y[i]=y[i]+x[i-j];
      }
      y[i]=y[i]/l;
    }
    Serial.print(x[i]/100); //plotting input x
    Serial.print(',');
    Serial.println(y[i]);  //plotting output y
  }
}
```
### **the plot is given below** - 
<img style="float: right;" src="gifs\ma.gif">

 *Moving Average Filter Plot* Blue:  X; Red: Y
<br/>
<br/>

<img style="float: right;" src="polezero\MA-M.png">

 *Moving Average Filter Plot Magnitude Plot* Blue:  X; Red: Y
<br/>
<br/>

<img style="float: right;" src="polezero\MA-P.png">

 *Moving Average Filter Plot Phase Plot* Blue:  X; Red: Y

<br/>
<br/>
<img style="float: right;" src="polezero\MAPZ.png">

 *Moving Average Filter Plot Pole/Zero Plot* Blue:  X; Red: Y

# *First Order Difference Filter*



## ***Code***

```cpp

//Input data; global declaration
float x[1000] = {-194.7293734,-228.7205774,-241.1012313,...-144.4504403,-139.3705715,-155.2151228};

void setup() // put your setup code here, to run once:
{
  Serial.begin(9600); //Setting up the baud rate
}

void loop() // put your main code here, to run repeatedly:
{
  float y[1000];  //array to store the difference
  for(int i=0;i<1000;i++)
  {
    y[i]=0;  //Initializing all zero
  }

  y[0]=x[0];
  //first order difference filter
  for(int i=1;i<1000;i++) //for loop for 1000 times
  {
    y[i]=x[i]-x[i-1];
    Serial.print(x[i]); //plotting input x
    Serial.print(',');
    Serial.println(y[i]); //plotting output y
  }
}
```
### **the plot is given below** - 
<img style="float: right;" src="gifs\fdf.gif">

 *First Order Difference Filter Plot* Blue:  X; Red: Y
<br/>
<br/>

<img style="float: right;" src="polezero\DF-M.png">

 *First Order Difference Filter Magnitude Plot* Blue:  X; Red: Y
<br/>
<br/>

<img style="float: right;" src="polezero\DF-P.png">

 *First Order Difference Filter Phase Plot* Blue:  X; Red: Y

<br/>
<br/>
<img style="float: right;" src="polezero\DFPZ.png">

 *First Order Difference Filter Pole/Zero Plot* Blue:  X; Red: Y


# *Second Order Difference Filter*



## ***Code***

```cpp
//Input data; global declaration
float x[1000] = {-194.7293734,-228.7205774,-241.1012313,...-144.4504403,-139.3705715,-155.2151228};

void setup() // put your setup code here, to run once:
{
  Serial.begin(9600); //Setting up the baud rate
}

void loop() // put your main code here, to run repeatedly:
{
  float y[1000];
  for(int i=0;i<1000;i++)
  {
    y[i]=0; //Initializing all zero
  }

  y[0]=x[0]; y[1]=x[1];
  
  //Second order difference filter
  
  for(int i=2;i<1000;i++) //for loop for 1000 times
  {
    y[i]=x[i]-x[i-2];
    Serial.print(x[i]); //plotting input x
    Serial.print(',');
    Serial.println(y[i]); //plotting output y
  }
 }
```
### **the plot is given below** - 
<img style="float: right;" src="gifs\sf.gif">

 *Second Order Difference Filter Plot* Blue:  X; Red: Y
<br/>
<br/>

<img style="float: right;" src="polezero\SF-M.png">

 *Second Order Difference Filter Magnitude Plot* Blue:  X; Red: Y
<br/>
<br/>

<img style="float: right;" src="polezero\SF-P.png">

 *Second Order Difference Filter Phase Plot* Blue:  X; Red: Y

<br/>
<br/>
<img style="float: right;" src="polezero\SFPZ.png">

 *Second Order Difference Filter Pole/Zero Plot* Blue:  X; Red: Y


# *First Order Difference Filter and Smoothing with Moving Average*



## ***Code***

```cpp
//Input data; global declaration
float x[1000] = {-194.7293734,-228.7205774,-241.1012313,...-144.4504403,-139.3705715,-155.2151228};


void setup() // put your setup code here, to run once:
{
  Serial.begin(9600); //Setting up the baud rate
}
void loop() // put your main code here, to run repeatedly:
{
  float y[1000];  //array to store the difference
  y[0]=x[0];
  
  //first order difference filter
  
  for(int i=1;i<1000;i++)
  {
    y[i]=x[i]-x[i-1];
  }
  int l = 80;
  float y1[1000]; //array to store the moving average
  
  for(int i=0;i<1000;i++)
  {
    y1[i]=0;  //Initializing all zero
  }
  //ma filter
  for(int i=0;i<1000;i++)
  {
    for(int j=0;j<l;j++)
    {
      if(i>j)
      {
        y1[i]=y1[i]+y[i-j];
      }
        y1[i]/l;
    }
  Serial.print(x[i]);
  Serial.print(',');
  //Serial.print(y[i]*100);
  //Serial.print(',');
  Serial.println(y1[i]/(1.5));
  }
}
```

### **the plot is given below** - 
<img style="float: right;" src="gifs\sf.gif">

 *Plot* Blue:  X; Red: Y
<br/>
