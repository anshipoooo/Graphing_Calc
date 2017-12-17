% function equation_parser

global gvar

%% Convert user input into function --> previously Graphing_Calc
    gvar.raw_in=input('Enter equation in terms of x: ','s');
    
%% Implicit multiplication

    gvar.format_in=strcat(gvar.raw_in,'+1-1');
TF=isstrprop(gvar.format_in,'digit');
LF=isstrprop(gvar.format_in,'alpha');
for implicit_loop=1:length(TF)-1
    TF=isstrprop(gvar.format_in,'digit');
    if TF(1,implicit_loop)==1 && gvar.format_in(:,implicit_loop+1)=='x'
    implicit_before_dig=extractBefore(gvar.format_in,implicit_loop+1);
    implicit_after_dig=extractAfter(gvar.format_in,implicit_loop);
    gvar.format_in=strcat(implicit_before_dig,'.*',implicit_after_dig);
    end
    LF=isstrprop(gvar.format_in,'alpha');
    if gvar.format_in(:,implicit_loop)=='x' && LF(:,implicit_loop+1)==1
    implicit_before_alpha=extractBefore(gvar.format_in,implicit_loop+1);
    implicit_after_alpha=extractAfter(gvar.format_in,implicit_loop);
    gvar.format_in=strcat(implicit_before_alpha,'.*',implicit_after_alpha);
    end

end
gvar.format_in=strrep(gvar.format_in,'+1-1','');


 
     if ~contains(gvar.raw_in,'e^')
     gvar.format_in=strrep(gvar.format_in,'^','.^');
     end
     gvar.format_in=strrep(gvar.format_in,'/','./');
     gvar.format_in=strrep(gvar.format_in,'+-','-');
     gvar.format_in=strrep(gvar.format_in,')(',').*(');

 %% Exponential functions
 if contains(gvar.raw_in,'e^(')
%      exp_split=strsplit(gvar.format_in,'e^')
%      exp_in=strcat('exp(',exp_split{2},')')
%      gvar.format_in=strcat(exp_split{1},exp_in,exp_split{2});
     
     gvar.format_in=strrep(gvar.format_in,'e^(','exp(');
 end
 
 if contains(gvar.raw_in,'e^x')
     gvar.format_in=strrep(gvar.format_in,'e^x','exp(x)');
 end

 %% Absolute value change

if contains(gvar.raw_in,'|')
    abs_split=strsplit(gvar.format_in,'|');
    abs_in=strcat('abs(',abs_split{2},')');
    gvar.format_in=strcat(abs_split{1},abs_in,abs_split{3});
end

