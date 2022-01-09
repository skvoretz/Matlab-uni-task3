function res = fftfunc2(s)
res = -1i*sin(s/2).*exp(1/4-(s.^2)/4)/sqrt(2);
end