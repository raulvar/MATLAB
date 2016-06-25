% I=imread('Franjas_Dec_Obj_0.jpg');
% I=double(I);
% I1=hilbert(I);
% I11=-imag(I1); % h-transform
% I2=hilbert(I11);
% I22= -imag(I2); % twice transform h
% I3= I-I22;% superposed I and I22
% I4= I11+I22; % superposicion de I11 e I22
% imagesc(I3),colormap gray
% %%
% figure(1), plot(1:size(I,2),I(130,:)./max(I(:))), title('perfil original')
% figure(2), plot(1:size(I11,2),I11(130,:)./max(I11(:))), title('perfil 1-htra')
% figure(3), plot(1:size(I22,2),I22(130,:)./max(I22(:))), title('perfil 2da-htra')
% figure(4), plot(1:size(I3,2),I3(130,:)./max(I3(:))), title('perfil superpos')
% figure(5), plot(1:size(I4,2),I4(130,:)./max(I4(:))), title('perfil superpos 2')

%% Simulacion peaks
fo=1/24;%frecuencia portadora
x=1:264;
shape=0.95*peaks(264);
y=0.5+0.5*cos(2*pi*fo*x);
f_plano=repmat(y,264,1); %Franjas del plano
z=peaks(264);
f_obj=-0.4*(z/max(z(:)))+0.3+0.5*cos(2*pi*fo*repmat(x,264,1)+shape); %Franjas del objeto
%% Mascara
% clear
% I1 = imread('ResultadosObjeto2_1.tif');
% I2 = imread('ResultadosObjeto2_2.tif');
% I3 = imread('ResultadosObjeto2_3.tif');
% I4 = imread('ResultadosObjeto2_4.tif');
% I5 = I1+I2+I3+I4;
% I6 = I5<105;
% f_plano= imread('Resultadosplano_3.tif');
% f_obj = I3;
% imshow(255*uint8(I6))
%%
fho = hilbert2(f_obj); %Transformada hilbert doble
fho2 = hilbert2rj(f_obj); 
figure, imshow(f_obj) 
figure, imshow(fho)
figure, plot(1:size(f_obj,2),f_obj(130,:)), title('Perfil fila 130 - patron deformado')
figure, plot(1:size(f_obj,2),fho(130,:)), title('Perfil fila 130- twice hilbert transform')
figure, plot(1:size(f_obj,2),fho2(130,:)), title('Perfil fila 130- twice hilbert transform')
%% Guardar las imagenes para el guide
imwrite(f_plano,'SP.png','png')
imwrite(f_obj,'ob.png','png')
%% Reconstruccion 
recon= R3D_TF_pr(f_plano,fho);
%%
n=4;
f=1:n:size(recon,1); c=1:n:size(recon,2);
mesh(c,f,flipud(recon(f,c)));

%%
fi =f_obj(130,:); 
plot(1:size(fi,2),fi)
[loc,mag] = peakfinder(fi);
hold on
plot(loc,mag,'*')
[locm,magm] = peakfinder(-fi);
plot(locm,-magm,'*')
