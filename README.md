# **Filter**
Write Arduino programs for studying the performance of the moving average (MA) filter, first-order derivative filter, and second-order derivative filter.

# *Moving Average Filter*
## *Moving Average Filter Equation and transfer function*

<img style="float: right;" src="equations\eqma.png">
<br/>

## *Poles and Zeros*


<img style="float: right;" src="equations\pzma.png">
<br/>

## *Moving Average Filter Magnitude and Phase* 

<img style="float: right;" src="equations\mpma.png">
<br/>

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
### **the plots are given below** - 
<img style="float: right;" src="gifs\ma.gif">
<br/>

 *Moving Average Filter Plot* Blue:  X; Red: Y

<br/>

<img style="float: right;" src="polezero\MA-M.png">
<br/>

 *Moving Average Filter Plot Magnitude Plot* 
<br/>

<img style="float: right;" src="polezero\MA-P.png">
<br/>

 *Moving Average Filter Plot Phase Plot* 


<img style="float: right;" src="polezero\MAPZ.png">
<br/>

 *Moving Average Filter Plot Pole/Zero Plot*

# *First Order Difference Filter*

## *First Order Difference Filter Equation and transfer function*


<img style="float: right;" src="equations\eqfd.png">
<br/>

## *Pole/Zero*

<img style="float: right;" src="equations\dfpz.png">
<br/>

## *First Order Difference Filter Magnitude and phase equation*

<img style="float: right;" src="equations\pmfd.png">
<br/>

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
### **the plots are given below** - 
<img style="float: right;" src="gifs\fdf.gif">
<br/>

 *First Order Difference Filter Plot* Blue:  X; Red: Y

<img style="float: right;" src="polezero\DF-M.png">
<br/>

 *First Order Difference Filter Magnitude Plot*


<img style="float: right;" src="polezero\DF-P.png">
<br/>

 *First Order Difference Filter Phase Plot*   

<img style="float: right;" src="polezero\DFPZ.png">
<br/>

 *First Order Difference Filter Pole/Zero Plot* 


# *Second Order Difference Filter*

## *Second Order Difference Filter Equation and transfer function*

<img style="float: right;" src="equations\eqsf.png">

<br/>

## *Pole/Zero*

<img style="float: right;" src="equations\pzsf.png">
<br/>

## *Second Order Difference Filter Magnitude and phase equation*

<img style="float: right;" src="equations\pmsf.png">
<br/>

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
### **the plots are given below** - 
<img style="float: right;" src="gifs\sf.gif">

 *Second Order Difference Filter Plot* Blue:  X; Red: Y
<br/>


<img style="float: right;" src="polezero\SF-M.png">

 *Second Order Difference Filter Magnitude Plot* 
<br/>


<img style="float: right;" src="polezero\SF-P.png">

 *Second Order Difference Filter Phase Plot*   
<br/>

<img style="float: right;" src="polezero\SFPZ.png">

 *Second Order Difference Filter Pole/Zero Plot* 


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

  *Blue:  X; Red: Y*
<br/>
