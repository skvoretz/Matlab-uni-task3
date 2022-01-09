function res = fftfunc1(s)
res = 1/5*sqrt(pi/10)*exp(-s/sqrt(5)).*((10+1i*sqrt(5))*exp(2*s/sqrt(5)).*heaviside(-s) + (10-1i*sqrt(5))*heaviside(s)) ;
end