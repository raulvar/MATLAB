function [reconst] = R3D_TF(FPlano,FObjeto)

%% PR
I=double(FPlano);
TFI=fft2(I); % Transformada de fourier
% Mascara para filtrado del pico derecho
gf=figure;
imagesc(fftshift(abs(TFI)));axis('xy');
colormap gray;
ginput(1);
Z=rbbox;
M=CoordAxesrbbox(Z);
XF=round(M)
FILTRE=zeros(size(TFI));
FILTRE(XF(2):XF(4),XF(1):XF(3))=1;
FILTRE=fftshift(FILTRE);
close(gf);
TFF=TFI.*FILTRE;
ITF=ifft2(TFF); %Transformada inversa
        
%Calculo de la fase:
    
M=abs(ITF);
Mask=M/max(M(:));
FASED=atan2(imag(ITF),real(ITF));
FASED=(FASED+abs(min(FASED(:))));
figure;imagesc(FASED); colormap gray;title(num2str(i));

%Correccion de fase
PI=round(ginput(1));
[ret,MaskF,PhaseCR]=UnWrap2DLigneColonne(FASED,ones(size(FASED)),PI);
% figure, imagesc(PhaseCR);colormap gray;
% figure, mesh(PhaseC);
%%
% %%%%%%%%%%%%%%%%%%%%
% %Eliminar Portadora
% %%%%%%%%%%%%%%%%%%%%
% 
% 
% TT=Polyfit2D_1(PhaseC,ones(size(PhaseC)),1:size(PhaseC,2),1:size(PhaseC,1),2);
% matA=PolyVal2D_1(TT,1:size(PhaseC,2),1:size(PhaseC,1),2);
% PhaseCT=PhaseC-matA;
% % AA=PhaseCT(10:size(PhaseCT,1)-10,10:size(PhaseCT,2)-10);
% % figure;imagesc(AA);colormap gray;
% % n=4;
% % figure;mesh(1:n:size(AA,2),1:n:size(AA,1),AA(1:n:size(AA,1),1:n:size(AA,2)));

%% OBJ
I=double(FObjeto);
%figure,imagesc(I);

%TRANSFORMADA DE FOURIER DE LA IMAGEN
TFI=fft2(I);
% SE CONSTRUYE UNA MASCARA PARA FILTRAR EL PICO DERECHO DE LA TRANSFORMADA DE FOURIER
gf=figure;
imagesc(fftshift(abs(TFI)));axis('xy');
colormap gray;
ginput(1);
Z=rbbox;
M=CoordAxesrbbox(Z);
XF=round(M);
FILTRE=zeros(size(TFI));
FILTRE(XF(2):XF(4),XF(1):XF(3))=1;
FILTRE=fftshift(FILTRE);
close(gf);
TFF=TFI.*FILTRE;
%SE HACE LA TRANSFORMADA INVERSA A LA IMAGEN FILTRADA
ITF=ifft2(TFF);
%SE CALCULA LA FASE
M=abs(ITF);
Mask=M/max(M(:));
FASED=atan2(imag(ITF),real(ITF));
FASED=(FASED+abs(min(FASED(:))));
figure;imagesc(FASED); colormap gray;title(num2str(i));
%imcrop(FASED);
%pause
% figure;imagesc(Mask); colormap gray;title(num2str(i));
%ap=0;
%MM=double(Mask>=0.3);
%[PhaseC,MaskF,tiempo]=unwrap2DClasico([200,200],FASED,MM);

%Correccion de fase
%[PhaseC,MaskF,tiempo]=unwrap2DClasico([200,200],FASED,ones(size(FASED)));
PI=round(ginput(1));
[ret,MaskF,PhaseC]=UnWrap2DLigneColonne(FASED,ones(size(FASED)),PI);
figure;imagesc(PhaseC);colormap gray;
figure, mesh(PhaseC);
 %%
% %%%%%%%%%%%%%%%%%%%%
% %Eliminar Portadora
% %%%%%%%%%%%%%%%%%%%%
% 
% 
 TT=Polyfit2D_1(PhaseC,ones(size(PhaseC)),1:size(PhaseC,2),1:size(PhaseC,1),2);
matA=PolyVal2D_1(TT,1:size(PhaseC,2),1:size(PhaseC,1),2);
 PhaseCT=PhaseC-matA;
 AA=PhaseCT(20:size(PhaseCT,1)-20,20:size(PhaseCT,2)-20);
 figure;imagesc(AA);colormap gray;
 n=4;
 figure;mesh(1:n:size(AA,2),1:n:size(AA,1),AA(1:n:size(AA,1),1:n:size(AA,2)));
 
 reconst= PhaseCT;
 end
