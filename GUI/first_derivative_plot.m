function first_derivative_plot()
global gvar
gvar.graph(2)=plot(gvar.real_orig_x(:,1:length(gvar.real_first)-1),gvar.real_first(:,1:length(gvar.real_first)-1),'g');
%% Holes f'(x)
for hole_first=2:length(gvar.true_deriv1)-1
    if isnan(gvar.true_deriv1(:,hole_first)) && ~isnan(gvar.true_deriv1...
            (:,hole_first-1)) && ~isnan(gvar.true_deriv1(:,hole_first +1))
        gvar.true_deriv1(:,hole_first)=gvar.true_deriv1(:,hole_first-1);
        hold on
        gvar.graph(2)=scatter(gvar.real_orig_x(:,hole_first),gvar.true_deriv1(:,hole_first),'o','g');
    end
end
hold on



end

