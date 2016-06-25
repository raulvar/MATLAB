function phasec=unwrap2DClasico_Sin_Masc(PIX,PIY,phased)

[SizeY,DatosXT]=size(phased);

S=phased(PIY:SizeY,:);
IInf=unwrap(S);
S=[];


S=flipud(phased(1:PIY,:));
ISup=flipud(unwrap(S));
S=[];
M=zeros(SizeY,DatosXT);
M(1:PIY,:)=ISup;
M(PIY:SizeY,:)=IInf;
ISup=[];IINf=[];

L=phased(PIY,:);
SC=L(PIX:DatosXT);
IDer=unwrap(SC);
SC=[];
SC=fliplr(L(1:PIX));
IIzq=fliplr(unwrap(SC));
LM=zeros(1,DatosXT);
LM(1,1:PIX)=IIzq;
LM(1,PIX:DatosXT)=IDer;
N=LM-L;
NN=ones(SizeY,1)*N;
phasec=NN+M;
