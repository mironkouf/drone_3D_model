% DEDOMENA

M=1;
Iz=0.08;
g=9.81;
am=4410;

z0= am/1000;
zTonos=0;    %z'(0)=0

% arxikes sunthikes

Cz=3+(am/5000);
Kpz=5;
Kdz=15;
zdes=am/200;


h=0.001;
t=0:h:30;

% z1  = z                      ara z1 = z(0)
% z2  = z1' = z' = f1(t,z1,z2) ara z2 = z'(0)
% z2' = z'' =      f2(t,z1,z2) 
% z1 = z0;
% z2 = z0tonos;

% Euler arxikes sunthikes
z1(1)= z0;
z2(1)= zTonos;

% Euler gia Z 
function k1a = k1(t,z1,z2)
  k1a = z2;
end
function k2a = k2(t,z1,z2)
  M = 1;
  g=9.81;
  am = 4410;
  Cz=3+(am/5000);
  Kdz=15;
  Kpz=5;
  z0=am/1000;
  zdes=am/200;
  k2a = ((Kpz *zdes - Kpz *z1  -(Kdz+Cz)*z2)/M ); %apo erwthma 2a
end

% metraei apo 1-30 kai oxi apo 0-29 pou tha thelame, afou tha eprepe na einai n+1=30
% auto ginetai giati to octave dn afhnei na arxikopoihsoume timh z1(0)
% epeidh theloume vhma 0,001 kai n prepei na einai akeraios arithmos
% to panw orio ths for tha einai 30*1000=30000 me vhma 1  


% ANALUTIKH LUSH 
for n=1:1:30001
  z(n)= 22.05 -19.2783*exp(-0.611*t(n)) + 1.4383*exp(-8.189*t(n));
endfor

figure(1);

% GRAFIKH ANALUTIKHS LUSHS
subplot(311);
plot(t,z);
title('analutikh  z');


% EULER
for n=1:1:30000
  z1(n+1)= z1(n)+ h*(k1(t(n),z1(n),z2(n)));
  z2(n+1)= z2(n)+ h*(k2(t(n),z1(n),z2(n)));
endfor
 
figure(2);
 
% grafikh gia z euler 
subplot(311);
plot(t,z1);
title('euler z');

% tropopoihmenh Euler arxikes sunthikes
z1trop(1)= z0;
z2trop(1)= zTonos;

% TROPOPOIHMENH EULER
for n=1:1:30000
  z1trop(n+1)= z1trop(n)+ h*k1(t(n)+h/2,z1trop(n)+h/2,z2trop(n)+h/2*k2(t(n),z1trop(n),z2trop(n)));
  z2trop(n+1)= z2trop(n)+ h*k2(t(n)+h/2,z1trop(n)+h/2,z2trop(n)+h/2*k2(t(n),z1trop(n),z2trop(n)));
endfor

% grafikh gia Z tropopoihmenh
subplot(312);
plot(t,z1trop);
title(' tropopoihmenh euler z')