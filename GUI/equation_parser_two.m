function equation_parser_two

global funcParse2

%% Convert user input into function --> previously Graphing_Calc
% gvar.raw_in=input('Enter your function in terms of x: ','s');    

%% Take the user inputted string and add the variable string for easy manipulation
variable_string='+1-1';
funcParse2.format_in=strcat(funcParse2.raw_in,variable_string);

%% Create variables that are a vector indicating when a number or letter is present
DF=isstrprop(funcParse2.format_in,'digit');
AF=isstrprop(funcParse2.format_in,'alpha');

%% Loop to manipulate implicit equations into MatLab-friendly equations
for implicit_loop=1:length(DF)-1
    
%% Whenever a number is followed by x, place a '.*' between the two
    DF=isstrprop(funcParse2.format_in,'digit');
    if DF(1,implicit_loop)==1 && funcParse2.format_in(:,implicit_loop+1)=='x'
        funcParse2.implicit_before_dig=extractBefore(funcParse2.format_in,implicit_loop+1);
        funcParse2.implicit_after_dig=extractAfter(funcParse2.format_in,implicit_loop);
        funcParse2.format_in=strcat(funcParse2.implicit_before_dig,'.*',funcParse2.implicit_after_dig);
    end
    
%% Whenever there's an x followed by a letter, place a '.*' between the two
    AF=isstrprop(funcParse2.format_in,'alpha');
    if funcParse2.format_in(:,implicit_loop)=='x' && AF(:,implicit_loop+1)==1
        funcParse2.implicit_before_alpha=extractBefore(funcParse2.format_in,implicit_loop+1);
        funcParse2.implicit_after_alpha=extractAfter(funcParse2.format_in,implicit_loop);
        funcParse2.format_in=strcat(funcParse2.implicit_before_alpha,'.*',funcParse2.implicit_after_alpha);
    end
    
%% Whenever there's a carrot followed by a letter, place parentheses around the function
    if funcParse2.format_in(:,implicit_loop)=='^' && AF(:,implicit_loop+1)==1
        funcParse2.implicit_before_exp=extractBefore(funcParse2.format_in,implicit_loop+1);
        funcParse2.implicit_after_exp=extractAfter(funcParse2.format_in,implicit_loop);
        funcParse2.format_in=strcat(funcParse2.implicit_before_exp,'(',funcParse2.implicit_after_exp,')');
    end
    

end

%% Remove the extra variable string after the function
funcParse2.format_in=strrep(funcParse2.format_in,variable_string,'');

%% Square root function
funcParse2.format_in=strrep(funcParse2.format_in,'?(','sqrt(');

%% Basic switches
     
     funcParse2.format_in=strrep(funcParse2.format_in,'x*','x.*');
     funcParse2.format_in=strrep(funcParse2.format_in,'/','./');
     funcParse2.format_in=strrep(funcParse2.format_in,'+-','-');
     funcParse2.format_in=strrep(funcParse2.format_in,')(',').*(');
     funcParse2.format_in=strrep(funcParse2.format_in,'ln(','log(');
     funcParse2.format_in=strrep(funcParse2.format_in,'arcsin(','asin(');
     funcParse2.format_in=strrep(funcParse2.format_in,'arccos(','acos(');
     funcParse2.format_in=strrep(funcParse2.format_in,'arctan(','atan(');
     funcParse2.format_in=strrep(funcParse2.format_in,'arccsc(','acsc(');
     funcParse2.format_in=strrep(funcParse2.format_in,'arcsec(','asec(');
     funcParse2.format_in=strrep(funcParse2.format_in,'arccot(','acot(');

 %% Exponential functions
 if contains(funcParse2.format_in,'e^(') 
     
     funcParse2.format_in=strrep(funcParse2.format_in,'e^(','exp(');
 elseif contains(funcParse2.format_in,'e.^(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e.^(','exp(');

 
 elseif contains(funcParse2.raw_in,'e^x')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^x','exp(x)');
 elseif contains(funcParse2.raw_in,'^x') || contains(funcParse2.raw_in,'^(')

     funcParse2.format_in=strrep(funcParse2.format_in,'^','.^');
 elseif contains(funcParse2.raw_in,'x^')
     funcParse2.format_in=strrep(funcParse2.format_in,'x^','x.^');
 elseif contains(funcParse2.raw_in,'e^sin(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^sin(','exp(sin(');
 elseif contains(funcParse2.raw_in,'e^cos(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^cos(','exp(cos(');
 elseif contains(funcParse2.raw_in,'e^tan(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^tan(','exp(tan(');
 elseif contains(funcParse2.raw_in,'e^csc(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^csc(','exp(csc(');
 elseif contains(funcParse2.raw_in,'e^sec(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^sec(','exp(sec(');
 elseif contains(funcParse2.raw_in,'e^cot(')
     funcParse2.format_in=strrep(funcParse2.format_in,'e^cot(','exp(cot(');
 end



 %% Absolute value change

if contains(funcParse2.raw_in,'|')
    abs_split=strsplit(funcParse2.format_in,'|');
    abs_in=strcat('abs(',abs_split{2},')');
    funcParse2.format_in=strcat(abs_split{1},abs_in,abs_split{3});
end

