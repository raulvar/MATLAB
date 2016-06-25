% Do : 3
% Re : 5
% Mi : 7
% Fa : 8
% Sol: 10
% La: 12
% Si: 14
x= {Nota(3,1); Nota(7,1);Nota(7,1);Nota(7,1);Nota(5,1/2);Nota(3,1/2);Nota(10,3);Nota(10,1) ...
    ;Nota(8,1);Nota(7,1);Nota(7,1);Nota(7,1);Nota(5,1/2);Nota(3,1/2);Nota(10,3)};
s=reg2vector(x);
soundsc(s,8000)
%%
[p,expo]=armonico(x,0.75,0.3,0,0);
s2=reg2vector(p);
s3=reg2vector(expo);
soundsc(s2,8000)
%soundsc(s3,8000)