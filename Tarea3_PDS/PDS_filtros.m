Ap = 3;
As = 25;
ws1=50;
wp1=20;
wp2=20000;
ws2=45000;
%% Primer paso
k1 = wp1/ws1;
k2 = wp2/ws2;

d = sqrt((10^(0.1*Ap)-1)/(10^(0.1*As)-1));

%% Segundo paso 
n1 = ceil(log10(1/d)/log10(1/k1));
n2 = ceil(log10(1/d)/log10(1/k2));
e2 =10^(0.1*Ap)-1;
%% Calcular los polos filtro 1
R1 = (1/sqrt(e2))^(1/n1)*wp1;
for i=1:n1
   O1(i) = (2*i-1)*pi/(2*n1); 
end
P1 = -R1*sin(O1)+1i*R1*cos(O1);
%% Calcular los polos filtro 2
R2 = (1/sqrt(e2))^(1/n2)*wp2;
for i=1:n1
   O2(i) = (2*i-1)*pi/(2*n2); 
end
P2 = -R2*sin(O2)+1i*R2*cos(O2);

figure, plot(P1,'or')
figure, plot(P2,'or')



%%



%% Ejercicio 2
a = 1:6;
col = ['r','b','y','m','c','k','p','g','o'];
for i = 1:6
w = -pi:0.01*pi:pi;
z= exp(-1i*w);
b= (1-z)./(1+z);
H= 2*a(i)^2./(b.^2+2*a(i)*b+2*a(i)^2);
hold on, plot(w/pi,abs(H),col(i))
end
legend('\alpha =1','\alpha =2','\alpha =3','\alpha =4','\alpha =5','\alpha =6')

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%QUINTO EJERCICIO%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 250;                    % Sampling frequencycorr
T = 1/Fs;                     % Sample time
L = 4000;                     % Length of signal
t = (0:L-1)*T;                % Time vector
x = csvread('ecg.csv');

plot(t,x)
title('Signal')
xlabel('time (milliseconds)')

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
X = fft(x,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
figure
plot(f,2*abs(X(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of x(t)')
xlabel('Frequency (Hz)')
ylabel('|X(f)|')

%% Filtrado 

y1 = filter (Hd1,x);
y2 = filter (Hd2,x);
y3 = filter (Hd3,x);
y4 = filter (Hd4,x);
y5 = filter (Hd5,x);

figure(23)
figure(321), plot(t,x),  title('Signal '), xlabel('time (milliseconds)')
figure(322), plot(t,y1), title('Filtered Signal by Butterworth -  '), xlabel('time (milliseconds)')
figure(323), plot(t,y2), title('Filtered Signal by Chebychev type I'), xlabel('time (milliseconds)')
figure(324), plot(t,y3), title('Filtered Signal by Chebychev type II'), xlabel('time (milliseconds)')
figure(325), plot(t,y4), title('Filtered Signal by Rectangular Window'), xlabel('time (milliseconds)')
figure(326), plot(t,y5), title('Filtered Signal by Blackman'), xlabel('time (milliseconds)')

% saveas(figure(321),'Filtrado\OriginalSignal.png','png')
% saveas(figure(322),'Filtrado\FilteredSignalH1.png','png')
% saveas(figure(323),'Filtrado\FilteredSignalH2.png','png')
% saveas(figure(324),'Filtrado\FilteredSignalH3.png','png')
% saveas(figure(325),'Filtrado\FilteredSignalH4.png','png')
% saveas(figure(326),'Filtrado\FilteredSignalH5.png','png')


NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y1 = fft(y1,NFFT)/L;
Y2 = fft(y2,NFFT)/L;
Y3 = fft(y3,NFFT)/L;
Y4 = fft(y4,NFFT)/L;
Y5 = fft(y5,NFFT)/L;

f = Fs/2*linspace(0,1,NFFT/2+1);


figure(24)
figure(321),plot(f,2*abs(X(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)'), xlabel('Frequency (Hz)'),ylabel('|X(f)|')
figure(322),plot(f,2*abs(Y1(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h1(t)'), xlabel('Frequency (Hz)'),ylabel('|X1(f)|')
figure(323),plot(f,2*abs(Y2(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h2(t)'), xlabel('Frequency (Hz)'),ylabel('|X2(f)|')
figure(324),plot(f,2*abs(Y3(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h3(t)'), xlabel('Frequency (Hz)'),ylabel('|X3(f)|')
figure(325),plot(f,2*abs(Y4(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h4(t)'), xlabel('Frequency (Hz)'),ylabel('|X4(f)|')
figure(326),plot(f,2*abs(Y5(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h5(t)'), xlabel('Frequency (Hz)'),ylabel('|X5(f)|')

% saveas(figure(321),'Filtrado\SOriginalSignal.png','png')
% saveas(figure(322),'Filtrado\SFilteredSignalH1.png','png')
% saveas(figure(323),'Filtrado\SFilteredSignalH2.png','png')
% saveas(figure(324),'Filtrado\SFilteredSignalH3.png','png')
% saveas(figure(325),'Filtrado\SFilteredSignalH4.png','png')
% saveas(figure(326),'Filtrado\SFilteredSignalH5.png','png')

%%
z1 = filter (H1,y1);
z2 = filter (H2,y1);
z3 = filter (H3,y1);
Z1= fft(z1);
Z2= fft(z2);
Z3= fft(z3);
% y2 = filter (Hd2,x);
% y3 = filter (Hd3,x);
% y4 = filter (Hd4,x);
% y5 = filter (Hd5,x);
% figure(321),plot(f,2*abs(X(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)'), xlabel('Frequency (Hz)'),ylabel('|X(f)|')
% figure(322),plot(f,2*abs(Z1(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h1(t)'), xlabel('Frequency (Hz)'),ylabel('|X1(f)|')
% figure(323),plot(f,2*abs(Z2(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h2(t)'), xlabel('Frequency (Hz)'),ylabel('|X2(f)|')
% figure(324),plot(f,2*abs(Z3(1:NFFT/2+1))), title('Single-Sided Amplitude Spectrum of x(t)*h3(t)'), xlabel('Frequency (Hz)'),ylabel('|X3(f)|')

figure(321), plot(t,x),  title('Signal '), xlabel('time (milliseconds)')
figure(322), plot(t,z1), title('Filtered Signal by Butterworth -  '), xlabel('time (milliseconds)')
figure(323), plot(t,z2), title('Filtered Signal by Chebychev type I'), xlabel('time (milliseconds)')
figure(324), plot(t,z3), title('Filtered Signal by Chebychev type II'), xlabel('time (milliseconds)')

saveas(figure(321),'Filtrado\f1.png','png')
saveas(figure(322),'Filtrado\fH1.png','png')
saveas(figure(323),'Filtrado\fH2.png','png')
saveas(figure(323),'Filtrado\fH3.png','png')

