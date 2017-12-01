% clc
% clear all
% close all




%     x=-10:0.01:10;
%     equa=input('Enter equation: ','s');
%     y=eval(equa);
%     deriv1_y=zeros(1,length(x));
%     for orig1_name = 1:length(x)-1
%         deriv1_y(:,orig1_name)=((y(:,orig1_name+1))-(y(:,orig1_name)));
%     end
%     true_deriv1=deriv1_y/0.01;
%     num_first=(true_deriv1==real(true_deriv1));
%     real_first=true_deriv1(num_first);
%     real_first_x=x(num_first);


    
%     h=plot(x,real_first,'c');
%     hold on
%     g=plot(x,y);
%     grid on
%     xlim([-10 10]);
%     ylim([-10 10]);

% while true
%     g.XDataSource='x';
%     g.YDataSource='y';
%     h.YDataSource='real_first';

%     equa=input('Enter equation: ','s');
%     y=eval(equa);
%     deriv1_y=zeros(1,length(x));
%     for orig1_name = 1:length(x)-1
%         deriv1_y(:,orig1_name)=((y(:,orig1_name+1))-(y(:,orig1_name)));
%     end
%     true_deriv1=deriv1_y/0.01;
%     num_first=(true_deriv1==real(true_deriv1));
%     real_first=true_deriv1(num_first);
%     real_first_x=x(num_first);
%     refreshdata;


% end



clc
clear all
close all

x=-10:0.01:10
y=eval(input('Enter equation: ','s'));
deriv1(x,y);

while true
    g.XDataSource='x';
    g.YDataSource='y';









