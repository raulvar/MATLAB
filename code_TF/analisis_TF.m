%analisis de un sistema de franjas usando algoritmo de la TF
%Nom pede ser el nombre del archivo *.tif o la imagen (variable double)
function [phased,FILTRE,M0,XF,CE]=analisis_TF(Nom,XF,CE)

if (nargin ==2)
if (numel(XF)~=4)
  error('XF tiene que ser un vector de 4 posiciones');
  return;
end
end

if ischar(Nom)
    if isempty(dir(Nom))
       phased=[];
       error('Archivo no existe...');
       phased=[];
       return;
    end
    temp = imread(Nom);
    if size(temp,3)>1
        IM=double(rgb2gray(imread(Nom)));
    else
        IM=double(imread(Nom));
    end
elseif isnumeric(Nom)    
        if size(Nom,3)>1
        IM=double(rgb2gray(Nom));
    else
        IM=double(Nom);
    end
end
    
figure(1);imagesc(IM);colormap(gray);
width=size(IM,2);height=size(IM,1);

%calculo de la fase a partir de la TF
TF=fft2(IM);
choice = questdlg('Seleccione visualizacion?', ...
	'Dessert Menu', ...
	'Normal','Log','Log');

switch choice
    case 'Normal'
        fg1=figure;imagesc(fftshift(abs(TF)));colormap(gray);
    case 'Log'
        fg1=figure;imagesc(fftshift(log(abs(TF))));colormap(gray);
end


%
ap=1;
while ap
   figure(fg1);
   if nargin==1
   CE=round(ginput(1));
   ginput(1);Z=rbbox;X=CoordAxesrbbox(Z);
   XF=round(X);
   end
   if(XF(1)>XF(3))
      S=XF(1);XF(1)=XF(3);XF(3)=S;
   end
   if(XF(2)>XF(4))
      S=XF(2);XF(2)=XF(4);XF(4)=S;
   end
%   CEX=CE(1)-round(dx/2);
%   CEY=CE(2)-round(dy/2);
dx=XF(3)-XF(1);dy=XF(4)-XF(2);
Gx=hanning(dx);
Gy=hanning(dy);
%   EX=-round(dx/2)+1:dx/2;
%   EY=-round(dy/2)+1:dy/2;
%   Gx=gauss(EX-CEX,round((XF(3)-XF(1))/4));
%   Gy=gauss(EY-CEY,round((XF(4)-XF(2))/4));
   AA=Gy*Gx';
   AA=(AA-min(AA(:)))/(max(AA(:))-min(AA(:)));
 	FILTRE=zeros(size(TF));
    x2=round((XF(3)-XF(1))/2);
    y2=round((XF(4)-XF(2))/2);
    FILTRE(CE(2)-y2+1:CE(2)-y2+dy,CE(1)-x2+1:CE(1)-x2+dx)=AA;
% 	FILTRE(XF(2):XF(4),XF(1):XF(3))=ones(XF(4)-XF(2)+1,XF(3)-XF(1)+1);
 	FILTRE=fftshift(FILTRE);
	TF1=TF.*FILTRE;
% 	TFI=IFFT2(TF1);
    TFI=ifft2(TF1);
    IMA=imag(TFI);
    REA=real(TFI);
   phased=atan2(IMA,REA);
   M0=sqrt(IMA.*IMA+REA.*REA);
    fig2=figure;imagesc(phased);colormap(gray);
   s=questdlg('Desea cambiar el filtro');
   switch s,
	   case 'Yes',ap=1;	
	   case 'No', ap=0;
	   case 'Cancel',phased=[];close(fig2);return;
   end
   close(fig2);
end
close(fg1);

