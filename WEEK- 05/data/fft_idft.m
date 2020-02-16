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
