%DEDOMENA

M=1;
Iz=0.08;
g=9.81;
am=4410;

zTonos=0;  %z'(0)=0
yTonos=0;  %y'(0)=0

%arxikes sunthikes

fz= M*g + (am/1000);
tz=0;
z0= am/1000;
y0=0;
Cz= 3-(am/5000); %2.
Cy= 5+(am/5000);

%erwthma b dedomena

h=0.001;
t=0:h:30;

% z1  = z                      ara z1 = z(0)
% z2  = z1' = z' = f1(t,z1,z2) ara z2 = z'(0)
% z2' = z'' =      f2(t,z1,z2) 
%z1 = z0;
%z2 = z0tonos;

z1(1)= z0;
z2(1)= zTonos;

% y1  = y                      ara y1 = y(0)
% y2  = y1' = y' = g1(t,y1,y2) ara y2 = y'(0)
% y2' = y'' =      g2(t,y1,y2) 
%y1 = y0;
%y2 = y0tonos=0;

y1(1)= y0;
y2(1)= yTonos;

%f1=@(t,z1,z2) (z2);
%f2=@(t,z1,z2) ((fz-(g.*M)-Cz.*(abs(z2).*z2))./M);
%g1=@(t,y1,y2) (y2);
%g2=@(t,y1,y2) ((tz-Cy.*abs(y2).*y2)./Iz);      

% metraei apo 1-30 kai oxi apo 0-29 pou tha thelame, afou tha eprepe na einai n+1=30
% auto ginetai giati to octave dn afhnei na arxikopoihsoume timh z1(0)
% epeidh theloume vhma 0,001 kai n prepei na einai akeraios arithmos
% to panw orio ths for tha einai 30*1000=30000 me vhma 1  

%f1m = @f1;
%f2m = @f2;
%g1m = @g1;
%g2m = @g2;
% Euler gia Z kai Y
function f1a = f1(t,z1,z2)
  f1a = z2;
end
function f2a = f2(t,z1,z2)
  M = 1;
  g=9.81;
  am = 4410;
  fz= M*g + (am/1000);
  Cz= 3-(am/5000);
  f2a = (fz-(g*M)-Cz*(abs(z2)*z2))./M;
end
function g1a = g1(t,y1,y2)
  g1a = y2;
end
function g2a = g2(t,y1,y2)
  tz=0;
  am = 4410;
  Cy= 5+(am/5000);
  Iz=0.08;
  g2a = (tz-Cy.*abs(y2).*y2)./Iz;
end

%euler  
for n=1:1:30000;
  z1(n+1)= z1(n)+ h*(f1(t(n),z1(n),z2(n)));  %den xreiazetai h parenthesh meta to h kai prin to f
  z2(n+1)= z2(n)+ h*(f2(t(n),z1(n),z2(n)));
  
  y1(n+1)= y1(n)+ h*(g1(t(n),y1(n),y2(n)));
  y2(n+1)= y2(n)+ h*(g2(t(n),y1(n),y2(n)));
endfor

figure(1);

% grafikh gia Z1
subplot(311);
plot(t,z2);
title('Euler Z1');

% grafikh gia Y1
subplot(312);
plot(t,y1);
title('Euler Y1');

% tropopoihmenh Euler arxikes sunthikes
z1trop(1)= z0;
z2trop(1)= zTonos;
y1trop(1)= y0;
y2trop(1)= yTonos;

% tropopoihmenh Euler gia Z kai Y
for n=1:1:30000;
  z1trop(n+1)= z1trop(n)+ h*f1(t(n)+h/2,z1trop(n)+h/2,z2trop(n)+h/2*f2(t(n),z1trop(n),z2trop(n)));
  z2trop(n+1)= z2trop(n)+ h*f2(t(n)+h/2,z1trop(n)+h/2,z2trop(n)+h/2*f2(t(n),z1trop(n),z2trop(n)));
  y1trop(n+1)= y1trop(n)+ h*g1(t(n)+h/2,y1trop(n)+h/2,y2trop(n)+h/2*g2(t(n),y1trop(n),y2trop(n)));
  y2trop(n+1)= y2trop(n)+ h*g2(t(n)+h/2,y1trop(n)+h/2,y2trop(n)+h/2*g2(t(n),y1trop(n),y2trop(n)));
endfor

figure(2);

% grafikh gia Z tropopoihmenh
subplot(311);
plot(t,z1trop);
title('Tropopoihmenh Euler Z');

% grafikh gia Y tropopoihmenh
subplot(312);
plot(t,y1trop);
title('Tropopoihmenh Euler Y');


