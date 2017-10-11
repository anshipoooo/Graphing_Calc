

function y= myf(x)
    % in=input('Enter equation in terms of x: ','s');
    % div='/';
    % exp='^';
    % mult='*';
    %
    %
    % in=strrep(in,div,'./');
    % in=strrep(in,exp,'.^');
    % in=strrep(in,mult,'.*');
    % new_func=str2func(in);
    %
    % f=@(x) new_func;
    % y=f(x);

    %% Instructions




    f=@(x) input('Enter equation in terms of x: ');
    y=f(x);


end
