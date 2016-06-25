function mascara =  Mascara(I3,Th,n,p)
% Th - 0:255
% n, tamaño del filtro de mediana
% p=6;
hkj=uint8(medfilt2(I3,[1 3]));
kernel = [-1; 0; p];
% figure(3),plot(1:1024,hkj(:,1))
% figure(4),plot(1:1024,imfilter(hkj(:,1),kernel))
convi = imfilter(hkj,kernel);
mask = convi<Th;

mask(:,1:10)=0;
mask(:,size(convi,2)-10:size(convi,2))=0;

mask(1:10,:)=0;
mask(size(convi,1)-10:size(convi,1),:)=0;
mascara =medfilt2(uint8(mask),[n n]);
%figure, imshow(255*mascara)

mascara = double(mascara).*repmat((1:size(mascara,1))',[1 size(mascara,2)]);
mascara2=mascara;
mascara2(mascara==0)=NaN; 
minimos = min(mascara2);
maximos = max(mascara);


for j=10:size(mascara,2)-10
    if (~isnan(minimos(j)) && ~isnan(maximos(j)))
       mascara(minimos(j):maximos(j),j)=1; 
    else
%         if (isnan(minimos(j))&& ~isnan(maximos(j)))
%             minimos(j)=minimos(j-1);
%             mascara(minimos(j):maximos(j),j)=1; 
%         else
%              if (~isnan(minimos(j))&& isnan(maximos(j)))
%                 mascara(minimos(j):maximos(j-1),j)=1; 
%              else 
%                  if (isnan(minimos(j)) && isnan(maximos(j)))
%                      mascara(minimos(j-1):maximos(j-1),j)=1; 
%                  end
%              end
%          end
    end
end

%figure, imshow(mascara)
%figure, imshow(mascara.*imgradientxy(mascara))
end

