

function y= myf(x)
    in=input('Enter equation in terms of x: ','s');
    div='/';
    exp='^';
    mult='*';

    new_in=in;

      new_in=strrep(in,div,'./')

      new_in=strrep(in,exp,'.^');


      new_in=strrep(in,mult,'.*');

    new_func=str2func(new_in);

    f=@(x) new_func
    y=f(x);




end
