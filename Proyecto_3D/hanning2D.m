function V=hanning2D(Npx,Npy,fox,foy,fcx,fcy)
%Npx=640;
fx=1:Npx;
%fox=300;
%fcx=51;
fxx=fx-fox;
fcx2=(fcx-1)/2;
V1=zeros(1,Npx);
V1(fox-fcx2:fox+fcx2)=1;
VX=V1.*(0.5*(1+cos(2*pi*fxx/fcx)));

%Npy=480;
fy=1:Npy;
%foy=140;
%fcy=101;
fyy=fy-foy;
fcy2=(fcy-1)/2;
V1=zeros(1,Npy);
V1(foy-fcy2:foy+fcy2)=1;
VY=V1.*(0.5*(1+cos(2*pi*fyy/fcy)));

V=VY'*VX;
