clc;
close all
clear all




enter_range=input('Would you like to input your own range? (y/n) ','s');

if enter_range=='y'
    xMin_In=input('Declare x min: ','s');
    xMax_In=input('Declare x max: ','s');
    xMin=str2num(xMin_In);
    xMax=str2num(xMax_In);
    xDist=0.001;
    yMin_In=input('Declare y min: ','s');
    yMax_In=input('Declare y max: ','s');
    yMin=str2num(yMin_In);
    yMax=str2num(yMax_In);
elseif enter_range=='n'
    xMin=-10;
    xMax=10;
    yMin=-10;
    yMax=10;
    xDist=0.001;
end

x=xMin:xDist:xMax;

str_deriv=input('How many derivatives to calculate? ','s');
num_deriv=str2num(str_deriv);


x_length=length(x);

deriv_matr=zeros(num_deriv,x_length);

    raw_in=input('Enter equation in terms of x: ','s');
    format_in=strrep(raw_in,'*','.*');
    format_in=strrep(format_in,'e^','exp');
    format_in=strrep(format_in,'^','.^');
    format_in=strrep(format_in,'/','./');
    format_in=strrep(format_in,'+-','-');
    format_in=strrep(format_in,'+(','-(');
    deriv_matr(1,:)=eval(format_in);


if num_deriv>0
    for degree_loop=2:num_deriv
        for point_loop=2:length(x)
            deriv_matr(degree_loop,point_loop)=deriv_matr(degree_loop-1,point_loop)-deriv_matr(degree_loop-1,point_loop-1);
        end
    end
end