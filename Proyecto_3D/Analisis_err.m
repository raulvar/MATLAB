%% Reconstrucciones
tf1 = load('R_TF.mat','recons'); 
tf2 = load('R_TF2.mat','recons'); 
tf3 = load('R_TF3.mat','recons'); 
tf4 = load('R_TF4.mat','recons'); 

th1 = load('R_TH.mat','recons'); 
th2 = load('R_TH2.mat','recons');
th3 = load('R_TH3.mat','recons'); 
th4 = load('R_TH4.mat','recons'); 

%% errores
ef1 = abs(z-tf1.recons);
ef2 = abs(z-tf2.recons);
ef3 = abs(z-tf3.recons);
ef4 = abs(z-tf4.recons);

eh1 = abs(z-th1.recons);
eh2 = abs(z-th2.recons);
eh3 = abs(z-th3.recons);
eh4 = abs(z-th4.recons);
%% Errores con transformada de fourier
figure
h = gca;
tif1=['mean=',num2str(mean(ef1(:)),3),' min=',num2str(min(ef1(:)),3),' max=',num2str(max(ef1(:)),3)]; 
tif2=['mean=',num2str(mean(ef2(:)),3),' min=',num2str(min(ef2(:)),3),' max=',num2str(max(ef2(:)),3)];
tif3=['mean=',num2str(mean(ef3(:)),3),' min=',num2str(min(ef3(:)),3),' max=',num2str(max(ef3(:)),3)];
tif4=['mean=',num2str(mean(ef4(:)),3),' min=',num2str(min(ef4(:)),3),' max=',num2str(max(ef4(:)),3)];
subplot(221),mesh(1:264,1:264,ef1),title(tif1)
subplot(222),mesh(1:264,1:264,ef2),title(tif2)
subplot(223),mesh(1:264,1:264,ef3),title(tif3)
subplot(224),mesh(1:264,1:264,ef4),title(tif4)
%% Errores con transformada hilbert
figure
title('Errores- transformada hilbert')
tih1=['mean= ',num2str(mean(eh1(:)),3),'min = ',num2str(min(eh1(:)),3),'max=',num2str(max(eh1(:)),3)]; 
tih2=['mean= ',num2str(mean(eh2(:)),3),'min = ',num2str(min(eh2(:)),3),'max=',num2str(max(eh2(:)),3)];
tih3=['mean= ',num2str(mean(eh3(:)),3),'min = ',num2str(min(eh3(:)),3),'max=',num2str(max(eh3(:)),3)];
tih4=['mean= ',num2str(mean(eh4(:)),3),'min = ',num2str(min(eh4(:)),3),'max=',num2str(max(eh4(:)),3)];
subplot(221),mesh(1:264,1:264,eh1),title(tih1)
subplot(222),mesh(1:264,1:264,eh2),title(tih2)
subplot(223),mesh(1:264,1:264,eh3),title(tih3)
subplot(224),mesh(1:264,1:264,eh4),title(tih4)