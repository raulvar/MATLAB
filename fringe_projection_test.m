%% Programa para generar franjas mediante Phase shifting
% Se generan las franjas y se utiliza la funcion fullscreen()
% para mandar a pantalla completa en el proyector.

% Anadir al path el DIPUM toolbox para usar la funcion de regiongrow
if isunix
    addpath fullscreen/
elseif ispc
    addpath fullscreen\
end

%% Generacion de franjas para recuperacion mediante Phase shifting

% Funcion para normalizar los valores de una matriz entre [0 1]
% normalize = @(x) (x+abs(min(x(:))))./max(max((x+abs(min(x(:))))));

Ncol = 1366;
Mrow = 768;

% A = normalize(membrane);
% L = membrane;

% L = imresize(L,[Ncol Ncol]);
% L = L+abs(min(L(:)));
% L = L./max(L(:));
% Lphi = L*2*pi;


% Contraste de las franjas
A = 255;
% Intensidad fondo continuo
% I_0 = 30/255*ones(Ncol);
% I_0 = 255*imnoise(I_0,'speckle');

% frecuencia espacial media de las franjas
f_0 = 50;
% fase inicial de las franjas
phi_0 = 0;

[X,Y] = meshgrid(linspace(0,1,Ncol),linspace(0,1,Mrow));

% Lazo for para generar las cuatro imagenes
phi_i = linspace(pi/2,2*pi,4);

Ipr = cell(1,4);

for k=1:4,
%     I_0 = 30/255*ones(Ncol);
%     I_0 = 255*imnoise(I_0,'speckle',0.01);
    Ipr{k} = uint8(A*cos(2*pi*f_0*X+phi_0+phi_i(k)));
%     Iobj{k} = I_0 + A*cos(2*pi*f_0*X+phi_0+phi_i(k)+Lphi);
%     figure(100),imagesc(Ipr{k});
%     figure(100),imagesc(Iobj{k});
%     colormap gray; axis image;
%     pause(0.5)
end

%%

% M = im2uint8(rand(600,800)); 
% M = repmat(M,[1 1 3]);
for k=1:numel(phi_i),
    M = repmat(Ipr{k},[1 1 3]);
    fullscreen(M,1);
    pause;
%     trigger(vid);
end
%%
closescreen;
