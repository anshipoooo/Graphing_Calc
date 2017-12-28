function equation_parser_two

global funcParse2

%% Convert user input into function --> previously Graphing_Calc
% gvar.raw_in=input('Enter your function in terms of x: ','s');    
%% Implicit multiplication

    funcParse2.format_in=strcat(funcParse2.raw_in,'+1-1');
TF=isstrprop(funcParse2.format_in,'digit');
LF=isstrprop(funcParse2.format_in,'alpha');
for implicit_loop=1:length(TF)-1
    TF=isstrprop(funcParse2.format_in,'digit');
    if TF(1,implicit_loop)==1 && funcParse2.format_in(:,implicit_loop+1)=='x'
        funcParse2.implicit_before_dig=extractBefore(funcParse2.format_in,implicit_loop+1);
        funcParse2.implicit_after_dig=extractAfter(funcParse2.format_in,implicit_loop);
        funcParse2.format_in=strcat(funcParse2.implicit_before_dig,'.*',funcParse2.implicit_after_dig);
    end
    LF=isstrprop(funcParse2.format_in,'alpha');
    if funcParse2.format_in(:,implicit_loop)=='x' && LF(:,implicit_loop+1)==1
        funcParse2.implicit_before_alpha=extractBefore(funcParse2.format_in,implicit_loop+1);
        funcParse2.implicit_after_alpha=extractAfter(funcParse2.format_in,implicit_loop);
        funcParse2.format_in=strcat(funcParse2.implicit_before_alpha,'.*',funcParse2.implicit_after_alpha);
    end
    if funcParse2.format_in(:,implicit_loop)=='^' && LF(:,implicit_loop+1)==1
        funcParse2.implicit_before_exp=extractBefore(funcParse2.format_in,implicit_loop+1);
        funcParse2.implicit_after_exp=extractAfter(funcParse2.format_in,implicit_loop);
        funcParse2.format_in=strcat(funcParse2.implicit_before_exp,'(',funcParse2.implicit_after_exp,')');
    end
    

end
funcParse2.format_in=strrep(funcParse2.format_in,'+1-1','');

%% Square root function
funcParse2.format_in=strrep(funcParse2.format_in,'?(','sqrt(');

%% Basic switches
     
     funcParse2.format_in=strrep(funcParse2.format_in,'/','./');
%      gvar.format_in=strrep(gvar.format_in,'*','.*');
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
 end



 %% Absolute value change

if contains(funcParse2.raw_in,'|')
    abs_split=strsplit(funcParse2.format_in,'|');
    abs_in=strcat('abs(',abs_split{2},')');
    funcParse2.format_in=strcat(abs_split{1},abs_in,abs_split{3});
end

