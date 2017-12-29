function equation_parser_three()

global funcParse3

%% Convert user input into function --> previously Graphing_Calc
% gvar.raw_in=input('Enter your function in terms of x: ','s');    
%% Implicit multiplication

    funcParse3.format_in=strcat(funcParse3.raw_in,'+1-1');
TF=isstrprop(funcParse3.format_in,'digit');
LF=isstrprop(funcParse3.format_in,'alpha');
for implicit_loop=1:length(TF)-1
    TF=isstrprop(funcParse3.format_in,'digit');
    if TF(1,implicit_loop)==1 && funcParse3.format_in(:,implicit_loop+1)=='x'
        funcParse3.implicit_before_dig=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_dig=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_dig,'.*',funcParse3.implicit_after_dig);
    end
    LF=isstrprop(funcParse3.format_in,'alpha');
    if funcParse3.format_in(:,implicit_loop)=='x' && LF(:,implicit_loop+1)==1
        funcParse3.implicit_before_alpha=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_alpha=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_alpha,'.*',funcParse3.implicit_after_alpha);
    end
    if funcParse3.format_in(:,implicit_loop)=='y' && LF(:,implicit_loop+1)==1
        funcParse3.implicit_before_alpha=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_alpha=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_alpha,'.*',funcParse3.implicit_after_alpha);
    end
    if funcParse3.format_in(:,implicit_loop)=='^' && LF(:,implicit_loop+1)==1
        funcParse3.implicit_before_exp=extractBefore(funcParse3.format_in,implicit_loop+1);
        funcParse3.implicit_after_exp=extractAfter(funcParse3.format_in,implicit_loop);
        funcParse3.format_in=strcat(funcParse3.implicit_before_exp,'(',funcParse3.implicit_after_exp,')');
    end
    

end
funcParse3.format_in=strrep(funcParse3.format_in,'+1-1','');

%% Square root function
funcParse3.format_in=strrep(funcParse3.format_in,'?(','sqrt(');

%% Basic switches
     
     funcParse3.format_in=strrep(funcParse3.format_in,'/','./');
%      gvar.format_in=strrep(gvar.format_in,'*','.*');
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

