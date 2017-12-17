% function FTC_area()

global gvar

x=-10:0.001:10
y=sin(x)

plot(x,y);
% hold on;
fill(x(:,10:100),y(:,10:100),'c');

