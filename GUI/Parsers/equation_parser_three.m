function equation_parser_three()

global funcParse3

%% Convert user input into function --> previously Graphing_Calc
% gvar.raw_in=input('Enter your function in terms of x: ','s');    

%% Take the user inputted string and add the variable string for easy manipulation
variable_string='+1-1';
funcParse3.format_in=strcat(funcParse3.raw_in,variable_string);

%% Create variables that are a vector indicating when a number or letter is present
DF=isstrprop(funcParse3.format_in,'digit');
AF=isstrprop(funcParse3.format_in,'alpha');

%% Loop to manipulate implicit equations into MatLab-friendly equations
for implicit_loop=1:length(DF)-1

%% Whenever a number is followed by x, place a '.*' between the two
    DF=isstrprop(funcParse3.format_in,'digit');
    if DF(1,implicit_loop)==1 && funcParse3.format_in(:,implicit_loop+1)=='x'
        funcParse3.implicit_before_dig=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_dig=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_dig,'.*',funcParse3.implicit_after_dig);
    end
    
%% Whenever a number is followed by y, place a '.*' between the two
    DF=isstrprop(funcParse3.format_in,'digit');
    if DF(1,implicit_loop)==1 && funcParse3.format_in(:,implicit_loop+1)=='y'
        funcParse3.implicit_before_dig=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_dig=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_dig,'.*',funcParse3.implicit_after_dig);
    end
    
%% Whenever there's an x followed by a letter, place a '.*' between the two
    AF=isstrprop(funcParse3.format_in,'alpha');
    if funcParse3.format_in(:,implicit_loop)=='x' && AF(:,implicit_loop+1)==1
        funcParse3.implicit_before_alpha=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_alpha=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_alpha,'.*',funcParse3.implicit_after_alpha);
    end
    
%% Whenever there's a y followed by a letter, place a '.*' between the two
    AF=isstrprop(funcParse3.format_in,'alpha');
    if funcParse3.format_in(:,implicit_loop)=='y' && AF(:,implicit_loop+1)==1
        funcParse3.implicit_before_alpha=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_alpha=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_alpha,'.*',funcParse3.implicit_after_alpha);
    end
    
%% Whenever there's a carrot followed by a letter, place parentheses around the function
    if funcParse3.format_in(:,implicit_loop)=='^' && AF(:,implicit_loop+1)==1
        funcParse3.implicit_before_exp=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_exp=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_exp,'(',funcParse3.implicit_after_exp,')');
    end
    

end

%% Remove the extra variable string after the function
funcParse3.format_in=strrep(funcParse3.format_in,variable_string,'');

%% Square root function
funcParse3.format_in=strrep(funcParse3.format_in,'?(','sqrt(');

%% Basic switches
     
     funcParse3.format_in=strrep(funcParse3.format_in,'x*','x.*');
     funcParse3.format_in=strrep(funcParse3.format_in,'y*','y.*');
     funcParse3.format_in=strrep(funcParse3.format_in,'/','./');
     funcParse3.format_in=strrep(funcParse3.format_in,'+-','-');
     funcParse3.format_in=strrep(funcParse3.format_in,')(',').*(');
     funcParse3.format_in=strrep(funcParse3.format_in,'ln(','log(');
     funcParse3.format_in=strrep(funcParse3.format_in,'arcsin(','asin(');
     funcParse3.format_in=strrep(funcParse3.format_in,'arccos(','acos(');
     funcParse3.format_in=strrep(funcParse3.format_in,'arctan(','atan(');
     funcParse3.format_in=strrep(funcParse3.format_in,'arccsc(','acsc(');
     funcParse3.format_in=strrep(funcParse3.format_in,'arcsec(','asec(');
     funcParse3.format_in=strrep(funcParse3.format_in,'arccot(','acot(');

 %% Exponential functions
 if contains(funcParse3.format_in,'e^(') 
     
     funcParse3.format_in=strrep(funcParse3.format_in,'e^(','exp(');
 elseif contains(funcParse3.format_in,'e.^(')
     funcParse3.format_in=strrep(funcParse3.format_in,'e.^(','exp(');

 
 elseif contains(funcParse3.raw_in,'e^x')
     funcParse3.format_in=strrep(funcParse3.format_in,'e^x','exp(x)');
     
 elseif contains(funcParse3.raw_in,'e^y')
     funcParse3.format_in=strrep(funcParse3.format_in,'e^y','exp(y)');
     
 elseif contains(funcParse3.raw_in,'^x') || contains(funcParse3.raw_in,'^(')...
         || contains(funcParse3.raw_in,'^y')

     funcParse3.format_in=strrep(funcParse3.format_in,'^','.^');
 elseif contains(funcParse3.raw_in,'x^') 
     funcParse3.format_in=strrep(funcParse3.format_in,'x^','x.^');
 end
 if contains(funcParse3.raw_in,'y^')
     funcParse3.format_in=strrep(funcParse3.format_in,'y^','y.^');
 end

%% xy operations

funcParse3.format_in=strrep(funcParse3.format_in,'xy','x.*y');
funcParse3.format_in=strrep(funcParse3.format_in,'x/y','x./y');

 %% Absolute value change

if contains(funcParse3.raw_in,'|')
    abs_split=strsplit(funcParse3.format_in,'|');
    abs_in=strcat('abs(',abs_split{2},')');
    funcParse3.format_in=strcat(abs_split{1},abs_in,abs_split{3});

end



end

