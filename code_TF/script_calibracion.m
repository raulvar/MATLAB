% Script de calibracion

addpath ../

% Cargar imagenes 

FileNames = dir('*.tiff');

% Select ROI
I = imread(FileNames(1).name);
[~,rect] = imcrop(I);
rect = round(rect);

clear I
close all

%% Read all images with ROI
t = 1;
N = 53; % Number of images used for calibration
M = zeros([rect(4)+1 rect(3)+1 N]);
for k = 1 : numel(FileNames)
    if k <= N
        temp = imread(FileNames(k).name, ...
        'PixelRegion', ...
        {[rect(2) rect(2)+rect(4)], [rect(1) rect(1)+rect(3)]});
        if size(temp,3)>1
            M(:,:,k) = double(rgb2gray(temp));
        else
            M(:,:,k) = double(temp);
        end
%         figure(101);imagesc(M(:,:,k));colormap(gray(256)); axis image
%         pause(0.5)
    else
        temp = imread(FileNames(k).name);
        if size(temp,3)>1
            I(:,:,t) = double(rgb2gray(temp));
            t = t+1;
        else
            I(:,:,t) = double(temp);
            t = t+1;
        end
    end
end
clear t temp
%% Phase by Fourier Transform

[phased,~,~,XF,CE]=analisis_TF(M(:,:,1));
% [phased,~,~,XF,CE]=analisis_TF(M(:,:,1));

%% Unwrap phase
P1 = round(size(M(:,:,1))/2);
phaseM = zeros(size(M));

for k = 1:size(M,3)
    phased=analisis_TF2(M(:,:,k),XF,CE);
    phasec=unwrap2DClasico_Sin_Masc(P1(2),P1(1),phased);
%     TT=Polyfit2D_1(phasec,ones(size(phasec)),1:size(phasec,2),1:size(phasec,1),3);
%     phasecT=PolyVal2D_1(TT,1:size(phasec,2),1:size(phasec,1),3);
    phaseM(:,:,k) = phasec;
%     PhaseM(:,:,k) = phasecT-min(phasecT(:));
%     PhaseM(:,:,k) = phasec-min(phasec(:));
    figure(101);mesh(phaseM(:,:,k));colormap(gray(256)); axis image
%     colorbar
    title(num2str(k))
    pause(0.5)
end

%% Get absolute phase wrt to reference plane
phaseMabs = zeros(size(phaseM));
MidY = round(size(M,1)/2);
MidX = round(size(M,2)/2);
for k = 1:size(phaseM,3)
    phaseMabs(:,:,k) = phaseM(:,:,k)-phaseM(:,:,1);
    phaseMabsP(k) = abs(phaseM(MidY,MidX,k)-phaseM(MidY,MidX,1));
%     figure(101);mesh(PhaseMabs(:,:,k));colormap(gray(256)); axis image
    figure(101); plot(phaseMabs(MidY,:,k))
    ylim([-8 8])
%     zlim([-8 8])
    title(num2str(k))
    pause(0.5)
    fprintf('Central phase value is %2.2f \n',mean2(phaseMabsP(k)))
    
end
%% Plot absolute phase vs z
phaseAbsP = zeros(size(phaseMabsP));
for k=1:numel(phaseMabsP)-1
    phaseAbsP(k+1) = phaseAbsP(k) + phaseMabsP(k+1);
end
z = 0:0.5:(numel(phaseAbsP)-1)*0.5;
figure(401),plot(z,phaseAbsP,'*')
ylabel('Radians')
xlabel('[mm]')
hold on
P = polyfit(z,phaseAbsP,2);
phase = polyval(P,z);
plot(z,phase)
%% Inverse relation
P2 = polyfit(phaseAbsP,z,2);
zz = polyval(P2,phaseAbsP);
figure(402),plot(phaseAbsP,zz)
xlabel('Radians')
ylabel('[mm]')

%% Getting x and y scale factor

figure(701)
I=imread('Image__2016-05-13__17-43-35.tiff','tiff');
%I=imread('Image__2016-05-13__16-21-11.tiff','tiff');
m = ceil(sqrt(size(I,3)));
n = ceil(size(I,3)/4);
for k = 1:size(I,3)
    subplot(m,n,k)
    imagesc(I(:,:,k))
    title(num2str(k))
    list{k} = num2str(k);
end
%  d = dir;
% str = {d.name}; 
[s,v] = listdlg('PromptString','Select a file:',...
                'SelectionMode','single',...
                'ListString',list);

close(701)

%
figure,imagesc(I(:,:,s))

% X scale factor
title('X')
PointsX = ginput(2);
FSX = 44.8/abs(PointsX(1,1) - PointsX(1,2));
% FSX = 0.0903; calibracion 1
%FSX = 12.6/abs(PointsX(1,1) - PointsX(1,2))

% Y scale factor
title('Y')
PointsY = ginput(2);
FSY = 13.7/abs(PointsY(2,1) - PointsY(2,2));
% FSX = 0.0610; calibracion 1
%FSY = 5.3/abs(PointsY(2,1) - PointsY(2,2))

%% Mapping radians to mm
phaseMap=imcrop(phaseMap,rec3);
[Y,X] = meshgrid(1:size(phaseMap,2),1:size(phaseMap,1));
xx = X*FSX;
yy = Y*FSY;
zz = polyval(P2,phaseMap);
figure(801),mesh(xx,yy,zz);
colormap gray
ylabel('[mm]')
zlabel('[mm]')
xlabel('[mm]')
% aspect ratio
asp_ratio = [max(xx(:)) max(yy(:)) max(zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)

%% Imagesc
figure(801),imagesc((1:(size(xx,2)))*FSX,(1:(size(yy,1)))*FSY,zz);
% colormap gray
cb = colorbar;
ylabel(cb,'[mm]')
ylabel('[mm]')
zlabel('[mm]')
xlabel('[mm]')
% aspect ratio
% asp_ratio = [max(xx(:)) max(yy(:)) max(zz(:))];
% asp_ratio = asp_ratio./max(asp_ratio);
% asp_ratio(3) = 0.1;
% set(gca,'PlotBoxAspectRatio',asp_ratio)


%% Plot a profile across the hole

figure(1002),imagesc(zz)
if ~exist('HoleCenter','var')
HoleCenter = round(ginput(1));
end
profile_L=[(1:(size(xx,2)))*FSX;zz(HoleCenter(2),:)];
profile_T=[(1:(size(yy,1)))*FSY;zz(:,HoleCenter(1))'];
figure,plot((1:(size(xx,2)))*FSX,zz(HoleCenter(2),:))
title('Perfil longitudinal')
ylabel('mm')
xlabel('mm')
set(gca,'PlotBoxAspectRatio',[1 0.3 1])

figure,plot((1:(size(yy,1)))*FSY,zz(:,HoleCenter(1)))
title('Perfil transversal')
ylabel('mm')
xlabel('mm')
set(gca,'PlotBoxAspectRatio',[1 0.2 1])

%%
figure(1001)
surface(xx,yy,zz, 'FaceColor','texturemap',...
'EdgeColor','none','Cdata',t)
colormap gray
ylabel('[mm]')
zlabel('[mm]')
xlabel('[mm]')
% aspect ratio
asp_ratio = [max(xx(:)) max(yy(:)) max(zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)