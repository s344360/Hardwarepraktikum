function e = sample(a,fs,neuefs)

b=length(a)/fs;
abstand=floor(b*neuefs);
x=linspace(1,length(a),abstand);
e=interp1(a,x);

end