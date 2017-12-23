function relMinMax()

global gvar
%% Relative min/max
for rel_min=2:length(gvar.real_sec)-1
    if gvar.real_first(:,rel_min-1)>0 && gvar.real_first(:,rel_min+1)<0
        hold on
        graph(4)=scatter(gvar.real_orig_x(:,rel_min),gvar.real_orig_y(:,rel_min),'d','b');
    elseif gvar.real_first(:,rel_min-1)<0 && gvar.real_first(:,rel_min+1)>0
        hold on
        graph(4)=scatter(gvar.real_orig_x(:,rel_min),gvar.real_orig_y(:,rel_min),'d','b');
    end
end