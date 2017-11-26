clc;
clear all
close all

a='5x+3+x';
b=regexp(a,'\d');


for test=1:length(b)
if isnumeric(str2num(a(b(test)))) && a(b(test)+1)=='x'
    g=strcat(a(b(test)),'*x');
    end
    end

disp(g);