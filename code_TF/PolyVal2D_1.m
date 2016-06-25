function matA=polyVal2D_1(TT,x,y,N)
%Function pour evaluer le polynome TT de degree N avec x,y 
%xN xN-1y xN-2y2.....xyN-1 yN
%.......
%x4 x3y x2y2 xy3 y4
%x3 x2y xy2 y3
%x2 xy y2
%x y
%1

NDA=(N+1)*(N+2)/2;

if ischar(x) | ischar(y) | ischar(TT) | ischar(N)
   error('dimension de variables no valida.'); 
   return;
end
if (size(x,1)*size(x,2) == 1) | (size(y,1)*size(y,2) == 1)
   error('dimension de x y y no validas.');
   return;
end

if (size(N,1)*size(N,2) ~= 1 | N<=0)
   error('dimension de N no validas.');
   return;
end

if (length(TT)~=NDA)
   error('dimension de TT no valida.'); 
   return;
end

if ( prod(size(x))== size(x,1) | prod(size(x))== size(x,2) ) & ( prod(size(y))== size(y,1) | prod(size(y))== size(y,2) )
   [X,Y]=meshgrid(x,y);
    x=[];y=[];
elseif ( size(x)==size(y) )
    X=x;Y=y;
    x=[];y=[];
end

[height,width]=size(X);

LX=reshape(X,[width*height 1]);X=[];
LY=reshape(Y,[width*height 1]);Y=[];
A=zeros(length(LY),NDA);
cont=1;
for n=N:-1:0
    for l=n:-1:0
        a=(LX.^l).*(LY.^(n-l));
        A(:,cont)=a;
        cont=cont+1;
    end
end
matA=A*TT;
matA=reshape(matA,[height,width]);