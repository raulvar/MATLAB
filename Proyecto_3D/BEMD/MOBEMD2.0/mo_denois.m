function I_denoised=mo_denois(I,dtype);
%%
% % % % %%BM3D denoise
switch dtype
    case 1
        global h_3D;
        fn_init=6;
        h=h_3D(:,:,fn_init);
        I_fft2=fft2(I);%
        I_denoised=ifft2(I_fft2.*h);
        
        fn_init=28;
        h=h_3D(:,:,fn_init);
        I_fft2=fft2(I_denoised);%
        I_fringe=I_denoised-ifft2(I_fft2.*h);
        BW_maskest_tophat = I_fringe>0;
        BW_roughthin_tophat = bwmorph(BW_maskest_tophat,'thin',Inf);
        
        areasize=490;
        BW_roughthin=wkeep(BW_roughthin_tophat,[areasize areasize]);
        BW_roughthin = bwmorph(BW_roughthin,'clean');
        
        fn_basic=10;
        constdensity=10000;
        temp=find(BW_roughthin);
        density_est =length(temp)/constdensity;
        fn=round(fn_basic/(density_est*1));
        h=h_3D(:,:,fn);
        I_fft2=fft2(I);%
        I_denoised=ifft2(I_fft2.*h);
        nois=I-I_denoised;
        
        
    case 2
        
        N=1;
        T = wpdec2(I,N,'db9');
        I_denoised = wprcoef(T,[N 0]);
        
    case 3
        HjL=I;
        Min=min(HjL(:));
        Max=max(HjL(:));
        ratioTo255=255/(Max-Min);
        Channel_Imageto255=(HjL-Min)*ratioTo255;
        [NA, I_denoised] = BM3D(1, Channel_Imageto255, 40);%, sigma);
        I_denoised=I_denoised*255/ratioTo255+Min;
        DWT_filterout=HjL-I_denoised;
    otherwise
        I_denoised=I;
end

%%
