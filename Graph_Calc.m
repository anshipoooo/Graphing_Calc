clc;
close all
clear all

%% TODO
% Absolute Value
% Slider on the graph --> getCoord function inclusion

prompt = input('Type enter to begin: ','s');

%% Skip user inputs
set_points=input('Would you like to input your own range? (y/n)','s');

%% Start prompt
while prompt == 'enter'
clc;
if set_points=='y'
    xMin_In=input('Declare x min: ','s');
    xMax_In=input('Declare x max: ','s');
    xMin=str2num(xMin_In);
    xMax=str2num(xMax_In);
    xDist=0.001;
    yMin_In=input('Declare y min: ','s');
    yMax_In=input('Declare y max: ','s');
    yMin=str2num(yMin_In);
    yMax=str2num(yMax_In);
elseif set_points=='n'
    xMin=-10;
    xMax=10;
    xDist=0.001;
    yMin=-10;
    yMax=10;
end
%% x Range
x=xMin:xDist:xMax;
%% Convert user input into function --> previously Graphing_Calc
    raw_in=input('Enter equation in terms of x: ','s');
    format_in=strrep(raw_in,'*','.*');
    format_in=strrep(format_in,'e^','exp');
    format_in=strrep(format_in,'^','.^');
    format_in=strrep(format_in,'/','./');
    format_in=strrep(format_in,'+-','-');
    format_in=strrep(format_in,'+(','-(');
    y=eval(format_in);
close all
tic;
%% User graph prompts
        deriv1_q=input('1st derivative (y/n): ','s');

        deriv2_q=input('2nd derivative (y/n): ','s');

        tracing_input=input('Would you like to trace the graph? (y/n) ','s');
%% Real number calc
num_y=(y==real(y));
real_orig_y=y(num_y);
real_orig_x=x(num_y);
%% Calculate 1st derivative of f(x)
deriv1_y=zeros(1,length(real_orig_x));
  for orig1_name = 1:length(real_orig_x)-1
        deriv1_y(:,orig1_name)=((real_orig_y(:,orig1_name+1))-(real_orig_y(:,orig1_name)));
  end
true_deriv1=deriv1_y/xDist;
num_first=(true_deriv1==real(true_deriv1));
real_first=true_deriv1(num_first);
real_first_x=x(num_first);
%% Calculate 2nd derivative (d/dx (f'(x))
    deriv2_y=zeros(1,length(real_first));
    for orig2_name = 1:length(real_first)-1
        deriv2_y(:,orig2_name)=((real_first(:,orig2_name+1))-(...
            real_first(:,orig2_name)));
    end
true_deriv2=deriv2_y/xDist;
num_sec=(true_deriv2==real(true_deriv2));
real_sec=true_deriv2(num_sec);
real_sec_x=x(num_sec);
  for orig1_name = 1:length(real_orig_x)-1
%% Set f(x) asymptotes
        if real_orig_y(:,orig1_name)>yMax
            real_orig_y(:,orig1_name)=NaN;
        elseif real_orig_y(:,orig1_name)<yMin
            real_orig_y(:,orig1_name)=NaN;
        end
  end
%% Set f'(x) asymptotes
            for deriv_name = 2:length(real_first)
                if real_first(:,deriv_name-1)-real_first(:,deriv_name)>1
                    real_first(:,deriv_name)=NaN;
                elseif real_first(:,deriv_name-1)-real_first(:,deriv_name)<-1
                  real_first(:,deriv_name)=NaN;
                end
            end
%% Set f''(x) asymptotes
    for deriv_name = 2:length(real_sec)
            if real_sec(:,deriv_name-1)-real_sec(:,deriv_name)>yMax
                    real_sec(:,deriv_name)=NaN;
            elseif real_sec(:,deriv_name-1)-real_sec(:,deriv_name)<yMin
                  real_sec(:,deriv_name)=NaN;
            end
    end

%% axes
aH=axes;
xlim([xMin xMax]);
ylim([yMin yMax]);

%% X and Y line
axis([xMin xMax yMin yMax]);
plot([xMin xMax],[0 0],'k');
hold on
plot([0 0],[yMin yMax],'k');
hold on
%% Start graphing
    if deriv1_q == 'y'
%% Plot original graph and 1st derivative
            real_num=zeros(1,length(num_y));
            for real_first_plot=1:length(real_orig_y)
                real_num(:,real_first_plot)=num_y(:,real_first_plot);
            end
                grid on
                hold on
                graph(1)=plot(aH,real_orig_x,real_orig_y,'b');
                hold on
                graph(2)=plot(aH,real_orig_x(:,1:length(real_first)-1),real_first(:,1:length(real_first)-1),'g');
                hold on

%% Holes f(x)
            for hole_orig=2:length(real_first)-1
                if isnan(y(:,hole_orig))
                    graph(2)=scatter(real_orig_x(:,hole_orig),real_first(:,hole_orig),'o','g');
                    hold on
                    graph(3)=scatter(real_orig_x(:,hole_orig),real_sec(:,hole_orig),'o','m');
                    hold on
                elseif isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    graph(1)=scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end

            end
%% Holes f'(x)
            for hole_first=2:length(true_deriv1)-1
                if isnan(true_deriv1(:,hole_first)) && ~isnan(true_deriv1...
                        (:,hole_first-1)) && ~isnan(true_deriv1(:,hole_first +1))
                    true_deriv1(:,hole_first)=true_deriv1(:,hole_first-1);
                    hold on
                    graph(2)=scatter(real_orig_x(:,hole_first),true_deriv1(:,hole_first),'o','g');
                end
            end
            hold on
            disp('Original Function in blue');
            disp('1st Derivative in green');
%% No 1st derivative function
        elseif deriv1_q =='n'
                graph(1)=plot(aH,real_orig_x,real_orig_y,'b');
                hold on


%% Holes f(x)
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    graph(1)=scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
            disp('Original Function in blue');
    end
%% Plot 2nd derivative
        if deriv2_q == 'y'
            graph(3)=plot(aH,real_orig_x,real_sec,'m');
            hold on
            
            disp('2nd Derivative in magenta');
            grid on
            hold on
%% Holes for f''(x)
            for hole_second=2:length(true_deriv2)-2
                if isnan(true_deriv2(:,hole_second)) && ~isnan(true_deriv2...
                        (:,hole_second-1)) && ~isnan(true_deriv2(:,hole_second+1))
                    true_deriv2(:,hole_second)=true_deriv2(:,hole_second-1);
                    graph(3)=scatter(real_orig_x(:,hole_second),true_deriv2(:,hole_second),'o','m');
                end
            end
        elseif deriv2_q == 'n'
            graph(1)=plot(aH,real_orig_x,real_orig_y,'b');
            hold on

%% Holes f(x)
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    graph(1)=scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
            grid on
            hold on
            disp('Original Function in blue');
        end

for rel_min=2:length(real_sec)-1
%% Relative min/max
    if real_first(:,rel_min-1)>0 && real_first(:,rel_min+1)<0
        hold on
        graph(1)=scatter(real_orig_x(:,rel_min),real_orig_y(:,rel_min),'d','b');
    elseif real_first(:,rel_min-1)<0 && real_first(:,rel_min+1)>0
        hold on
        graph(1)=scatter(real_orig_x(:,rel_min),real_orig_y(:,rel_min),'d','b');
    end

%% POI
    if real_sec(:,rel_min-1)<0 && real_sec(:,rel_min+1)>0
        hold on
        graph(1)=scatter(real_orig_x(:,rel_min),real_orig_y(:,rel_min),'s','b');
    elseif real_sec(:,rel_min-1)>0 && real_sec(:,rel_min+1)<0
        hold on
        graph(1)=scatter(real_orig_x(:,rel_min),real_orig_y(:,rel_min),'s','b');
    end
end


%% Title
title(raw_in);


%% Time to generate the graphs
        toc

%% UI (clicking on points)
 if tracing_input == 'y'
     hold on
% Click on graph variable points
     set(graph,'hittest','off'); 
     hold on;
% Initiate getCoord when clicked
     set(aH,'ButtonDownFcn',@getCoord);
    xlim([xMin xMax]);
    ylim([yMin yMax]);

    restart_program=input('Type ''restart'' to restart program: ','s');

    if restart_program=='restart'
      WaitSecs(0.00000001);
      close all;
    end
 end

% end
end
