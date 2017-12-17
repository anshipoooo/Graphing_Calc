function FTC()
global gvar

if gvar.trial_number==1
gvar.ftc_input=input('Would you like to calculate the FTC? (y/n): ','s');
end

threshold=10^-6;

%% FTC Calculations
    if gvar.ftc_input=='y'

    low_bound_str=input('Input the lower bound of the integral: ','s');
    up_bound_str=input('Input the upper bound of the integral: ','s');
    gvar.low_bound=str2num(low_bound_str);
    clc;
    gvar.up_bound=str2num(up_bound_str);

    gvar.low_bound=round(gvar.low_bound,3);
    gvar.up_bound=round(gvar.up_bound,3);

    gvar.loc_lower=find(abs(gvar.real_orig_x-gvar.low_bound)<threshold);
    gvar.loc_up=find(abs(gvar.real_orig_x-gvar.up_bound)<threshold);

gvar.new_range=zeros(1,length(gvar.loc_lower:1:gvar.loc_up));
for new_loop=gvar.loc_lower:gvar.loc_up
    gvar.new_range(1,new_loop)=gvar.real_first(new_loop);
end

gvar.mult_ftc=zeros(1,length(gvar.new_range)-1);

for loop=1:length(gvar.new_range)-1
    gvar.mult_ftc(loop)=gvar.xDist*gvar.new_range(loop);
end
gvar.area_under=sum(gvar.mult_ftc)+gvar.xDist;
gvar.rnd_area=round(gvar.area_under,3);
final_value=gvar.rnd_area-gvar.xDist;

% FTC_area();

clc;
fprintf('\n Area under f''(x) is: ');
fprintf('%.3f',final_value);
fprintf('\n');

end