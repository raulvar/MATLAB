I1 = imread('ResultadosObjeto2_1.tif');
I2 = imread('ResultadosObjeto2_2.tif');
I3 = imread('ResultadosObjeto2_3.tif');
I4 = imread('ResultadosObjeto2_4.tif');
I5 = I1+I2+I3+I4;
I6 = I5<105;
f_plano= imread('Resultadosplano_1.tif');
Obj = I3;
%%
m1=Mascara(I1,210,9);
m2=Mascara(I2,210,9);
m3=Mascara(I3,210,9);
m4=Mascara(I4,210,9);
m5=m1.*m2.*m3.*m4; close all
%% Reconstruccion normal
reconsn = R3D_TF_pr(f_plano,I3);
%%
recons =reconsn;
recons = recons;
recons = recons.*(recons>0);
recons = recons.*m5;
recons = recons.*~I6;
figure,mesh(1:4:size(recons,2),1:4:size(recons,1),recons(1:4:size(recons,1),1:4:size(recons,2)));
%% Reconstruccion con hilbert
Obj2 = hilbert2(Obj);
recons_HT = R3D_TF_pr(f_plano,Obj2);
%%
recons_HT =rr;
recons_HT = -(recons_HT-mean(recons_HT(:))).*m5;
recons_HT = recons_HT.*(recons_HT>0).*~I6;
n=4;
figure, mesh(1:n:size(recons_HT,2),1:n:size(recons_HT,1),recons_HT(1:n:size(recons_HT,1),1:n:size(recons_HT,2)));

