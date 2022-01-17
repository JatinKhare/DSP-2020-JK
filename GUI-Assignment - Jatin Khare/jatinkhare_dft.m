clc;clear all; close all;

% Generate the DFT matrix for the fivenm value of n;

% fo = 50Hz, Fs = 1000; t = 1/10sec
% for five cycles 
% No. of samples = 100;
fo = 50; Fs = 1000; N = 100;
n = 0:99;
x = sin(2*pi*fo/Fs*n);
x0 =x;

[W] = jatinkhare_Dftmatrix(N);W1 = W;
X = abs(W*x');
k1 = 0:1:(N-1); f1 = k1*Fs/N; X1 = X;
% plotting for 5 cycles
figure;
subplot(3,1,1)
plot(x);grid on;axis tight;
xlabel('Time');ylabel('Amplitude');title('5 Cycles')
subplot(3,1,2);
plot(k1,X);
grid on;axis tight;
xlabel('Index');ylabel('')
subplot(3,1,3)
plot(f1,X);grid on;axis tight;
xlabel('Frequency');ylabel('')


% For 20 Cycles
fo = 50; Fs = 1000; N = 400; 
n = 0:399;
x = sin(2*pi*fo/Fs*n);

[W] = jatinkhare_Dftmatrix(N);

X = abs(W*x');X2 = X;
k2 = 0:1:(N-1);
f2 = k2*Fs/N;

figure;
subplot(3,1,1)
plot(n,x);grid on;axis tight;title('20 Cycles')
xlabel('Time');ylabel('Amplitude')
subplot(3,1,2)
plot(k2,X);grid on; axis tight;
xlabel('Index');ylabel('')
subplot(3,1,3)
plot(f2,X);grid on;axis tight;
xlabel('Frequency');ylabel('')

% combined plot for 5 cycles and 20 cycles, k and f
figure;

subplot(4,1,1)
plot(k1,X1);grid on; axis tight;xlabel('Index');ylabel('X(w)');title('5 cycles');
subplot(4,1,2)
plot(f1,X1);grid on; axis tight;xlabel('Frequency');ylabel('X(w)');title('5 cycles');
subplot(4,1,3)
plot(k2,X2);grid on; axis tight;xlabel('Index');ylabel('X(w)');title('20 cycles');
subplot(4,1,4)
plot(f2,X2);grid on; axis tight;xlabel('Frequency');ylabel('X(w)');title('20 cycles');



fo = 80; Fs = 1000; N = 100;
n = 0:99;
x = sin(2*pi*fo/Fs*n);
x3 = x+x0

[W] = jatinkhare_Dftmatrix(N);W1 = W;
X = abs(W*x3');

k1 = 0:1:(N-1); f1 = k1*Fs/N; X1 = X;
figure;
subplot(2,1,1);
plot(x3);grid on; axis tight;xlabel('Time');ylabel('Amplitude');title('Before Filtering:50Hz+80Hz');


X(94:96)=0;X(4:6)=0;  %Removing 50Hz Component

x1 = real(conj(W1)*X)/N;
subplot(2,1,2);
plot(x1);grid on; axis tight;xlabel('Time');ylabel('Amplitude');title('After Filtering:50Hz');



