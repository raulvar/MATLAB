function nota = Nota(n,t)
ti= 0:1/8000:t/2;
nota = cos(2*pi*220*2^(n/12)*ti);
end

