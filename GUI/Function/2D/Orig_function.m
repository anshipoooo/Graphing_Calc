function Orig_function()

global gvar
%% Find f(x) asymptotes
for orig_asym_loop=2:length(gvar.real_orig_y)
    if gvar.real_orig_y(:,orig_asym_loop-1)-gvar.real_orig_y(:,orig_asym_loop)>gvar.rangeUpper
        gvar.real_orig_y(:,orig_asym_loop)=NaN;
    elseif gvar.real_orig_y(:,orig_asym_loop-1)-gvar.real_orig_y(:,orig_asym_loop)<gvar.rangeLower
        gvar.real_orig_y(:,orig_asym_loop)=NaN;
    end
end

gvar.graph(1)=plot(gvar.real_orig_x,gvar.real_orig_y,'b');
                hold on


end

