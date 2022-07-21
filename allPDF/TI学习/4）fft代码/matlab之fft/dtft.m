clc ;
clear;
j=1:256;
k=1:256;

%phaseComp=zeros(256,256,2);
phaseComp=cos(k'*j*2*pi/256)-sin(k'*j*2*pi/256)*i;
figure(1);
for m=1:5
    subplot(3,3,m) 
    plot3(real(phaseComp(m,:)),imag(phaseComp(m,:)),j);
end
    subplot(3,3,6) 
    plot3(real(phaseComp(128,:)),imag(phaseComp(128,:)),j);
    subplot(3,3,7) 
    plot3(real(phaseComp(256-7,:)),imag(phaseComp(256-7,:)),j);
n=50;
dtft_in=cos(n*j*2*pi/256)-sin((n*j*2*pi/256))*i;
%dtft_in=cos(n*j*2*pi/256)+cos(15*j*2*pi/256);

subplot(3,3,8) 
plot3(j,real(dtft_in),imag(dtft_in));

w=hamming(256)+hamming(256)*i;
dtft_out =  dtft_in * phaseComp';
subplot(3,3,9) 
plot(j,abs(dtft_out));