function [mtr2 , mtr1] = hilbert2(imagen_i,tt)
% Parametros
%   mtr2 =  hilbert2rj(imag); Devuelve la transformada doble de hilbert por
%   filas de la imagen imag. 
%   [mtr2 , mtr1] = hilberth2rj(imag) : Devuelve la primera y la segunda
%   transformada de hilbert de la la imagen imag
if nargin ==1
    tt='x4';
end
imagen=double(imagen_i);
mtr1 = zeros(size(imagen));
mtr2 = mtr1;
h=size(imagen,2);
for i=1:size(imagen,1)
    if (strcmp(tt,'x4'))
    p1 =       peakfinder( double(imagen(i,1:end/4)),[],[],[],0);
    p2 =   h/4+peakfinder( double(imagen(i,end/4:end/2)),[],[],[],0);
    p3 =   h/2+peakfinder( double(imagen(i,end/2:3*end/4)),[],[],[],0); 
    p4 = 3*h/4+peakfinder( double(imagen(i,3*end/4:end)),[],[],[],0);   
    maxi{i} = [p1,p2,p3,p4];

    v1 =       peakfinder(-double(imagen(i,1:end/4)),[],[],[],0);
    v2 =   h/4+peakfinder(-double(imagen(i,end/4:end/2)),[],[],[],0);
    v3 =   h/2+peakfinder(-double(imagen(i,end/2:3*end/4)),[],[],[],0); 
    v4 = 3*h/4+peakfinder(-double(imagen(i,3*end/4:end)),[],[],[],0);  
    mini{i} = [v1,v2,v3,v4];
    end
    if (strcmp(tt,'x1'))
            maxi{i} = peakfinder(double(imagen(i,:)));
            mini{i} = peakfinder(-double(imagen(i,:)));
    end
       %inte = [1,sort([mini{i},maxi{i}]),size(imagen,2)]; %intervalos
    inte = sort([mini{i},maxi{i}]);  % Ordeno los maximos y minimos
    for j=1:size(inte,2)-1
        if j==1
            t=0;
        else
            t=0;
        end
        if j==152
           vb=1; 
        end
        while (inte(j) == inte(j+1))
            j=j+1;            
        end
        if inte(j+1)>h
            inte(j+1)=h;
        end
        if inte(j)+1>h
            inte(j)=h-1;
        end
        pw = imagen(i,inte(j)+t:inte(j+1));
        d1= hilbert(pw'); 
        d11=-imag(d1);
        d2= hilbert(d11);
        d22= -imag(d2);  % transformada de hilbert doble de pw
        mtr1(i,inte(j)+t:inte(j+1))=d11';
        mtr2(i,inte(j)+t:inte(j+1))=d22'; 
%         plot(inte(j):inte(j+1),pw,'b')
%         hold on
%         xlim([0 300])
%         plot(inte(j):inte(j+1),d22','r')
    end
%     plot(imagen(i,:))
%     hold on
%     plot(mtr2(i,:),'r')



end
