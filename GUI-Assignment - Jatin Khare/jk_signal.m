clc;
clear all;
close all;
% Record the Audio 
Fs = 1000;
%recObj = audiorecorder(Fs,8,1);
%recordblocking(recObj,1);
%x = getaudiodata(recObj);
%audiowrite('signal.wav',x,Fs);
x = audioread('signaljk.wav');
W = jatinkhare_Dftmatrix(length(x));
y = abs(W*x);
N = length(x);
figure;
subplot(4,1,1);
plot(x);axis tight; grid on;
xlabel('Time');ylabel('X(t)');title('Time Domain Input')
subplot(4,1,2);
plot(y);axis tight; grid on;
xlabel('Frequency');ylabel('X(w)');title('Frequency Domain Input')
% Removing the Frequency of Max X(w)
[m1,loc] = max(y);
y(loc-20:loc+10)=0;
[m,loc] = max(y);
y(loc-20:loc+10)=0;
subplot(4,1,3);
plot(y);axis tight; grid on;
xlabel('Frequency');ylabel('X(w)');title('Frequency Domain Output')
idft = real(conj(W)*y)/length(x);
subplot(4,1,4);
plot(idft);axis tight; grid on;
xlabel('Time');ylabel('X(t)');title('Time Domain Output')
%audiowrite('signal1.wav',idft,Fs);