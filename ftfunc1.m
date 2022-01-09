function res = ftfunc1(s)
res =  1/5*sqrt(pi/10)*exp(-s/sqrt(5)).*((21-1i*10.5)*exp(2*s/sqrt(5)).*heaviside(-s) + (21+1i*10.5)*heaviside(s)) ;
end