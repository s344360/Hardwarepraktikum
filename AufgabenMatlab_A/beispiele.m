[a, b, c] = wavread('aloha')
d = linquant_Stufe(a,2)
e = relinquant_Stufe(d,2)

plot(a)
a