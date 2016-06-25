function [mtr2 , mtr1] = hilbert2rj(imagen)
% Parametros
%   mtr2 =  hilbert2rj(imag); Devuelve la transformada doble de hilbert por
%   filas de la imagen imag. 
%   [mtr2 , mtr1] = hilberth2rj(imag) : Devuelve la primera y la segunda
%   transformada de hilbert de la la imagen imag
mtr2= zeros(size(imagen));
mtr1= mtr2;
for i=1:size(imagen,1)
d1= hilbert(imagen(i,:));
d11=-imag(d1);
d2= hilbert(d11);
d22= -imag(d2); 
mtr1(i,:)=d11;
mtr2(i,:)=d22;
end
end

