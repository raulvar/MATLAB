function [regis,expo] = armonico( x,m1,m2,a1,a2)
 iend=size(x,1);
 for i=1:iend
     t=0:1/8000:(size(x{i},2)-1)/8000;    
     regis{i,1}= x{i}+ a1*cos(2*pi*262.6*m1*t)+a2*cos(2*pi*261.6*m2*t);
     expo{i,1} = regis{i,1}.*exp(-t);
 end


end

