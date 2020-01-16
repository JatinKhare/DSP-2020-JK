# **DSP Laboratory; Week -01**
## **Filter Analysis**
Write Arduino programs for studying the performance of the moving average (MA) filter, first-order derivative filter, and second-order derivative filter. <br/>
Lab Sheet can be found [here](pdf/DSP-Experiment01.pdf).
# **Moving Average Filter**
## *Moving Average Filter Equation and transfer function*
<img src="equations\eqma.png" width="618" height="197"> <br/>

## *Poles and Zeros*
<img src="equations\pzma.png" width="735" height="54"> <br/>


## *Moving Average Filter Magnitude and Phase* 
<img src="equations\mpma.png" width="481" height="80"> <br/><br/>

### **the plots are given below** - 
<img style="float: right;" src="polezero\MA-M.png"  width="600" height="325">
<br/>

##### **Moving Average Filter Plot Magnitude Plot**
<br/>

<img style="float: right;" src="polezero\MA-P.png" width="600" height="325">
<br/>

##### **Moving Average Filter Plot Phase Plot**


<img style="float: right;" src="polezero\MAPz.png" width="540" height="432">
<br/>

##### **Moving Average Filter Plot Pole/Zero Plot**

<br/>

## **Arduino Code**
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

<img style="float: right;" src="gifs\ma.gif">
<br/>

 *Moving Average Filter Plot* Blue:  X; Red: Y

<br/>


# **First Order Difference Filter**

## *First Order Difference Filter Equation and transfer function*

<img src="equations\eqfd.png" width="392" height="105"> <br/>

## *Pole/Zero*
<img  src="equations\dfpz.png" width="499" height="55"> <br/>

## *First Order Difference Filter Magnitude and phase equation*
<img src="equations\pmfd.png" width="499" height="55"> <br/>

### **First Order Difference Filter Magnitude Plot**

<img style="float: right;" src="polezero\DF-M.png" width="600" height="325"> 

### **First Order Difference Filter Phase Plot** 
<img style="float: right;" src="polezero\DF-P.png" width="600" height="325"> 

### **First Order Difference Filter Pole/Zero Plot**
<img style="float: right;" src="polezero\DFPZ.png" width="540" height="432"> <br/>
<br/>

## **Arduino Code**

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
##### **the plot is given below** - 
<img style="float: right;" src="gifs\fdf.gif">

##### **First Order Difference Filter Plot Blue:  X; Red: Y**

<br/>

 
# **Second Order Difference Filter**

## *Second Order Difference Filter Equation and transfer function*

<img src="equations\eqsf.png" width="586" height="130">
<br/>

## *Pole/Zero*

<img src="equations\pzsf.png" width="447" height="50">
<br/>

## *Second Order Difference Filter Magnitude and phase equation*

<img src="equations\pmsf.png" width="554" height="57">
<br/>


<img style="float: right;" src="polezero\SF-M.png" width="600" height="325">

##### **Second Order Difference Filter Magnitude Plot** 
<br/>


<img style="float: right;" src="polezero\SF-P.png" width="600" height="325">

##### **Second Order Difference Filter Phase Plot** 
<br/>

<img style="float: right;" src="polezero\SFPZ.png" width="540" height="432">

 ##### **Second Order Difference Filter Pole/Zero Plot**

## ***Arduino Code***

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

##### **Second Order Difference Filter Plot Blue:  X; Red: Y**

# **First Order Difference Filter and Smoothing with Moving Average**



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

##### **Smoothed First Order Difference Filter Plot Blue:  X; Red: Y**

<br/>
