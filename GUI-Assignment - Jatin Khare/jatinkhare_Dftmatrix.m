function [W] = jatinkhare_Dftmatrix(N)

for k = 1:N
    for n = 1: N
        W(k,n) = exp(-1j*(2*pi*(n-1)*(k-1))/N);
    end
end
