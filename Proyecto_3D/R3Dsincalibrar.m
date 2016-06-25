clear all
close all

Camino=('/Users/Lenny/Dropbox/US/TesisRamonRomero/experimento1');
%%
load('f90pr.mat')
load('f90objlay.mat')

%%
for k=1:size(f120pr,4)
figure(100),imshow(f120pr(:,:,:,k));
pause (0.5)
end
%%
for kk=1:size(f120objlay,4)
figure(100),imshow(f120objlay(:,:,:,kk));
pause(.5)
end