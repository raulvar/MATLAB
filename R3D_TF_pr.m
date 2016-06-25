function [reconst] = R3D_TF_pr(FPlano,FObjeto, XF)
%% PLANO DE REFERENCIA
I=FPlano;
%figure,imagesc(I);
TFI=fft2(I);
ap=1;
gf=figure;
imagesc(fftshift(abs(TFI)));axis('xy');
colormap gray;
if nargin ==2
  ginput(1);
  Z=rbbox;
  M=CoordAxesrbbox(Z);
  XF=round(M)
end
FILTRE=zeros(size(TFI));
FILTRE(XF(2):XF(4),XF(1):XF(3))=1;
FILTRE=fftshift(FILTRE);
close(gf);
TFF=TFI.*FILTRE;
ITF=ifft2(TFF);
M=abs(ITF);
Mask=M/max(M(:));
FASED1=atan2(imag(ITF),real(ITF));
FASED1=(FASED1+abs(min(FASED1(:))));
figure(1);imagesc(FASED1); colormap gray;title(num2str(i));
%PI=round(ginput(1));
PI=size(FObjeto)/2;
[ret1,MaskF1,PhaseCR]=UnWrap2DLigneColonne(FASED1,ones(size(FASED1)),PI);
figure(1);imagesc(PhaseCR);colormap gray;
 
%% PLANO OBJETO
I2=FObjeto;
%figure,imagesc(I2);    
TFI=fft2(I2);
ap=1;    
gf=figure;
hold off
imagesc(fftshift(abs(TFI)));axis('xy');
colormap gray;       

if nargin ==2
ginput(1);
Z=rbbox;
M=CoordAxesrbbox(Z);
XF=round(M)
end
FILTRE=zeros(size(TFI));
FILTRE(XF(2):XF(4),XF(1):XF(3))=1;        
FILTRE=fftshift(FILTRE);
close(gf);
TFF=TFI.*FILTRE;    
ITF=ifft2(TFF);              
M=abs(ITF);
Mask=M/max(M(:));
FASED=atan2(imag(ITF),real(ITF));
FASED=(FASED+abs(min(FASED(:))));
% PI=[1,1];
figure(1);imagesc(FASED); colormap gray;title(num2str(i));
%PI=round(ginput(1));
PI=size(FObjeto)/2;
[ret,MaskF,PhaseC]=UnWrap2DLigneColonne(FASED,ones(size(FASED)),PI);

%figure;imagesc(PhaseC);colormap gray;
%figure, mesh(PhaseC);
 
%% RECONSTRUCCION 3D

% figure,plot(PhaseC(130,:))
% hold on,plot(PhaseCR(130,:),'r')
% plot(-PhaseCR(130,:)+PhaseC(130,:),'k')
% zz=0.95*peaks(264);
% plot(zz(130,:),'g')

reconst= (PhaseC+abs(min(PhaseC(:))))-(PhaseCR+ abs(min(PhaseCR(:))));
%hold on, plot(reconst(130,:),'c')
%n=4;
%figure;mesh(1:n:size(reconst,2),1:n:size(reconst,1),reconst(1:n:size(reconst,1),1:n:size(reconst,2)));
 end