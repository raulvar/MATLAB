clear all;
close all;
clc;
%%

% Nom='../IMAGENES/Objeto12.BMP';
% Nom='tubo-1.tiff';
% Nom = 'Image__2016-05-12__15-15-16.tiff';
Nom = 'Image__2016-05-13__16-01-32.tiff';
% Nom = 'Image__2016-05-13__15-58-22.tiff';
% Nom = double(rgb2gray(imread('Image__2016-05-12__15-15-16.tiff')));

%% Recortar la imagen
ii=imread(Nom);
im=ii;
%im = ii(:,:,2);
[t,rec] = imcrop(im);

if rec(3)<rec(4)
    rec2=[rec(1) rec(2) rec(3) rec(3)];
else 
    rec2=[rec(1) rec(2) rec(4) rec(4)];
end
I_s = imcrop(im,rec2);
%% Area de interes
[t,rec3] = imcrop(I_s);

%%
% En la seleccion del filtro deben hacer click en el centro y luego
% arrastrar la ventana.

imh=hilbert2(double(I_s),'x4');
imom=MOBEMD(double(I_s),'DWT');
hom=hilbert2(imom(:,:,1),'x1');
%%
choice = questdlg('usar la misma ventana de filtrado?', ...
	'Dessert Menu', ...
	'Yes','No','No');
if strcmp(choice,'Yes')
[phased,FILTRE,M0,XF2,CE2]=analisis_TF(imom(:,:,1),XF2,CE2);
else
[phased,FILTRE,M0,XF2,CE2]=analisis_TF(hom);    
end

% Aunque se extrae toda la fase de la imagen, para el unwrap es mejor
% quedarse con la parte donde esta la abolladura. Para eso se recorta.
%phased = imcrop(phased,rec3);
%phased=phased(20:end-20,20:end-20);
figure(101),imagesc(phased)
if ~exist('P1','var')
P1=round(ginput(1));
end
close(101)

%% Phase unwrap

choice = questdlg('Phase unwrap with mask?', ...
	'Dessert Menu', ...
	'Yes','No','No');

switch choice
    case 'No'
        phasec=unwrap2DClasico_Sin_Masc(P1(1),P1(2),phased);
        figure(301);imagesc(phasec);colormap(gray(256)); axis image
    case 'Yes'
        
        choice2 = questdlg('Usar la misma mascara?', ...
	'Dessert Menu', ...
	'Yes','No','No');

   if (strcmp(choice2,'Yes'))
        %t = imcrop(I,rec3);
        figure(202),imshow(t)
        %Mask = roipoly;
        figure(203), imshow(Mask)
        phasec=unwrap2DClasico([P1(1) P1(2)],phased,~Mask);
   else
        %t = imcrop(imread(Nom),rec);
        t = I_s;
        figure(202),imshow(t)
        Mask = roipoly;
        figure(203), imshow(Mask)
        phasec=unwrap2DClasico([P1(1) P1(2)],phased,~Mask);
   end
end
        
%% Interpolar puntos faltantes
if strcmp(choice,'Yes')
    
    [Y,X] = meshgrid(1:size(phasec,2),1:size(phasec,1));
    phasec_fix = griddata(X(~Mask),Y(~Mask),phasec(~Mask),X,Y);

    % [t,rec] = imcrop(imread(Nom));
    % phasec = imcrop(phasec,rec);
    % figure,imagesc(phased);

    figure(301);imagesc(phasec);colormap(gray(256)); axis image
    title('With problem')

    phasec = phasec_fix;
    figure(302);imagesc(phasec);colormap(gray(256)); axis image
    title('Fixed')
end
%% Estimar fase teorica y restar de fase continua
TT=Polyfit2D_1(phasec,ones(size(phasec)),1:size(phasec,2),1:size(phasec,1),3);
phasecT=PolyVal2D_1(TT,1:size(phasec,2),1:size(phasec,1),3);

% If one selects the right or left spectra
if CE2(1)>size(phased,2)/2
    phaseMap = -1*(phasec-phasecT);
else
    phaseMap = 1*(phasec-phasecT);
end
phaseMap = phaseMap-min(phaseMap(:));
% phaseMap = imcrop(phaseMap,rec3);
% figure;imagesc(phasec-phasecT);colormap(gray(256));axis image
figure(303);imagesc(phaseMap);colormap(gray(256));axis image
colorbar

%% 
figure(307);mesh(flipud(phaseMap));colormap(gray(256));
% figure;contour3(-1*flipud(phasec-phasecT));colormap(gray(256));
% figure;mesh(flipud(phasecT));colormap(gray(256));
set(gca,'PlotBoxAspectRatio',[1 size(phaseMap,1)/size(phaseMap,2) 0.1])

%%
% [X,Y] = meshgrid(1:size(A,2),1:size(A,1));
% figure,mesh(X,Y,A), colormap gray
% figure;mesh(flipud(phasec));colormap(gray(256));