clc;
close all
clear all

%% TO DO
    
% Create a start prompt (press enter to continue)
% Markers for points of inflection
% Markers for relative max and min
% Integration !!!!



% If time permits flip onto a screen?
% 

KbName('UnifyKeynames');
enter_code=KbName('y');
disp('Press ''y'' to continue');


[keyIsDown,timeSecs,keyCode]=KbCheck();
while ~keyCode(enter_code)
    [keyIsDown,timeSecs,keyCode]=KbCheck();
end


disp('Welcome to my Graphing Calculator Project');
WaitSecs(1);
clc;
while keyCode(:,28)==1
%% User input: Graph max and min
xMin_In=input('Declare x min: ','s');
xMax_In=input('Declare x max: ','s');
xRange_In=input('Declare space between points: ','s');
xMin=str2num(xMin_In);
xMax=str2num(xMax_In);
xRange=str2num(xRange_In);


yMin_In=input('Declare y min: ','s');
yMax_In=input('Declare y max: ','s');
yMin=str2num(yMin_In);
yMax=str2num(yMax_In);



%% x Range
x=xMin:xRange:xMax;


%% Convert user input into function
y=Graphing_Calc(x);
close all
tic;








%% Ask for derivatives
        deriv1_q=input('1st derivative (y/n): ','s');
        deriv2_q=input('2nd derivative (y/n): ','s');
        
        
        
%% Real number calc
num_y=(y==real(y));
real_orig_y=y(num_y);
real_orig_x=x(num_y);

%% Calculate 1st derivative of f(x)
deriv1_y=zeros(1,length(real_orig_x));
  for orig1_name = 1:length(real_orig_x)-1
        deriv1_y(:,orig1_name)=((real_orig_y(:,orig1_name+1))-(real_orig_y(:,orig1_name)));
  end
true_deriv1=deriv1_y/xRange;  



num_first=(true_deriv1==real(true_deriv1));
real_first=true_deriv1(num_first);
real_first_x=x(num_first);



%% Calculate 2nd derivative (d/dx (f'(x))
    deriv2_y=zeros(1,length(real_first));
    for orig2_name = 1:length(real_first)-1
        deriv2_y(:,orig2_name)=((real_first(:,orig2_name+1))-(...
            real_first(:,orig2_name)));
    end


true_deriv2=deriv2_y/xRange;

num_sec=(true_deriv2==real(true_deriv2));
real_sec=true_deriv2(num_sec);
real_sec_x=x(num_sec);
        

  for orig1_name = 1:length(real_orig_x)-1
        
        
%% Set f(x) asymptotes
        if real_orig_y(:,orig1_name)>yMax
            real_orig_y(:,orig1_name)=NaN;
        end
        if real_orig_y(:,orig1_name)<yMin
            real_orig_y(:,orig1_name)=NaN;
        end
        
    end

                    

            
%% Set f'(x) asymptotes           
            for deriv_name = 2:length(real_first)
%                 if real_first(:,deriv_name)>yMax
%                     real_first(:,deriv_name)=NaN;
%                 end
%                 
%                 if real_first(:,deriv_name)<yMin
%                     real_first(:,deriv_name)=NaN;
%                 end
                if real_first(:,deriv_name-1)-real_first(:,deriv_name)>1
                    real_first(:,deriv_name)=NaN;
                end
                if real_first(:,deriv_name-1)-real_first(:,deriv_name)<-1
                    real_first(:,deriv_name)=NaN;
                end
            end

%% Set f''(x) asymptotes

    for deriv_name = 1:length(real_sec)
                if real_sec(:,deriv_name)>yMax
                    real_sec(:,deriv_name)=NaN;
                end
                
                if real_sec(:,deriv_name)<yMin
                    real_sec(:,deriv_name)=NaN;
                end
                
    end
    
%% X and Y line

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
                plot(real_orig_x,real_orig_y,'b');
                hold on
                plot(real_orig_x(:,1:length(real_first)-1),real_first(:,1:length(real_first)-1),'g');
                xlim([xMin xMax]);
                ylim([yMin yMax]);

%% Holes f(x)
            
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
%% Holes f'(x)
            for hole_first=2:length(true_deriv1)-1
                if isnan(true_deriv1(:,hole_first)) && ~isnan(true_deriv1...
                        (:,hole_first-1)) && ~isnan(true_deriv1(:,hole_first +1))
                    true_deriv1(:,hole_first)=true_deriv1(:,hole_first-1);
                    hold on
                    scatter(real_orig_x(:,hole_first),true_deriv1(:,hole_first),'o','g');
                end
            end
            
            hold on
            disp('Original Function in blue');
            disp('1st Derivative in green');
            
            
            
%% No 1st derivative function
        elseif deriv1_q =='n'
%             for real_orig_plot=
                plot(real_orig_x,real_orig_y,'b');
                xlim([xMin xMax]);
                ylim([yMin yMax]);
                hold on
            
%% Holes f(x)
            
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
            disp('Original Function in blue');
        end
        

%% Plot 2nd derivative

        if deriv2_q == 'y'
            plot(real_orig_x,real_sec,'m');
            xlim([xMin xMax]);
            ylim([yMin yMax]);
            disp('2nd Derivative in magenta');
            grid on
            hold on
            
%% Holes for f''(x)
            for hole_second=2:length(true_deriv2)-2
                if isnan(true_deriv2(:,hole_second)) && ~isnan(true_deriv2...
                        (:,hole_second-1)) && ~isnan(true_deriv2(:,hole_second+1))
                    true_deriv2(:,hole_second)=true_deriv2(:,hole_second-1);
                    scatter(real_orig_x(:,hole_second),true_deriv2(:,hole_second),'o','m');
                end
            end
            
            
            
        elseif deriv2_q == 'n'
            plot (real_orig_x,real_orig_y,'b');
            xlim([xMin xMax]);
            ylim([yMin yMax]);

%% Holes f(x)
            
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
            
            grid on
            hold on
            disp('Original Function in blue');
        
        end
%% Time to generate the graphs
        toc


end
        
        

