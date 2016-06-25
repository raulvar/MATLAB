% %% Entendiendo peakfinder
% clear
% imagen = imread('_1_Otarro.tif');
% plano =  imread('_5_Pvaso.tif');
% % imagen = double(imread('SObjeto.png'));
% % plano  = double(imread('SPlano.png'));
% %%
% figure, imagesc(imagen),colormap gray
% hold on
% for i = 1:size(imagen,1)
% xma{i} = peakfinder (medfilt1( double(imagen(i,:))));
% xmi{i} = peakfinder (medfilt1( -double(imagen(i,:))));
% plot(xma{i},i,'.b')
% plot(xmi{i},i,'.r')
% end
%% Iluminacion Peaks+ruido
rng(11),noi=0.01*randn(264); %Ruido obj
rng(10),noi2=0.01*randn(264); %Ruido plano
x=[1  264 1 264];
y=[1  1 264 264];
z=[0 -0.5 0.5 0];
[X,Y]=meshgrid(1:264);
Z= griddata(x,y,z,X,Y);
mesh(X,Y,Z)
%% Iluminacion gausiana + ruido
rng(11),noi=0.01*randn(264); %Ruido obj
rng(10),noi2=0.01*randn(264); %Ruido plano
x=linspace(-0.1,0.1,264);
y=x';               
[X,Y]=meshgrid(x,y);
Z=exp(-(X.^2+Y.^2)/0.005);
figure(2)
mesh(X,Y,Z)
%% Iluminacion por peaks
z=peaks(264);
[X,Y]=meshgrid(1:264);
Z= -0.4*(z/max(z(:)));
mesh(X,Y,Z)
%% Objeto y plano simulado
fo=1/24;%frecuencia portadora
x=1:264;
z=peaks(264);
shape=0.95*z;
y=0.5+0.5*cos(2*pi*fo*x);
f_plano=Z+noi2+repmat(y,264,1); %Franjas del plano
%f_obj=-0.4*(z/max(z(:)))+0.3+Z+0.5*cos(2*pi*fo*repmat(x,264,1)+shape); %Franjas del objeto
f_obj= noi+0.3+Z+0.5*cos(2*pi*fo*repmat(x,264,1)+shape); %Franjas del objeto
f_obj=   imnormalize(f_obj); % normalizando
f_plano= imnormalize(f_plano);
imagen= uint8(255*f_obj);
plano=  uint8(255*f_plano);
figure(1)
imagesc(f_obj), colormap gray
figure(2)
imagesc(f_plano), colormap gray
%% Hilbert
fho = hilbert2(imagen);
%% MOBEMD
if size(imagen,1)< size(imagen,2)
    imagen2 = double(imcrop(imagen,[1 1 size(imagen,1)-1 size(imagen,1)-1]));
    plano2  = double(imcrop(plano,[1 1 size(plano,1)-1 size(plano,1)-1]));
elseif size(imagen,2)< size(imagen,1)
    imagen2 = double(imcrop(imagen,[1 1 size(imagen,2)-1 size(imagen,2)-1]));
    plano2  = double(imcrop(plano, [1 1 size(plano ,2)-1 size(plano ,2)-1]));
else
    imagen2=double(imagen);
    plano2 =double(plano);
end
Components=MOBEMD(imagen2,'lowpass',4);
fmb=squeeze(Components(:,:,1));
Components=MOBEMD(plano2,'lowpass',4);
pmb=squeeze(Components(:,:,1));
%% BEMD
if size(imagen,1)>512 || size(imagen,2)>512
imagen3 = double(imresize(imagen,[512 512]));
plano3 = double(imresize(plano,[512 512]));
else
    imagen3=double(imagen);
    plano3= double(plano);
end
modos = bemd(imagen3,3);
fbb = double(imagen)-imresize(modos(:,:,end),size(imagen));

modos = bemd(plano3,3);
pbb = double(plano)-imresize(modos(:,:,end),size(plano));
%% Visualizacion de las imagenes compensadas
%figure(99)

figure(221), imagesc(imagen),colormap gray,xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel') % imagen original
figure(222), imagesc(fho)   ,colormap gray,xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel') % Hilbert
figure(223), imagesc(fmb)   ,colormap gray,xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel') % MOBEMD
figure(224), imagesc(fbb)   ,colormap gray,xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel')  % BEMD
saveas(figure(221),'Comparaciones\Peaks\Pat_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\Pat_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\Pat_mobemd.eps','eps')
% h= title('Espectro de las imagenes','FontSize',12);
% set(gca,'Visible','off');
% set(h,'Visible','on');
%% espectros 
fft_imagen  = abs(fft2(imagen));
fft_hilbert = abs(fft2(  fho ));
fft_MOBEMD  = abs(fft2(  fmb ));
fft_BEMD    = abs(fft2(  fbb ));

%% imagen de espectros 

figure(221), imagesc(fftshift(fft_imagen )),colormap gray%, title('(a) imagen original' )
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
figure(222), imagesc(fftshift(fft_hilbert)),colormap gray%, title('(b) hilbert')
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
figure(223), imagesc(fftshift(fft_MOBEMD )),colormap gray%, title('(c) MOBEMD' )
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
figure(224), imagesc(fftshift(fft_BEMD   )),colormap gray%, title('(d) BEMD'   )
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
saveas(figure(221),'Comparaciones\Peaks\zpa_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\zpa_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\zpa_mobemd.eps','eps')

%% Espectros recortados
figure(221), imagesc(imcrop(fftshift(fft_imagen ),rec)), axis off, colormap gray%, title('(a) imagen original' )
%rectangle('position',[1 1 rec(3) rec(4)],'EdgeColor','r','linewidth',5)
figure(222), imagesc(imcrop(fftshift(fft_hilbert),rec)), axis off, colormap gray%, title('(b) hilbert')
%rectangle('position',[1 1 rec(3) rec(4)],'EdgeColor','r','linewidth',5)
figure(223), imagesc(imcrop(fftshift(fft_MOBEMD ),rec)), axis off, colormap gray%, title('(c) MOBEMD' )
%rectangle('position',[1 1 rec(3) rec(4)],'EdgeColor','r','linewidth',5)
%figure(224), imagesc(imcrop(fftshift(fft_BEMD   ),rec)), axis off, colormap gray%, title('(d) BEMD'  )
%rectangle('position',[1 1 rec(3) rec(4)],'EdgeColor','r','linewidth',5)
% axes;
% h= title('Espectro de las imagenes','FontSize',12);
% set(gca,'Visible','off');
% set(h,'Visible','on');
saveas(figure(221),'Comparaciones\Peaks\zpl_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\zpl_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\zpl_mobemd.eps','eps')
%%
% figure(101)
figure(221), imagesc(fftshift(log(1+fft_imagen ))),axis off,colormap gray%, title('(a) imagen original')
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
figure(222), imagesc(fftshift(log(1+fft_hilbert))),axis off,colormap gray%, title('(b) hilbert'        )
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
figure(223), imagesc(fftshift(log(1+fft_MOBEMD ))),axis off,colormap gray%, title('(c) MOBEMD'         )
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
figure(224), imagesc(fftshift(log(1+fft_BEMD   ))),axis off,colormap gray%, title('(d) BEMD'           )
%rectangle('position',rec,'EdgeColor','r','linewidth',2)
% axes;
% h= title('Espectro de las imagenes- Escala logaritmica','FontSize',12);
% set(gca,'Visible','off');
% set(h,'Visible','on');
saveas(figure(221),'Comparaciones\Peaks\zpl_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\zpl_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\zpl_mobemd.eps','eps')
%% Comparacion linea 130th
fii = imnormalize(fftshift(abs(fft(imagen(130,:))))); 
foo = imnormalize(fftshift(abs(fft(   fho(130,:))))); 
fmm = imnormalize(fftshift(abs(fft(   fmb(130,:))))); 
fee = imnormalize(fftshift(abs(fft(   fbb(130,:))))); 
figure(221), plot(fii), axis([1 264 0 1.2 ])%, xlabel('(a)imagen original')
figure(222), plot(foo), axis([1 264 0 1.2])%, xlabel('(b)hilbert')
figure(223), plot(fmm), axis([1 264 0 1.2])%, xlabel('(c)MOBEMD')
figure(224), plot(fee), axis([1 264 0 1.2])%, xlabel('(c)MOBEMD')
%Guardar las imagenes
saveas(figure(221),'Comparaciones\Peaks\lin_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\lin_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\lin_mobemd.eps','eps')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  RECONSTRUCCION %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
%%%%%%%%%%%%%%%%%%  Ventanas de filtrado %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ventana 1 - seleccionada en base a TF
XF= [137 1 153 148];
%% Ventana 2- Seleccionada en base a hilbert2
XF =[136 120 153 148];
%% Ventana 3- Seleccionada en base a MOBEMD
%XF= [136 1 264 264];
XF= [136 1 159 151];
%% Ventana 4- Seleccionada en base a BEMD
XF= [136 1 152 149];
%% Reconstruccion normal 
r_normal = R3D_TF_pr(plano,imagen,XF);
%r_normal = r_normal-mean(r_normal(:));
figure(200),mesh(1:264,1:264,r_normal)

%% Reconstruccion hilbert
plano2=hilbert2(plano);
r_hilb = R3D_TF_pr(plano2,fho,XF);
%r_hilb = r_hilb-mean(r_hilb(:));
figure(201),mesh(1:264,1:264,r_hilb)
%% Reconstruccion MOBEMD
r_mobemd = R3D_TF_pr(pmb,fmb,XF);
%r_mobemd = r_mobemd-mean(r_mobemd (:));
figure(202),mesh(1:264,1:264,r_mobemd)

%% Reconstruccion BEMD
r_bemd = R3D_TF_pr(pbb,fbb,XF);
r_bemd = r_bemd -mean(r_bemd (:));
figure(203),mesh(1:264,1:264,r_bemd)
% % Borrar despues
% e4 = sqrt ( sum((z(:)-r_bemd  (:)).^2)/(numel(z)));
% fprintf('\n dif = %2.22f \n',e4)
% %Borrar
%% Visualizacion de reconstrucciones
%figure(103)
figure(221), mesh(1:264,1:264,r_normal),xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
figure(222), mesh(1:264,1:264,r_hilb),xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
figure(223), mesh(1:264,1:264,r_mobemd),xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
figure(224), mesh(1:264,1:264,r_bemd),xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
saveas(figure(221),'Comparaciones\Peaks\rec_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\rec_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\rec_mobemd.eps','eps')
%saveas(figure(224),'figuras\bemd.png','png')
%% Calculo de errores rms
z = 0.95*peaks(264);
%z = z-mean(z(:));
e1 = sqrt ( sum((z(:)-r_normal(:)).^2)/(numel(z)));
e2 = sqrt ( sum((z(:)-r_hilb  (:)).^2)/(numel(z)));
e3 = sqrt ( sum((z(:)-r_mobemd(:)).^2)/(numel(z)));
e4 = sqrt ( sum((z(:)-r_bemd  (:)).^2)/(numel(z)));
fprintf('\n Errores RMS: \n e1=%1.10f \n e2=%1.10f \n e3=%1.10f \n e4=%1.10f  \n',e1,e2,e3,e4)

em1 = max(abs(z(:)-r_normal(:)));
em2 = max(abs(z(:)-r_hilb  (:)));
em3 = max(abs(z(:)-r_mobemd(:)));
em4 = max(abs(z(:)-r_bemd (:)));
fprintf('\n Errores max: \n e1=%1.10f \n e2=%1.10f \n e3=%1.10f \n e4=%1.10f   \n',em1,em2,em3,e4)


%% Errores variando altura
% n = -1:0.005:1; 
% e1=zeros(size(n));
% e2=e1;e3=e1;e4=e1;
% for i = 1:numel(n)
% e1(i) = sqrt ( sum((z(:)+n(i)-r_normal(:)).^2)/(numel(z)));
% e2(i) = sqrt ( sum((z(:)+n(i)-r_hilb  (:)).^2)/(numel(z)));
% e3(i) = sqrt ( sum((z(:)+n(i)-r_mobemd(:)).^2)/(numel(z)));
% e4(i) = sqrt ( sum((z(:)+n(i)-r_bemd  (:)).^2)/(numel(z)));
% end
%% Mapa de errores relativos
%figure(104)
figure(221), mesh(1:264,1:264,-(z-r_normal)), axis([1 264 1 264 -2 2])
xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
%set(gca,'Xtick',[]); set(gca,'Ytick',[]); title('(a)')
figure(222), mesh(1:264,1:264,-(r_hilb  -z)), axis([1 264 1 264 -2 2])
xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
%set(gca,'Xtick',[]); set(gca,'Ytick',[]);title('(b)')
figure(223), mesh(1:264,1:264,-(r_mobemd-z)), axis([1 264 1 264 -2 2])
xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
%set(gca,'Xtick',[]); set(gca,'Ytick',[]);title('(c)')
figure(224), mesh(1:264,1:264,-(r_bemd  -z)), axis([1 264 1 264 -2 2])
xlabel('position X/ Pixel'),ylabel('Position Y/ Pixel'),zlabel('Height/mm'),colormap gray
%set(gca,'Xtick',[]); set(gca,'Ytick',[]);title('(d)')
saveas(figure(221),'Comparaciones\Peaks\map_original.eps','eps')
saveas(figure(222),'Comparaciones\Peaks\map_hilbert.eps','eps')
saveas(figure(223),'Comparaciones\Peaks\map_mobemd.eps','eps')
saveas(figure(224),'errores\bemd.png','png')

