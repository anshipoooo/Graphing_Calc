

function y= myf(x)
    % in=input('Enter equation in terms of x: ','s');

    %
    % in=strrep(in,div,'./');
    % in=strrep(in,exp,'.^');
    % in=strrep(in,mult,'.*');
    % new_func=str2func(in);
    %
    % f=@(x) new_func;
    % y=f(x);

    %% Instructions

    raw_in=input('Enter equation in terms of x: ','s');

    format_in=strrep(raw_in,'*','.*');
    format_in=strrep(format_in,'e^','exp');
    format_in=strrep(format_in,'^','.^');
    format_in=strrep(format_in,'/','./');
    format_in=strrep(format_in,'+-','-');
    format_in=strrep(format_in,'+(','-(');






    % f=@(x) new_in
    y=eval(format_in);

end
