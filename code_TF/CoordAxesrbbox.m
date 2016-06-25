%funcion para obtener ls coordenadas en unidades de los ejes de la funcion RBBOX
%X=CoordAxesrbbox(Z) donde Z es obtenida de ginput(1);Z=RBBOX;
function X=CoordAxesrbbox(Z)

     PX=get(gcf,'position');
     WF=PX(3);HF=PX(4);
     PX=get(gca,'position');
     WA=PX(3);HA=PX(4);
     OFXA=PX(1);OFYA=PX(2);
     DX=OFXA*WF;DX1=(1-OFXA-WA)*WF;
     DY=OFYA*HF;DY1=(1-OFYA-HA)*HF;
	  AX=get(gca,'XLim');AY=get(gca,'YLim');
     Pasox1=WA/(WF-DX-DX1); %Unidades unitarias del eje/Unidades en pixeles de la figura     
     Pasox2=(AX(2)-AX(1))/WA; %Unidades del eje/Unidades unitariasdel eje
     Pasox=Pasox1*Pasox2;
     Pasoy1=HA/(HF-DY-DY1); %Unidades unitarias del eje/Unidades en pixeles de la figura     
     Pasoy2=(AY(2)-AY(1))/HA; %Unidades del eje/Unidades unitariasdel eje
     Pasoy=Pasoy1*Pasoy2;
     
     
     if length(Z)==4
	     if strcmp(get(gca,'XDir'),'normal')
           P1x=(Z(1)-DX)*Pasox+AX(1);
	   	  P2x=Z(3)*Pasox+P1x;
        else
           P1x=AX(2)-(Z(1)-DX)*Pasox;
	   	  P2x=P1x-Z(3)*Pasox;
        end
        if strcmp(get(gca,'YDir'),'normal')
           P1y=(Z(2)-DY)*Pasoy+AY(1);
           P2y=Z(4)*Pasoy+P1y;
        else
   		  P1y=AY(2)-(Z(2)-DY)*Pasoy;
           P2y=P1y-Z(4)*Pasoy;
        end
        
	     X=zeros(1,4);
   	  X(1)=P1x;
	     X(2)=P1y;
   	  X(3)=P2x;
        X(4)=P2y;
     elseif length(Z)==2
	     if strcmp(get(gca,'XDir'),'normal')
           P1x=(Z(1)-DX)*Pasox+AX(1);
        else
           P1x=AX(2)-(Z(1)-DX)*Pasox;
        end
        if strcmp(get(gca,'YDir'),'normal')
           P1y=(Z(2)-DY)*Pasoy+AY(1);
        else
   		  P1y=AY(2)-(Z(2)-DY)*Pasoy;
        end
        
	     X=zeros(1,2);
   	  X(1)=P1x;
	     X(2)=P1y;
     else
        X=zeros(1,2);
     end
     
     if X(1)>X(3)
         a=X(1);
         X(1)=X(3);
         X(3)=a;
     end
     if X(2)>X(4)
         a=X(2);
         X(2)=X(4);
         X(4)=a;
     end
         
  return;   
     
