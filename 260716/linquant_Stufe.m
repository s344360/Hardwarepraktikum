function bin=linquant_Stufe(sig,bits)

stufen = round(((sig+1)/2)*(2^bits-1));
bin = int2message(stufen, bits);
bin = bin'; %tansponiert

end