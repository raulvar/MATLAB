function  ret=IntegrarPC(PhaseWrappedPC,PhaseWrappedPI,PhaseUnWrapPI)
	M_PI=pi;
	dif=PhaseWrappedPC-PhaseWrappedPI;
    
	if(dif<M_PI & dif>-M_PI)
		difModul=dif;
	else
		if(dif<=-M_PI & dif>=-2*M_PI)
			difModul=dif+2*M_PI;
		else
			if(dif<=2*M_PI & dif>=M_PI)
				difModul=dif-2*M_PI;
			else   
				disp(['IntegrarPC:Phase superieur en module a 2pi: "',num2str(dif)]);
				difModul=-PhaseUnWrapPI;
			end
		end
	end
   
   ret=PhaseUnWrapPI+difModul;
	return;
	

