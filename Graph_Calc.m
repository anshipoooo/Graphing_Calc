clc;
close all
clear all



while true
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
deriv_y=zeros(1,length(x));

    for orig_name = 1:length(x)-1
        deriv_y(:,orig_name)=((y(:,orig_name+1))-(y(:,orig_name)));
        
%% Set asymptotes
        if y(:,orig_name)>yMax
            y(:,orig_name)=NaN;
        end
        if y(:,orig_name)<yMin
            y(:,orig_name)=NaN;
        end
        
    end

%% Ask for 1st derivative
        deriv_q=input('1st derivative (y/n): ','s');
        
        
        
        
        true_deriv=diff(y)/0.001;
        z=deriv_y/0.001;
        disp(deriv_y);

        if deriv_q == 'y'
            
            hold on
%% Set asymptotes for 1st derivative            
            for deriv_name = 1:length(z)
                if z(:,deriv_name)>yMax
                    z(:,deriv_name)=NaN;
                end
                
                if z(:,deriv_name)<yMin
                    z(:,deriv_name)=NaN;
                end
                
            end

%% Plot original graph and 1st derivative
            plot(x,y,'b');
            plot(x(:,1:length(z)-1),z(1:length(z)-1),'g');
            
        elseif deriv_q =='n'
            plot(x,y,'b');
        end
        
%% Time to generate the graphs
        secs=GetSecs;
        disp('Time take to generate graph: ')
        disp(secs);
        
        
        
end
