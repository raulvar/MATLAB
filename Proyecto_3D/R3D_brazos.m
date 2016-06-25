I1=double(imread('imagenesb21.png'));
I2=double(imread('imagenesb22.png'));
I3=double(imread('imagenesb23.png'));
I4=double(imread('imagenesb24.png'));

fased_ref = atan2(I4-I2,I3-I1);
figure(1),imagesc(fased_ref); colormap gray;title('Fase Discontinua Plano de Referencia');