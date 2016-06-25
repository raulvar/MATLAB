%% Cargando variables

hilb=load('hilberto3.mat','xx','yy','zz','profile_L','profile_T','phasec');
bemd=load('ombemd3.mat','xx','yy','zz','profile_L','profile_T','I_s','phasec','imh','hom','imom','XF2','CE2');
norm=load('Normal3.mat','xx','yy','zz','profile_L','profile_T','phasec');
hbem=load('hilom3.mat','xx','yy','zz','profile_L','profile_T','phasec');
norm2=load('Normal4.mat','xx','yy','zz','profile_L','profile_T','phasec','Mask');

%% Mapas de fases 
figure(804),mesh(hilb.xx,hilb.yy,hilb.zz);
colormap gray
ylabel('Y [mm]','FontSize',16)
zlabel('Z [mm]','FontSize',16)
xlabel('X [mm]','FontSize',16)
axis([min(hilb.xx(:)) max(hilb.xx(:)) min(hilb.yy(:)) max(hilb.yy(:)) 0 5])
%title('hilbert')
asp_ratio = [max(hilb.xx(:)) max(hilb.yy(:)) max(hilb.zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)
%saveas(figure(801),'reconstrucciones\hilb.eps','eps')
printFig('reconstrucciones\hilb.eps');
figure(805),mesh(bemd.xx,bemd.yy,bemd.zz);
colormap gray
ylabel('Y [mm]','FontSize',16)
zlabel('Z [mm]','FontSize',16)
xlabel('X [mm]','FontSize',16)
%title('MOBEMD')

asp_ratio = [max(bemd.xx(:)) max(bemd.yy(:)) max(bemd.zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)
axis([min(hilb.xx(:)) max(hilb.xx(:)) min(hilb.yy(:)) max(hilb.yy(:)) 0 5])

%saveas(figure(802),'reconstrucciones\mobemd.eps','eps')
printFig('reconstrucciones\mobemd.eps');

figure(806),mesh(norm.xx,norm.yy,norm.zz);
%figure(803),imagesc(norm.zz);
colormap gray
ylabel('Y [mm]','FontSize',16)
zlabel('Z [mm]','FontSize',16)
xlabel('X [mm]','FontSize',16)
%title('tradicional')
asp_ratio = [max(norm.xx(:)) max(norm.yy(:)) max(norm.zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)
%saveas(figure(803),'reconstrucciones\trad.eps','eps')
axis([min(hilb.xx(:)) max(hilb.xx(:)) min(hilb.yy(:)) max(hilb.yy(:)) 0 5])

printFig('reconstrucciones\trad.eps');

figure(807),mesh(hbem.xx,hbem.yy,hbem.zz);
colormap gray
ylabel('Y [mm]','FontSize',16)
zlabel('Z [mm]','FontSize',16)
xlabel('X [mm]','FontSize',16)
%title('hilbert+MOBEMD')
asp_ratio = [max(hbem.xx(:)) max(hbem.yy(:)) max(hbem.zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)
%saveas(figure(804),'reconstrucciones\hilmo.eps','eps')
axis([min(hilb.xx(:)) max(hilb.xx(:)) min(hilb.yy(:)) max(hilb.yy(:)) 0 5])

printFig('reconstrucciones\hilmo.eps');

%%
figure(805),mesh(norm2.xx,norm2.yy,norm2.zz);
%figure(803),imagesc(norm.zz);
colormap gray
ylabel('Y [mm]','FontSize',16)
zlabel('Z [mm]','FontSize',16)
xlabel('X [mm]','FontSize',16)
%title('tradicional')
asp_ratio = [max(norm2.xx(:)) max(norm2.yy(:)) max(norm2.zz(:))];
asp_ratio = asp_ratio./max(asp_ratio);
asp_ratio(3) = 0.1;
set(gca,'PlotBoxAspectRatio',asp_ratio)
%saveas(figure(803),'reconstrucciones\trad.eps','eps')
axis([min(hilb.xx(:)) max(hilb.xx(:)) min(hilb.yy(:)) max(hilb.yy(:)) 0 5])

printFig('reconstrucciones\trad2.eps');




%% Perfiles
close (figure(900))
figure(900)
figure(311),plot(norm.profile_L(1,:),norm.profile_L(2,:))
hold on 
plot(bemd.profile_L(1,:),bemd.profile_L(2,:),'-r','LineWidth',2)
%plot(bemd.profile_L(1,1:8:end),bemd.profile_L(2,1:8:end),'.r','LineWidth',2)

plot(hilb.profile_L(1,:),hilb.profile_L(2,:),'-k','LineWidth',2)
%plot(hilb.profile_L(1,1:8:end),hilb.profile_L(2,1:8:end),'.k','LineWidth',2)

plot(hbem.profile_L(1,:),hbem.profile_L(2,:),'-g','LineWidth',2)
%plot(hbem.profile_L(1,1:8:end),hbem.profile_L(2,1:8:end),'.g','LineWidth',2)

set(gca,'FontSize',16)
ylabel('mm','FontSize',16)
xlabel('mm','FontSize',16)
axis([0 30 0 4])
legend('traditional','MOBEMD','Hilbert','Hilbert+MOBEMD','Location','SouthEastOutside')
%title('profile longitudinal')
set(gcf, 'color', 'white');
set(gca,'PlotBoxAspectRatio',[1 0.3 1])
%saveas(figure(900),'perfil_agujero\longitudinal.eps','eps')
%printFig('perfil_agujero\longitudinal.eps');
set(gcf,'PaperPositionMode','auto')
%pause()
print('perfil_agujero\longitudinal.eps','-depsc2','-r300')
hold off
%%
figure(301)
plot(norm.profile_L(1,:),norm.profile_L(2,:),'r','LineWidth',2)
hold on 
plot(norm2.profile_L(1,:),norm2.profile_L(2,:),'b','LineWidth',2)
plot(hbem.profile_L(1,:),hbem.profile_L(2,:),'.g','LineWidth',2)

set(gca,'FontSize',16)
ylabel('mm','FontSize',16)
xlabel('mm','FontSize',16)
axis([0 30 0 4])
legend('FTP','FTP','MOBEMD','Location','SouthEastOutside')
%title('profile longitudinal')
set(gcf, 'color', 'white');
set(gca,'PlotBoxAspectRatio',[1 0.3 1])
%saveas(figure(900),'perfil_agujero\longitudinal.eps','eps')
%printFig('perfil_agujero\longitudinal.eps');
set(gcf,'PaperPositionMode','auto')
%pause()
print('perfil_agujero\longitudinal2.eps','-depsc2','-r300')
hold off

%%
figure(312),plot(norm.profile_T(1,:),norm.profile_T(2,:),'b','LineWidth',2)
hold on 
plot(bemd.profile_T(1,:),bemd.profile_T(2,:),'.r','LineWidth',2)
plot(hilb.profile_T(1,:),hilb.profile_T(2,:),'.m','LineWidth',2)
plot(hbem.profile_T(1,:),hbem.profile_T(2,:),'.g','LineWidth',2)
%title('profile transversal')

set(gca,'PlotBoxAspectRatio',[1 0.3 1])
set(gca,'FontSize',16)
ylabel('mm','FontSize',16)
xlabel('mm','FontSize',16)
axis([0 32 0 4])
legend('traditional','MOBEMD','Hilbert','Hilbert+MOBEMD')%,'Location','SouthEastOutside')
set(gcf, 'color', 'white');
set(gcf,'PaperPositionMode','auto')
pause()
print('perfil_agujero\legend.eps','-depsc2','-r300')
hold off
%% espectros 

XF = [bemd.XF2(1),bemd.XF2(2),bemd.XF2(3)-bemd.XF2(1),bemd.XF2(4)-bemd.XF2(2)];
CE = bemd.CE2;
tf_n=fftshift(log(abs(fft2(bemd.I_s))));
tf_h=fftshift(log(abs(fft2(bemd.imh))));
tf_he=fftshift(log(abs(fft2(bemd.hom))));
tf_e=fftshift(log(abs(fft2(bemd.imom(:,:,1)))));

figure(900),imagesc(tf_n);%title('tradicional');
colormap(gray); rectangle('position',XF2,'EdgeColor','g')
%saveas(figure(900),'espectros_ventana\trad.eps','eps')
printFig('espectros_ventana\trad.eps');
figure(901),imagesc(tf_h);%title('hilbert'), 
colormap(gray); rectangle('position',XF2,'EdgeColor','g')
%saveas(figure(901),'espectros_ventana\hilb.eps','eps')
printFig('espectros_ventana\hilb.eps');

figure(902),imagesc(tf_he);%title('hilbert+MOBEMD'),
colormap(gray); rectangle('position',XF2,'EdgeColor','g')
%saveas(figure(902),'espectros_ventana\hilmo.eps','eps')
printFig('espectros_ventana\hilmo.eps');

figure(903),imagesc(tf_e);%title('MOBEMD'),
colormap(gray); rectangle('position',XF2,'EdgeColor','g')
%saveas(figure(903),'espectros_ventana\mobemd.eps','eps')
printFig('espectros_ventana\mobemd.eps');




figure(900),imagesc(tf_n);colormap(gray), %title('tradicional');
%saveas(figure(900),'espectros\trad.eps','eps')
figure(901),imagesc(tf_h);colormap(gray); %title('hilbert');    
%saveas(figure(901),'espectros\hilb.eps','eps')
figure(902),imagesc(tf_he);colormap(gray);%title('hilbert+MOBEMD');
%saveas(figure(902),'espectros\hilmo.eps','eps')
figure(903),imagesc(tf_e);colormap(gray); %title('MOBEMD');
%saveas(figure(903),'espectros\mobemd.eps','eps')


%%
tf_n=fftshift(abs(fft2(bemd.I_s)));
tf_h=fftshift(abs(fft2(bemd.imh)));
tf_he=fftshift(abs(fft2(bemd.hom)));
tf_e=fftshift(abs(fft2(bemd.imom(:,:,1))));

tf_he(215,:) = imnormalize(tf_he(215,:));
tf_h (215,:) = imnormalize(tf_h (215,:));
tf_n (215,:) = imnormalize(tf_n (215,:));
tf_e (215,:) = imnormalize(tf_e (215,:));

figure(904),plot(tf_n (215,:)), axis([0 size(tf_n,2) 0 0.009]) %title('tradicional'); 
%saveas(figure(904),'espectros_perfiles\trad.eps','eps')
xlabel('Position X/Pixel','FontSize',16), ylabel('Normalized Spectrum Intensity','FontSize',16)
printFig('espectros_perfiles\trad.eps');

figure(905),plot(tf_h (215,:)), axis([0 size(tf_n,2) 0 1.1]); %title('hilbert')    ; 
%saveas(figure(905),'espectros_perfiles\hilb.eps','eps')
xlabel('Position X/Pixel','FontSize',16), ylabel('Normalized Spectrum Intensity','FontSize',16)
printFig('espectros_perfiles\hilb.eps');

figure(906),plot(tf_he(215,:)), axis([0 size(tf_n,2) 0 1.1]); %title('hilbert+MOBEMD');
%saveas(figure(906),'espectros_perfiles\hilmo.eps','eps')
xlabel('Position X/Pixel','FontSize',16), ylabel('Normalized Spectrum Intensity','FontSize',16)
printFig('espectros_perfiles\hilmo.eps');

figure(907),plot(tf_e (215,:)), axis([0 size(tf_n,2) 0 1.1]); %title('MOBEMD')     ; 
%saveas(figure(907),'espectros_perfiles\mobemd.eps','eps')
xlabel('Position X/Pixel','FontSize',16), ylabel('Normalized Spectrum Intensity','FontSize',16)
printFig('espectros_perfiles\mobemd.eps');


%%

figure(801),colormap gray,imagesc(bemd.I_s), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('tubo.eps')
figure(802),colormap gray,imagesc(bemd.imh), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('comp_hilb.eps')
figure(803),colormap gray,imagesc(bemd.hom), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('comp_hilmo.eps')
figure(804),colormap gray,imagesc(bemd.imom(:,:,1)), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('comp_bemd.eps')


%%
figure(801),colormap gray,imagesc(imcrop(im)), xlabel('Position X/Pixel','FontSize',20), ylabel('Position Y/Pixel','FontSize',20)
printFig('tubo.eps')
%%
figure(801),colormap hot,imagesc(norm.phasec), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('phase_norm.eps')
figure(802),colormap hot,imagesc(hilb.phasec), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('phase_hilb.eps')
figure(803),colormap hot,imagesc(hbem.phasec), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('phase_hilmo.eps')
figure(804),colormap hot,imagesc(bemd.phasec), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('phase_bemd.eps')

%%

figure(801),colormap hot,imagesc(norm2.Mask), xlabel('Position X/Pixel','FontSize',16), ylabel('Position Y/Pixel','FontSize',16)
printFig('Mask.eps')
