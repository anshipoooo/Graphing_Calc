clc;
close all
clear all

%% TO DO
    
% Create a start prompt (press enter to continue)
% Figure out log and ln functions
% Markers for points of inflection
% Markers for relative max and min
% Integration !!!!


%hi this is michael

% If time permits flip onto a screen?

disp('Welcome to my Graphing Calculator Project');
WaitSecs(1);
enter_prompt = input('Type enter to continue: ','s');


while enter_prompt=='enter'
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





%% Calculate 1st derivative of f(x)
deriv1_y=zeros(1,length(x));


    for orig1_name = 1:length(x)-1
        deriv1_y(:,orig1_name)=((y(:,orig1_name+1))-(y(:,orig1_name)));
        
        
%% Set f(x) asymptotes
        if y(:,orig1_name)>yMax
            y(:,orig1_name)=NaN;
        end
        if y(:,orig1_name)<yMin
            y(:,orig1_name)=NaN;
        end
        
    end

            true_deriv1=deriv1_y/xRange;
%% Calculate 2nd derivative (d/dx (f'(x))
    deriv2_y=zeros(1,length(deriv1_y));
    for orig2_name = 1:length(deriv1_y)-1
        deriv2_y(:,orig2_name)=((true_deriv1(:,orig2_name+1))-(...
            true_deriv1(:,orig2_name)));
        if deriv1_y(:,orig1_name)>yMax
            deriv1_y(:,orig1_name)=NaN;
        end
        if deriv1_y(:,orig1_name)<yMin
            deriv1_y(:,orig1_name)=NaN;
        end
    end
    
%% Set f'(x) asymptotes           
            for deriv_name = 1:length(true_deriv1)
                if true_deriv1(:,deriv_name)>yMax
                    true_deriv1(:,deriv_name)=NaN;
                end
                
                if true_deriv1(:,deriv_name)<yMin
                    true_deriv1(:,deriv_name)=NaN;
                end
                
            end

%% Set f''(x) asymptotes
true_deriv2=deriv2_y/xRange;
    for deriv_name = 1:length(true_deriv2)
                if true_deriv2(:,deriv_name)>yMax
                    true_deriv2(:,deriv_name)=NaN;
                end
                
                if true_deriv2(:,deriv_name)<yMin
                    true_deriv2(:,deriv_name)=NaN;
                end
                
    end
        
%% Ask for derivatives
        deriv1_q=input('1st derivative (y/n): ','s');
        deriv2_q=input('2nd derivative (y/n): ','s');
        
        
        
        
        

        

    if deriv1_q == 'y'  
    
%% Plot original graph and 1st derivative
            grid on
            plot(x,y,'b');
            hold on
            plot(x(:,1:length(true_deriv1)-1),true_deriv1(1:length(true_deriv1)-1),'g');
            xlim([xMin xMax]);
            ylim([yMin yMax]);
%% Holes f(x)
            
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    scatter(x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
%% Holes f'(x)
            for hole_first=2:length(true_deriv1)-1
                if isnan(true_deriv1(:,hole_first)) && ~isnan(true_deriv1...
                        (:,hole_first-1)) && ~isnan(true_deriv1(:,hole_first +1))
                    true_deriv1(:,hole_first)=true_deriv1(:,hole_first-1);
                    scatter(x(:,hole_first),true_deriv1(:,hole_first),'o','g');
                end
            end
            
            hold on
            disp('Original Function in blue');
            disp('1st Derivative in green');
            
            
            
%% No 1st derivative function
        elseif deriv1_q =='n'
            plot(x,y,'b');
            xlim([xMin xMax]);
            ylim([yMin yMax]);
            hold on
            
%% Holes for f'(x)
            for hole_first=2:length(true_deriv1)-1
                if isnan(true_deriv1(:,hole_first)) && ~isnan(true_deriv1...
                        (:,hole_first-1)) && ~isnan(true_deriv1(:,hole_first +1))
                    true_deriv1(:,hole_first)=true_deriv1(:,hole_first-1);
                    scatter(x(:,hole_first),true_deriv1(:,hole_first),'o','g');
                end
            end
            grid on
            disp('Original Function in blue');
        end
        

%% Plot 2nd derivative

        if deriv2_q == 'y'
            plot(x(1:length(true_deriv2)-1),true_deriv2(1:length(true_deriv2)-1),'m');
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
                    scatter(x(:,hole_second),true_deriv2(:,hole_second),'o','m');
                end
            end
            
            
            
        elseif deriv2_q == 'n'
            plot (x,y,'b');
            xlim([xMin xMax]);
            ylim([yMin yMax]);

%% Hole for f(x)
            for hole_orig=2:length(y)
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1))...
                        && ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    scatter(x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
            
            grid on
            hold on
            disp('Original Function in blue');
        
        end
%% Time to generate the graphs
        secs=GetSecs;
        disp('Time take to generate graph: ')
        disp(secs);
        


end
        
        

