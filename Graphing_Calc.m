
% while true
%% Load Graph


% equation = lower(input('\nEnter graph function: ','s'));

% 
% equation=str2func(equation);
% 
% plot(x,equation);

% true_equation = str2func(['@(x)' equation]);
% tru_equation = str2func(equation);
% 
% x_axis = linspace(-10,10);
% plot(x_axis,tru_equation);

function y= myf(x)
    f=@(x) input('Enter equation in terms of x: ');
    y=f(x);
    
    
    
    
end


