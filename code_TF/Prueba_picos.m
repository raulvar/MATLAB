im = imread(Nom,'tiff');
%%
im=t;
im2= imfilter(double(im),fspecial('average',[3,3]));
%%
im2=imom(:,:,1);
figure, imagesc(im2),colormap gray
hold on
imagen=im2;
h=size(imagen,2);
%%
for i = 1:size(imagen,1)
p1 =       peakfinder( double(imagen(i,1:end/4)),[],[],[],0);
p2 =   h/4+peakfinder( double(imagen(i,end/4:end/2)),[],[],[],1);
p3 =   h/2+peakfinder( double(imagen(i,end/2:3*end/4)),[],[],[],0); 
p4 = 3*h/4+peakfinder( double(imagen(i,3*end/4:end)),[],[],[],1);   
xma{i} = [p1,p2,p3,p4];

v1 =       peakfinder(-double(imagen(i,1:end/4)),[],[],[],0);
v2 =   h/4+peakfinder(-double(imagen(i,end/4:end/2)),[],[],[],1);
v3 =   h/2+peakfinder(-double(imagen(i,end/2:3*end/4)),[],[],[],0); 
v4 = 3*h/4+peakfinder(-double(imagen(i,3*end/4:end)),[],[],[],1);  
xmi{i} = [v1,v2,v3,v4];
plot(xma{i},i,'.b')
plot(xmi{i},i,'.r')
end

%%
for i = 1:size(imagen,1)
xma{i} = peakfinder(double(imagen(i,:)));
xmi{i} = peakfinder(-double(imagen(i,:)));

plot(xma{i},i,'.b')
plot(xmi{i},i,'.r')
end

%%
tf = fftshift(abs(fft2(im)));
figure, imagesc(tf), colormap gray

%%
figure,plot(im(586,:))
hold on, plot(im2(586,:),'r')

%%

ma = peakfinder ( double(im(586,:)),[],200); 
mi = peakfinder (-double(im(586,:)),[],200);
