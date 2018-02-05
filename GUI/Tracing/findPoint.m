function findPoint()

global gvar

TF=isstrprop(gvar.dispInput,'digit');
LF=isstrprop(gvar.dispInput,'alpha');

gvar.dispInput=strrep(gvar.dispInput,'pi','3.141');

for implicit_loop=1:length(TF)-1
    TF=isstrprop(dispInput,'digit');
    if TF(1,implicit_loop)==1 && LF(:,implicit_loop+1)==1
        implicit_before_dig=extractBefore(gvar.dispInput,implicit_loop+1);
        implicit_after_dig=extractAfter(gvar.dispInput,implicit_loop);
        gvar.dispInput=strcat(implicit_before_dig,'*',implicit_after_dig);
    end
    
    

end


end

