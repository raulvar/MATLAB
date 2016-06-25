hom2= 4*(imnormalize(medfilt2(hom,[8,2]))-0.5);
hom2=imnormalize(hom2);
figure,imshow(uint8(255*hom2))
%%
hom3=MOBEMD(hom2,'DWT');
%%
hom4=imnormalize(hom3(:,:,1));
figure,imshow(uint8(255*hom4))