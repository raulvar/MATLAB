function vector = reg2vector( reg )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
n = size(reg,1);
vector=reg{1};
for i=2:n
    vector = [vector reg{i}];
end


end

