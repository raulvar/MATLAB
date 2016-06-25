clear all
close all
clc

% Funciones para leer el archivo nd2

reader = bfGetReader('esferabloque.nd2');
omeMeta = reader.getMetadataStore(); % Meta data del archivo
Nimage=reader.getImageCount(); % Numero de imagenes
stackSizeX = omeMeta.getPixelsSizeX(0).getValue(); % Tamano X
stackSizeY = omeMeta.getPixelsSizeY(0).getValue(); % Tamano Y
voxelSizeX = omeMeta.getPixelsPhysicalSizeX(0).getValue(); % in um
voxelSizeY = omeMeta.getPixelsPhysicalSizeY(0).getValue(); % in um
voxelSizeZ = omeMeta.getPixelsPhysicalSizeZ(0).getValue(); % in um
Mmax=0*ones(stackSizeY,stackSizeX);
M=ones(stackSizeY,stackSizeX);
Zmax=ones(stackSizeY,stackSizeX);
p=1;
pos=p*ones(stackSizeY,stackSizeX);

%% Leer imagenes

% La manera de leer la k-esima imagen es la siguiente:
% I = double(bfGetPlane(reader,k));
% Note que se convierte a doble precision double(.) para posterior manipulacion.

% Utilizando el algoritmo de 4 imagenes recupere la fase de los objetos
% capturados en la sesion experimental.


