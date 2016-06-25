function IMF=mo_sift(S,itnum)
[rawrow rawcol]=size(S);
modulation=0;
ftype=0;
ExtaFlag=1;
%S=abs(S); %Cambio
for it=1:itnum
    fprintf(1,' sifting iteration: %d\n',it);
    
    [ridge,trough]=mo_findridtro(S,it,modulation);
    
    [UpEnv LowEnv]=mo_envEst(S,ridge,trough,ftype);
    mean=(UpEnv+LowEnv)/2;
    S=S-mean;
    modulation=UpEnv-LowEnv;
    %estimate mean's band range
    se = strel('disk', 3);
    Ridge = imopen(mean,se );
    Ridge_tophat=mean-Ridge;
    BW_maskest_tophat=Ridge_tophat>0.1;
    BW_maskest_tophat = bwmorph(BW_maskest_tophat,'majority');
    BW_roughthin_tophat = bwmorph(BW_maskest_tophat,'thin',Inf);
    
    areasize=490;
    BW_roughthin=wkeep(BW_roughthin_tophat,[areasize areasize]);
    BW_roughthin = bwmorph(BW_roughthin,'clean');
    
    %     fn_basic=12;be good except mixed pattern
    fn_basic=10;
    constdensity=10000;
    temp=find(BW_roughthin);
    density_est =length(temp)/constdensity;
%     fn=round(fn_basic/(density_est*1));
    if density_est>0.2
        ftype=3;
        moreit=3;
   
        if ExtaFlag
            ExtaFlag=0;
            for jj=1:(7-itnum)
                fprintf(1,'No %d extra itertaion.......\n',jj);
                [ridge,trough]=mo_findridtro(S,jj,modulation);
                
                [UpEnv LowEnv]=mo_envEst(S,ridge,trough,ftype);
                mean=(UpEnv+LowEnv)/2;
                S=S-mean;
                modulation=UpEnv-LowEnv;
                
            end
        end
    end
    
    
end
IMF=S;
