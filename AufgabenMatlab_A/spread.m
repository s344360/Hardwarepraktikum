function spr= spread(nutzbits,sc)
    laenge =length(nutzbits);
    x = [];
    
 for i = 1:laenge
  y = sc * nutzbits(i) ;
  x = [x y];
 end
 spr = x;   
end

