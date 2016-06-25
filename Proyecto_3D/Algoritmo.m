%%
N = 4;
for k=1:N,
    
   I(:,:,k) = double(imread(strcat('ip',num2str(k),'.jpg')));
   figure(1) 
   imagesc(I(:,:,k)); colormap gray, axis image 
   pause(0.5)
end

%%
N = 4;
for k=1:N,
    
   Id(:,:,k) = double(imread(strcat('idp',num2str(k),'.jpg')));
   figure(2) 
   imagesc(Id(:,:,k)); colormap gray, axis image 
   pause(0.5)
end

fase_ref=atan((I(:,:,4)-I(:,:,2))./(I(:,:,3)-I(:,:,1)));
fase_obj=atan((Id(:,:,4)-Id(:,:,2))./(Id(:,:,3)-Id(:,:,1)));
figure
imagesc(fase_ref); colormap gray
figure
imagesc(fase_obj); colormap gray
%obj=fase_obj-fase_ref;
%figure
%imagesc(obj); colormap gray

%%

faseconref=unwrap(fase_ref*2,[],2)/2;
figure
imagesc(faseconref); colormap gray;
faseconobj=unwrap(fase_obj*2,[],2)/2;
figure
imagesc(faseconobj); colormap gray;
%%
obj=faseconobj-faseconref;
figure
imagesc(obj); colormap gray
figure
mesh(obj);