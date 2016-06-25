I=imread('Resultadosplano_1_0_.tif');
figure(1),imshow(I);
%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %TRANSFORMADA DE FOURIER DE LA IMAGEN
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    TFI=fft2(I);
    ap=1;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SE CONSTRUYE UNA MASCARA PARA FILTRAR EL PICO DERECHO DE LA TRANSFORMADA DE FOURIER
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        gf=figure;
        L=fftshift(log(1+abs(TFI)));
        imagesc((L));axis('xy');
        colormap gray;
        %%
        [sub_der,rect_der] = imcrop(L); 
figure(2),imagesc(sub_der),%pixval;
TFF=sub_der;
        %%
       ginput(1);
        Z=rbbox;
        M=CoordAxesrbbox(Z);
        XF=round(M);
        
        FILTRE=zeros(size(TFI));
        FILTRE(XF(2):XF(4),XF(1):XF(3))=1;
        
        FILTRE=fftshift(FILTRE);
        close(gf);

        TFF=TFI.*FILTRE;
     %%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        %SE HACE LA TRANSFORMADA INVERSA A LA IMAGEN FILTRADA
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        ITF=ifft2(TFF);
        
        %%%%%%%%%%%%%%%%%%%%%%
        %SE CALCULA LA FASE
        %%%%%%%%%%%%%%%%%%%%%%
        
        
        M=abs(ITF);
        Mask=M/max(M(:));
        FASED=atan2(imag(ITF),real(ITF));
        
        figure;imagesc(FASED); colormap gray;title(num2str(i));
        %imcrop(FASED);