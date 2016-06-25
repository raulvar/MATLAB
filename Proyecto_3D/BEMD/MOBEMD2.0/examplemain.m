clear
% % % %load example image
image_name = strcat('examplepics\','projectedPattern.bmp');
% % % 'illuPattern.bmp'
% % % 'mixPattern.bmp'
% % % 'closedPattern.bmp'
% % % 'projectedPattern.bmp'
% % % 'fingerprint.bmp'

I_uint = imread(image_name,'bmp');%% 
I= double(imcrop(I_uint,[1 1 1023 1023]));

%mono carrier pattern------------------------------
%%
% sparse decomposition using MO-BEMD
Components=MOBEMD(I,'lowpass',4);
IMF  =squeeze(Components(:,:,1));
Residue=squeeze(Components(:,:,2));
% 1) denoising method£º'lowpass', 'DWT','BM3D','nodenois';
% Note£º 'BM3D'  usually preforms better than others, but it needs a exteral BM3D
%         codes that can be downloaded at http://www.cs.tut.fi/~foi/GCF-BM3D/
%        'DWT' is suited to  fringe pattern with small noise.
%        'lowpass' can be used in general case but not for noise-free pattern.. 
%        'nodenois' means no denoising, used in noise-free pattern or small
%        noise pattern
%        Also, you can modify the denoising codes or add your own denoising alrigthm to function mo_denois.m  
%         in order to suit your fringe pattern.
