function FTC()
global gvar
%% FTC Calculations
    if gvar.ftc_input=='y'
        dx=0.00000001

    low_bound_str=input('Input the lower bound of the integral: ','s')
    up_bound_str=input('Input the upper bound of the integral: ','s');
    gvar.low_bound=str2num(low_bound_str);
    clc;
    gvar.up_bound=str2num(up_bound_str);

    gvar.loc_lower=find(gvar.real_orig_x==gvar.low_bound);
    gvar.loc_up=find(gvar.real_orig_x==gvar.up_bound);

gvar.new_range=zeros(length(gvar.loc_lower:1:gvar.loc_up),1);
for new_loop=gvar.loc_lower:gvar.loc_up
    gvar.new_range=gvar.real_first(new_loop);
end

gvar.mult_ftc=zeros(1,length(gvar.new_range)-1);

for loop=1:length(gvar.new_range)-1

gvar.mult_ftc(loop)=gvar.xDist*gvar.new_range(loop);
end
gvar.area_under=sum(gvar.mult_ftc)+dx;
gvar.rnd_area=round(gvar.area_under,3);
disp(gvar.rnd_area);
end