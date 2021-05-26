function reliquan = relinquant_Stufe(signal, bits)
reliquan = message2int(signal, bits);

reliquan = reliquan / 2^(bits-1) - 1;
reliquan
end