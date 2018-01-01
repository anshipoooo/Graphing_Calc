function FTC_Parser_Up()

global gvar
raw_in=gvar.init_up_bound;
format_in=raw_in;

TF=isstrprop(raw_in,'digit');
LF=isstrprop(raw_in,'alpha');

for implicit_loop=1:length(TF)-1
    TF=isstrprop(format_in,'digit');
    if TF(1,implicit_loop)==1 && LF(:,implicit_loop+1)==1
        implicit_before_dig=extractBefore(format_in,implicit_loop+1);
        implicit_after_dig=extractAfter(format_in,implicit_loop);
        format_in=strcat(implicit_before_dig,'*',implicit_after_dig);
    end
    
    

end

gvar.up_bound=str2num(format_in);





end

