function spr= spread(nutzbits,sprc)
l=length(nutzbits);
vec=[];

for i=1:l
    mul=sprc*nutzbits(i);
    vec=[vec mul];
end
spr=vec;
end