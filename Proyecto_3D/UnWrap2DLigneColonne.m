%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  function [ret,MaskF,PhaseUnWrappedRegion]=UnWrap2DLigneColonne(PhaseWrapped,Mask,PIUnwrapping)
%
%%Function qui fait lacorrection de la phase discontinue en utilisant
%%l'algoritm classique.
%%Lamatrix PhaseWrapped est corrige a partir du point PIUnwrapping
%%en sistemecoord (x,y). La masque Mask permet de controler lacorrection
%%lespoints avec 1 sont traites.
function [ret,MaskF,PhaseUnWrappedRegion]=UnWrap2DLigneColonne(PhaseWrapped,Mask,PIUnwrapping)

	Invalid=255; %Sur la mask une pixel avec 255 est pas valable
	Valid=0; %Sur la mask une pixel avec 0 est valable
	Processed=128;
	Width=size(PhaseWrapped,2);		
   Height=size(PhaseWrapped,1); 
   ret=0;
   
		%DISPLAY=WImagePane->canvas();

	
 %CALCUL DE LA REGION D' INTERET
	POSCOLONNE1=1;POSCOLONNE2=Width;
	POSLIGNE1=1;POSLIGNE2=Height;
	
	datosx=POSCOLONNE2-POSCOLONNE1+1;
	datosy=POSLIGNE2-POSLIGNE1+1;
	comp=Mask==1;
	Mask=comp.*Valid+Invalid*(1-comp);
	PhaseWrappedRegion=PhaseWrapped;
   MaskRegion=Mask;
   
  PhaseUnWrappedRegion=zeros(size(Mask));
	%Pixel Initial
	PIx=PIUnwrapping(1);
	PIy=PIUnwrapping(2);
	if(MaskRegion(PIy,PIx)~=Valid)
     disp('Mauvaise choix de Pixel Initial');
		return;
	end

	opc=1;
	i=1;
	sentidoHor=1; %Cherche en direction horizontale droite avec 1;
	PhaseUnWrappedRegion(PIy,PIx)=PhaseWrappedRegion(PIy,PIx);
   MaskRegion(PIy,PIx)=Processed;
   %control de visualization
   ContTr=0;DatV=1600;
	%Corrige en direction verticale superieur du pixel initial
	Posy=PIy;
	Posx=PIx;
	ControlColonne=1;
	PosyColonne=Posy-1;
	while(ControlColonne & PosyColonne > 0 )
		if(MaskRegion(PosyColonne,Posx)==Valid)
			PhaseUnWrapPI=PhaseUnWrappedRegion(PosyColonne+1,Posx);
			PhaseWrappedPI=PhaseWrappedRegion(PosyColonne+1,Posx);
			PhaseWrappedPC=PhaseWrappedRegion(PosyColonne,Posx);
			Valeur=IntegrarPC(PhaseWrappedPC,PhaseWrappedPI,PhaseUnWrapPI);
			PhaseUnWrappedRegion(PosyColonne,Posx)=Valeur;
			MaskRegion(PosyColonne,Posx)=Processed;
         %%%%%DISPLAY->pixel(Posx+POSCOLONNE1,PosyColonne+POSLIGNE1,zColor(255,0,0));			
         ContTr=ContTr+1;  
         if mod(ContTr/DatV,1)==0
            figure(1);imagesc(PhaseUnWrappedRegion);colormap(gray);drawnow;
         end
			PosyColonne=PosyColonne-1;
		else
         ControlColonne=0;
     end
	end
	%integrer en direction verticale inferieur
	ControlColonne=1;
	PosyColonne=Posy+1;
	while(ControlColonne & PosyColonne <= datosy )
		if(MaskRegion(PosyColonne,Posx)==Valid)
			PhaseUnWrapPI=PhaseUnWrappedRegion(PosyColonne-1,Posx);
			PhaseWrappedPI=PhaseWrappedRegion(PosyColonne-1,Posx);
			PhaseWrappedPC=PhaseWrappedRegion(PosyColonne,Posx);
			Valeur=IntegrarPC(PhaseWrappedPC,PhaseWrappedPI,PhaseUnWrapPI);
			PhaseUnWrappedRegion(PosyColonne,Posx)=Valeur;
			MaskRegion(PosyColonne,Posx)=Processed;
    %%%%%DISPLAY->pixel(Posx+POSCOLONNE1,PosyColonne+POSLIGNE1,zColor(255,0,0));			
       ContTr=ContTr+1;  
       if mod(ContTr/DatV,1)==0
          figure(1);imagesc(PhaseUnWrappedRegion);colormap(gray);drawnow;
       end
			PosyColonne=PosyColonne+1;
		else
         ControlColonne=0;
     end
	end
	ControlTotal=1;
	while(ControlTotal)
		Posx=PIx+sentidoHor;
		Posy=PIy;
		
		ControLigne=1;
		while(Posx<=datosx & ControLigne==1 & Posx >0 )
			if(MaskRegion(Posy,Posx)==Valid)
				PhaseUnWrapPI=PhaseUnWrappedRegion(Posy,Posx-sentidoHor);
				PhaseWrappedPI=PhaseWrappedRegion(Posy,Posx-sentidoHor);
				PhaseWrappedPC=PhaseWrappedRegion(Posy,Posx);
				Valeur=IntegrarPC(PhaseWrappedPC,PhaseWrappedPI,PhaseUnWrapPI);
				PhaseUnWrappedRegion(Posy,Posx)=Valeur;
				MaskRegion(Posy,Posx)=Processed;
       %%%%%DISPLAY->pixel(Posx+POSCOLONNE1,Posy+POSLIGNE1,zColor(255,0,0));
	       ContTr=ContTr+1;            
         if mod(ContTr/DatV,1)==0
            % figure(1);imagesc(PhaseUnWrappedRegion);colormap(gray);drawnow;
         end
  			%integrer en direction verticale superieur
				ControlColonne=1;
				PosyColonne=Posy-1;
				while(ControlColonne & PosyColonne > 0 )
					if(MaskRegion(PosyColonne,Posx)==Valid)
						PhaseUnWrapPI=PhaseUnWrappedRegion(PosyColonne+1,Posx);
						PhaseWrappedPI=PhaseWrappedRegion(PosyColonne+1,Posx);
						PhaseWrappedPC=PhaseWrappedRegion(PosyColonne,Posx);
						Valeur=IntegrarPC(PhaseWrappedPC,PhaseWrappedPI,PhaseUnWrapPI);
						PhaseUnWrappedRegion(PosyColonne,Posx)=Valeur;
						MaskRegion(PosyColonne,Posx)=Processed;
           %%%%DISPLAY->pixel(Posx+POSCOLONNE1,PosyColonne+POSLIGNE1,zColor(255,0,0));			
    		       ContTr=ContTr+1;                  
	  		       if mod(ContTr/DatV,1)==0
  	     		     % figure(1);imagesc(PhaseUnWrappedRegion);colormap(gray);drawnow;
  		       		end
           
						PosyColonne=PosyColonne-1;
					else
                  ControlColonne=0;
            end
				end

				%integrer en direction verticale inferieur
				ControlColonne=1;
				PosyColonne=Posy+1;
				while(ControlColonne & PosyColonne <= datosy )
					if(MaskRegion(PosyColonne,Posx)==Valid)
						PhaseUnWrapPI=PhaseUnWrappedRegion(PosyColonne-1,Posx);
						PhaseWrappedPI=PhaseWrappedRegion(PosyColonne-1,Posx);
						PhaseWrappedPC=PhaseWrappedRegion(PosyColonne,Posx);
						Valeur=IntegrarPC(PhaseWrappedPC,PhaseWrappedPI,PhaseUnWrapPI);
						PhaseUnWrappedRegion(PosyColonne,Posx)=Valeur;
						MaskRegion(PosyColonne,Posx)=Processed;
        %%%		DISPLAY->pixel(Posx+POSCOLONNE1,PosyColonne+POSLIGNE1,zColor(255,0,0));			
			       ContTr=ContTr+1;    
       			  if mod(ContTr/DatV,1)==0
		            %figure(1);imagesc(PhaseUnWrappedRegion);colormap(gray);drawnow;
     		    end
        
						PosyColonne=PosyColonne+1;
					else
                  ControlColonne=0;
            end
				end
				Posx=Posx+sentidoHor;
			else
				ControLigne=0;
       end
      end

		%Recherche de points non-traites
		MINLIGNESREGION=min(MaskRegion,[],2);
		Control1=1;
		Posy=round(datosy/2);
		POSYO=Posy;
		while(Posy<=datosy & Control1)
			if(MINLIGNESREGION(Posy,1)==Valid)
				PIy=Posy;
				Control2=1;
				Posx=1;
				while(Posx<=datosx & Control2)
					if(MaskRegion(PIy,Posx)==Valid)
						if(Posx>1 & Posx<=datosx-1)
							if(MaskRegion(PIy,Posx-1)==Processed)
								PIx=Posx-1;
								Control2=0;
								Control1=0;
								sentidoHor=1;
							end
							if(MaskRegion(PIy,Posx+1)==Processed)
								PIx=Posx+1;
								Control2=0;
								Control1=0;
								sentidoHor=-1;
							end
							if(Control2)
                        Posx=Posx+1;
                 end
						else
							if(Posx==1)
								if(MaskRegion(PIy,Posx+1)==Processed)
									PIx=Posx+1;
									Control2=0;
									Control1=0;
									sentidoHor=-1;
								end
							end
							if(Posx==datosx)
								if(MaskRegion(PIy,Posx-1)==Processed)
									PIx=Posx-1;
									Control2=0;
									Control1=0;
									sentidoHor=1;
								end
							end
							if(Control2)
                        Posx=Posx+1;
                 end
              end
					else
                  Posx=Posx+1;
            end
				end
          if(Control1)
             Posy=Posy+1;
          end
			else
            Posy=Posy+1;
       end
		end
		if(Posy==datosy+1)
			Posy=POSYO-1;
			Control1=1;
			while(Posy>=1 & Control1)
				if(MINLIGNESREGION(Posy,1)==Valid)
					PIy=Posy;
					Control2=1;
					Posx=1;
					while(Posx<=datosx & Control2)
						if(MaskRegion(PIy,Posx)==Valid)
							if(Posx>1 & Posx<=datosx-1)
								if(MaskRegion(PIy,Posx-1)==Processed)
									PIx=Posx-1;
									Control2=0;
									Control1=0;
									sentidoHor=1;
								end
								if(MaskRegion(PIy,Posx+1)==Processed)
									PIx=Posx+1;
									Control2=0;
									Control1=0;
									sentidoHor=-1;
								end
                   if(Control2)
                      Posx=Posx+1;
                    end
							else
								if(Posx==1)
									if(MaskRegion(PIy,Posx+1)==Processed)
										PIx=Posx+1;
										Control2=0;
										Control1=0;
										sentidoHor=-1;
									end
								end
								if(Posx==datosx)
									if(MaskRegion(PIy,Posx-1)==Processed)
										PIx=Posx-1;
										Control2=0;
										Control1=0;
										sentidoHor=1;
									end
								end
								if(Control2)
                           Posx=Posx+1;
                   end
                end
						else
                     Posx=Posx+1;
               end
					end
					if(Control1)
                  Posy=Posy-1;
            end
				else
               Posy=Posy-1;
          end
			end
			if(Posy==0)
            ControlTotal=0;	
       end
		end
   end
   
   %figure(1);imagesc(PhaseUnWrappedRegion);colormap(gray);drawnow;
   
	aun=min(min(MaskRegion));
	if(aun==Valid)
      disp('Encore Il y a des points actives');		
      comp=(MaskRegion==Valid);
      MaskRegion=comp.*Invalid+MaskRegion.*(1-comp);
   end
   comp=(MaskRegion==Processed);
   MaskRegion=comp;
 	MaskF=MaskRegion;
	
   
   ret=1;
return


