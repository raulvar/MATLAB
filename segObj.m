function seg = segObj( imagen )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[variaX,variaY]=imgradientxy(imagen); 
seg= variaY> 0.2*max(variaY(:));


end

