function POI()
global gvar
%% POI
min_threshold=-0.000001;
max_threshold=0.000001;


for poi_loc=2:length(gvar.real_sec)-1
    if gvar.real_sec(:,poi_loc-1)<0 && gvar.real_sec(:,poi_loc+1)>0
        hold on
        scatter(gvar.real_orig_x(:,poi_loc),gvar.real_orig_y(:,poi_loc),'s','b');
    elseif gvar.real_sec(:,poi_loc-1)>0 && gvar.real_sec(:,poi_loc+1)<0
        scatter(gvar.real_orig_x(:,poi_loc),gvar.real_orig_y(:,poi_loc),'s','b');

    end
end