function FTC()
global gvar

threshold=10^-6;

%% FTC Calculations

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
gvar.final_value=gvar.rnd_area-gvar.xDist;
gvar.final_value=num2str(round(gvar.final_value,3));

% FTC_area();

%% Proving FTC using f(x)

gvar.orig_area=gvar.real_orig_y(gvar.loc_up)-gvar.real_orig_y(gvar.loc_lower);
gvar.orig_area=num2str(round(gvar.orig_area,3));



