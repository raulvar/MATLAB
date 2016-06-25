x=0:0.01:2;
y=sin(x*pi);
x1=0:0.12:2;
y1=sin(x1*pi);
dato=y(1);
soft=0.2;
hard=NaN;
y2(1)=y(1);
y2(size(y,2))=y(end);
for i=2:size(y,2)-1
    if (abs(dato-y(i))>=soft || y(i)>hard )
        y2(i) = y(i);
        dato = y(i);
    else
        y2(i)= NaN;
    end
end
%%
hold off, figure(1), plot(x,y), hold on, plot(x1,y1,'*')
%%plot(x,y2,'or')
legend('Lectura de sensado','Conexion proactiva T=0.12')%,'Conexion reactiva St =0.2')
