function equation_parser_vect()

global vect

%% Convert user input into function --> previously Graphing_Calc
% gvar.raw_in=input('Enter your function in terms of x: ','s');    

%% Take the user inputted string and add the variable string for easy manipulation
variable_string='+1-1';
vect.format_in=strcat(vect.raw_in,variable_string);

%% Create variables that are a vect indicating when a number or letter is present
DF=isstrprop(vect.format_in,'digit');
AF=isstrprop(vect.format_in,'alpha');

%% Loop to manipulate implicit equations into MatLab-friendly equations
for implicit_loop=1:length(DF)-1

%% Whenever there's a carrot followed by a letter, place parentheses around the function
    if vect.format_in(:,implicit_loop)=='^' && AF(:,implicit_loop+1)==1
        vect.implicit_before_exp=extractBefore(vect.format_in,implicit_loop+1);
        vect.implicit_after_exp=extractAfter(vect.format_in,implicit_loop);
        vect.format_in=strcat(vect.implicit_before_exp,'(',vect.implicit_after_exp,')');
    end
    

end

%% Remove the extra variable string after the function
vect.format_in=strrep(vect.format_in,variable_string,'');

%% Square root function
vect.format_in=strrep(vect.format_in,'?(','sqrt(');

%% Basic switches
     vect.format_in=strrep(vect.format_in,'+-','-');
     vect.format_in=strrep(vect.format_in,')(',')*(');
     vect.format_in=strrep(vect.format_in,'ln(','log(');
     vect.format_in=strrep(vect.format_in,'arcsin(','asin(');
     vect.format_in=strrep(vect.format_in,'arccos(','acos(');
     vect.format_in=strrep(vect.format_in,'arctan(','atan(');
     vect.format_in=strrep(vect.format_in,'arccsc(','acsc(');
     vect.format_in=strrep(vect.format_in,'arcsec(','asec(');
     vect.format_in=strrep(vect.format_in,'arccot(','acot(');

 %% Exponential functions
 if contains(vect.format_in,'e^(') 
     
     vect.format_in=strrep(vect.format_in,'e^(','exp(');
 
 elseif contains(vect.raw_in,'e^x')
     vect.format_in=strrep(vect.format_in,'e^x','exp(x)');
     
 elseif contains(vect.raw_in,'e^y')
     vect.format_in=strrep(vect.format_in,'e^y','exp(y)');
     
elseif contains(vect.raw_in,'e^z')
    vect.format_in=strrep(vect.format_in,'e^z','exp(z)');
 end

%% xyz operations

vect.format_in=strrep(vect.format_in,'xy','x*y');
vect.format_in=strrep(vect.format_in,'xz','x*z');
vect.format_in=strrep(vect.format_in,'yz','y*z');

vect.format_in=strrep(vect.format_in,'x/y','x/y');
vect.format_in=strrep(vect.format_in,'y/z','y/z');
vect.format_in=strrep(vect.format_in,'x/z','x/z');

 %% Absolute value change

if contains(vect.raw_in,'|')
    abs_split=strsplit(vect.format_in,'|');
    abs_in=strcat('abs(',abs_split{2},')');
    vect.format_in=strcat(abs_split{1},abs_in,abs_split{3});

end



end

