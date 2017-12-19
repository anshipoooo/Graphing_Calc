clc
clear all
close all

% h = animatedline;
% axis([0 4*pi -1 1])
% x = linspace(0,4*pi,2000);

% for k = 1:length(x)
%     y = sin(x(k));
%     addpoints(h,x(k),y);
%     drawnow 
% end

t = 0 ;
x = 0 ;
startSpot = 0;
interv = 1000 ; % considering 1000 samples
step = 0.1 ; % lowering step has a number of cycles and then acquire more data
while ( t <interv )
    b = sin(t)+5;
    x = [ x, b ];
    plot(x) ;

      if ((t/step)-500 < 0)
          startSpot = 0;
      else
          startSpot = (t/step)-500;
      end

      axis([ startSpot, (t/step+50), 0 , 10 ]);
      grid
      t = t + step;
      drawnow;
      pause(0.01)
  end