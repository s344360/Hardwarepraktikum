function dec=relinquant_Stufe(bin,bits)

dec = message2int(bin,bits);
dec = dec/2^(bits-1)-1;

end