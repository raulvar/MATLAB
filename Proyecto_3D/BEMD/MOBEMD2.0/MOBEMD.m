function IMF_all=MOBEMD(I,denoisMethod,itnum,imf_num);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Version 2.0
% Note: running this code needs  MATLAB 7.5 (Release R2007b) or later
%  versions.The code also uses Image Processing Toolbox , Signal
%  Processing Toolbox, and Wavelet Toolbox.
%
%  MOBEMD is an algorithm for sparsely decomposing fringe patterns into two
%  components: a single intrinsic mode function (IMF) and a residue.
%
%  This algorithm reproduces the results from the article:
%
%  [1] Xiang Zhou, Adrian Gh. Podoleanu, Zhuangqun Yang, Tao Yang,and Hong Zhao,
%      "Morphological operation-based bi-dimensional empirical mode
%      decomposition for adaptive background removal of fringe patterns ,"
%      Optics Express(submitted).
%
% Release Notes:
%  1. Major revisions on July 26,2012.
%       1) Remove a bug with the 'twotonemixed' so that  mixPattern.bmp can be properly decomposed
%       2) Add the 2D DWT denoising codes to function "mo_denois",which uses
%          a db9 wavelet and reconstructs the fringe pattern with
%          1st level approximate coefficients.
%       3) Some notes are added to the example file.
%       4) A iteration counter is diplayed in Command Window during the sifting.
%
%  2. Major revisions on Aug 1,2012.
%       1) filter bank is densified by 4 times in order to obtain a more smooth decomposition.
%       2) Generate filterbank by code in stead of loading file for reducing the file size.
%
%  3. Major revisions on Aug 27,2012.
%       1) enhance the automaic handling by remove the input parameter of fringe pattern type.
%       2) adaptive iteration number extension.
%       minor revisions:
%         1) set the default denoisMethod='lowpass',
%         1) add 'nodenois'option to denoisMethod,
% FUNCTION INTERFACE:
%
%  IMF_all=MOBEMD(I,denoisMethod,itnum,imf_num);

%
%  BASIC USAGE EXAMPLES:
%
%     Case 1) Using an default setting:
%     Components=MOBEMD(I);
%     where I is an analyzed fringe pattern. the default
%     denoisMethod='lowpass',
%     itnum=4;
%     imf_num=1;
%     Case 2) You can designate input parameter according your fringe
%     pattern type. For example
%         Components=MOBEMD(I,'lowpass',7,2);
%      it means to analyze a closed pattern with a low-pass filter
%      denoising, 7 iterations for one sifting and 2 resulting IMFs
%
%  INPUT ARGUMENTS :
%
%     1) I (matrix 512 x 512): anaylized fringe pattern.It should be
%        512*512 currently.
%     2) fringetype(obsolete): % 'carrier','closed','twotonemixed',corresponds to
%        carrier fringe patterns, closed patterns and mixed carrier pattern
%        demostrated in the paper.
%     3) denoisMethod : for noise reduction preprocessing. At present, four
%         methods are available, namely, 'lowpass', 'DWT','BM3D','nodenois', wherein
%         BM3D needs external codes published by K. Dabov. You can download the free
%         package from http://www.cs.tut.fi/~foi/GCF-BM3D/
%     4) itnum : iteration nubmer. should >=4. a too large number will
%         greatly increase the computation time and add no significant effects.
%         4-10 is recommended.
%     5)  imf_num : decomposed IMFs. for a sparse case, it should be 1,
%         which means only an IMF and a residue are extracted.
%         However, it can be >1 for a natural scene image or other combined fringe patterns.
%
%  OUTPUTS:
%     1) IMF_all (3 dim array: 512*512*(imf_num+1)) :  contain all the IMFs and a residue


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright (c) 2012-2013 Xian Jiaotong University.
% All rights reserved.
% This work should only be used for nonprofit purposes.
%
% AUTHORS:
%     Xiang Zhou, email: zhouxiang@xjtu.edu.cn
%     Personal page: http://gr.xjtu.edu.cn/web/zhouxiang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (exist('denoisMethod') ~= 1)
    denoisMethod         = 'lowpass'; %% default lowpass
end
if (exist('itnum') ~= 1)
    itnum         = 4; %% default itnum
end
if (exist('imf_num') ~= 1)
    imf_num         = 1; %% default imf_num
end


if strcmp(denoisMethod, 'lowpass') == 1,
    dtype=1;
elseif strcmp(denoisMethod, 'DWT') == 1,
    dtype=2;
elseif strcmp(denoisMethod, 'BM3D') == 1,
    dtype=3;
else
    dtype=4;
end
global h_3D;

% % load('filterbank1.mat');
%construct filter bank.
[totalrow,totalcol]=size(I);
h_3D=zeros(totalrow,totalcol,252);
constprodcut= 12.^4;
for fn=1:252
    sigma=constprodcut/(fn/4).^2;% relatively good
    sigma=sqrt(sigma)/2-1;
%     if totalrow>totalcol
%         wsize=totalrow+1;
%     else
%         wsize=totalcol+1;
%     end
    wsize=totalrow+1;
    hsize=[wsize wsize];
    h = fspecial('gaussian', hsize,sigma);% gaussian average
    h=wkeep(h,[totalrow totalcol],[1 1]);
    h=fftshift(h )/max(h(:));
    h_3D(:,:,fn)=h;
end

I=mo_denois(I,dtype);
S=I;

IMF_all=[];
for it=1:imf_num
    tic
    IMF=mo_sift(S,itnum);
    toc
    S=S-IMF;
    IMF_all(:,:,it)=IMF;
    
end
IMF_all(:,:,it+1)=S;
