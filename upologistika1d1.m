%DEDOMENA

M=1;
Iz=0.08;
g=9.81;
am=4410;

%DEDOMENA ERWTHMATOS G

Cz=3+(am/5000);
Cy=5;

Kpz=5;
Kdz= 15-(am/1000);
Kpy=5;
Kdy=20;
z0=am/1000;
y0=0;
zdes=am/200;
ydes=am/3000;

zTonos=0;  %z'(0)=0
yTonos=0;  %y'(0)=0

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
%y2 = y0tonos;

y1(1)= y0;
y2(1)= yTonos;

%f1=@(t,z1,z2) (z2);
%f2=@(t,z1,z2) ((M*g+Kpz*(zdes-z1)-Kdz*z2-(g*M)-Cz.*(abs(z2).*z2))./M);
%g1=@(t,y1,y2) (y2);
%g2=@(t,y1,y2) ((Kpy*(ydes-y1)- Kdy*y2-Cy.*abs(y2).*y2)./Iz); 

% metraei apo 1-30 kai oxi apo 0-29 pou tha thelame, afou tha eprepe na einai n+1=30
% auto ginetai giati to octave dn afhnei na arxikopoihsoume timh z1(0)
% epeidh theloume vhma 0,001 kai n prepei na einai akeraios arithmos
% to panw orio ths for tha einai 30*1000=30000 me vhma 1  


% Euler gia Z kai Y
function f1a = f1(t,z1,z2)
  f1a = z2;
end
function f2a = f2(t,z1,z2)
  M = 1;
  g=9.81;
  am = 4410;
  Cz=3+(am/5000);
  Cy=5;
  Kpz=5;
  Kdz= 15-(am/1000);
  z0=am/1000;
  zdes=am/200;
  f2a = ((M*g+Kpz*(zdes-z1)-Kdz*z2-(g*M)-Cz.*(abs(z2).*z2))./M);
end
function g1a = g1(t,y1,y2)
  g1a = y2;
end
function g2a = g2(t,y1,y2)
  Iz=0.08;
  tz=0;
  am = 4410;
  Cy=5;
  Kpy=5;
  Kdy=20;
  y0=0;
  ydes=am/3000;
  g2a = ((Kpy*(ydes-y1)- Kdy*y2-Cy.*abs(y2).*y2)./Iz); 
end

for n=1:1:30000;
  z1(n+1)= z1(n)+ h*f1(t(n),z1(n),z2(n));
  z2(n+1)= z2(n)+ h*f2(t(n),z1(n),z2(n));
  y1(n+1)= y1(n)+ h*g1(t(n),y1(n),y2(n));
  y2(n+1)= y2(n)+ h*g2(t(n),y1(n),y2(n));
endfor

figure(1);

% grafikh gia Z1
subplot(311);
plot(t,z1);
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