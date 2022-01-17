clc;
clear all;
close all;
Fs = 1000;
recObj = audiorecorder(Fs,8,1);
recordblocking(recObj,1);
x = getaudiodata(recObj);
audiowrite('music.wav',x,Fs);
x = audioread('music.wav');
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

[m,loc] = max(y);
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
%audiowrite('musicjk.wav',idft,Fs);