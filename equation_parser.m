% function equation_parser

global gvar

%% Convert user input into function --> previously Graphing_Calc
    raw_in=input('Enter equation in terms of x: ','s');
%     gvar.format_in=strrep(raw_in,'*','.*');

%     if ~contains(raw_in,'e^')
%     gvar.format_in=strrep(gvar.format_in,'^','.^');
%     end
%     gvar.format_in=strrep(gvar.format_in,'/','./');
%     gvar.format_in=strrep(gvar.format_in,'+-','-');


% %% Exponential functions
% if contains(raw_in,'e^')
%     exp_split=strsplit(gvar.format_in,'e^')
%     exp_in=strcat('exp(',exp_split{2},')')
%     gvar.format_in=strcat(exp_split{1},exp_in,exp_split{3});
% end

% %% Absolute value change

% if contains(raw_in,'|')
%     abs_split=strsplit(gvar.format_in,'|');
%     abs_in=strcat('abs(',abs_split{2},')');
%     gvar.format_in=strcat(abs_split{1},abs_in,abs_split{3});
% end

%% Implicit multiplication

TF=isstrprop(raw_in,'digit');

for implicit_loop=1:length(TF)-1;

    if TF(:,implicit_loop)==1 && raw_in(:,implicit_loop+1)=='x'
    implicit_before=extractBefore(raw_in,implicit_loop+1);
    implicit_after=extractAfter(raw_in,implicit_loop);
    new_in=strcat(implicit_before,'.*',implicit_after);
    end
end