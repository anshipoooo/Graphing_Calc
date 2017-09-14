clc;
close all
clear all



while true

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


x=xMin:xRange:xMax;

y=Graphing_Calc(x);
close all






deriv1_y=zeros(1,length(x));
    for orig_name = 1:length(x)-1
        deriv1_y(:,orig_name)=((y(:,orig_name+1))-(y(:,orig_name)));
        if y(:,orig_name)>yMax
            y(:,orig_name)=NaN;
        end
        if y(:,orig_name)<yMin
            y(:,orig_name)=NaN;
        end
        
    end
    
        deriv_q=input('1st derivative (y/n): ','s');
        
        
        
        
        true_deriv=diff(y)/0.001;
        z=deriv1_y/0.001;
        disp(deriv1_y);

        if deriv_q == 'y'
            
            hold on
            
            for deriv_name = 1:length(z)
                if z(:,deriv_name)>yMax
                    z(:,deriv_name)=NaN;
                end
                
                if z(:,deriv_name)<yMin
                    z(:,deriv_name)=NaN;
                end
                
            end
            
            plot(x,y,'b');
            plot(x(:,1:length(z)-1),z(1:length(z)-1),'g');
            
        elseif deriv_q =='n'
            plot(x,y,'b');
        end
        secs=GetSecs;
        disp('Time take to generate graph: ')
        disp(secs);
        
        
end
