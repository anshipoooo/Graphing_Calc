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

 %% Holes f(x)
% for hole_orig=2:length(gvar.real_orig_x)-1
% if isnan(gvar.real_orig_y(:,hole_orig))
% %     gvar.graph(2)=scatter(gvar.real_orig_x(:,hole_orig),gvar.real_first(:,hole_orig),'o','g');
% 
% 
% %     fprintf('\n Hole at(');
% %     fprintf('%.3f',gvar.real_orig_x(:,hole_orig));
% %     fprintf(',');
% % 
% %     fprintf('%.3f',gvar.real_first(:,hole_orig));
% %     fprintf(')\n');
% 
%     hold on
% elseif isnan(gvar.real_orig_y(:,hole_orig)) && ~isnan(gvar.real_orig_y(:,hole_orig-1)) && ...
%         ~isnan(gvar.real_orig_y(:,hole_orig+1))
% %         fprintf('\n Hole at(');
% %     fprintf('%.3f',gvar.real_orig_x(:,hole_orig));
% %     fprintf(',');
% % 
% %     fprintf('%.3f',gvar.real_orig_y(:,hole_orig));
% %     fprintf(')\n');
%     gvar.real_orig_y(:,hole_orig)=gvar.real_orig_y(:,hole_orig-1);
% 
%     hold on
%     gvar.graph(1)=scatter(gvar.real_orig_x(:,hole_orig),gvar.real_orig_y(:,hole_orig),'o','b');
% end 

end

