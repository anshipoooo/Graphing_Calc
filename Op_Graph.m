clc;
close all
clear all




enter_range=input('Would you like to input your own range? (y/n) ','s');

if enter_range=='y'
    xMin_In=input('Declare x min: ','s');
    xMax_In=input('Declare x max: ','s');
    xMin=str2num(xMin_In);
    xMax=str2num(xMax_In);
    xDist=0.01;
    yMin_In=input('Declare y min: ','s');
    yMax_In=input('Declare y max: ','s');
    yMin=str2num(yMin_In);
    yMax=str2num(yMax_In);
elseif enter_range=='n'
    xMin=-10;
    xMax=10;
    yMin=-10;
    yMax=10;
    xDist=0.00001;
end

x=xMin:xDist:xMax;

str_deriv=input('How many derivatives to calculate? ','s');
num_deriv=str2num(str_deriv);


x_length=length(x);

deriv_matr=zeros(num_deriv,x_length);
init_matr=zeros(num_deriv,x_length);

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
        for point_loop=1:length(x)-1
            deriv_matr(degree_loop,point_loop)=(deriv_matr(degree_loop-1,point_loop+1)-deriv_matr(degree_loop-1,point_loop))/xDist;
        end
    end
end




plot([xMin xMax],[0 0],'k');
hold on
plot([0 0],[yMin yMax],'k');

color_matr=['b' 'g' 'm' 'c' 'y' 'r'];

color_graph=randi([1 6],1,6);
for num_graph=1:num_deriv
    plot(x,deriv_matr(num_graph,:),color_matr(num_graph));
end

xlim([xMin xMax]);
ylim([yMin yMax]);
axis([xMin xMax yMin yMax]);