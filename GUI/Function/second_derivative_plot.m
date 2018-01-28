function second_derivative_plot()
global gvar
gvar.graph(3)=plot(gvar.real_orig_x(1,1:length(gvar.real_sec)-1),gvar.real_sec(1,1:length(gvar.real_sec)-1),'m');
%% Holes f''(x)
for hole_second=2:length(gvar.true_deriv2)-2
    if isnan(gvar.true_deriv2(:,hole_second)) && ~isnan(gvar.true_deriv2...
            (:,hole_second-1)) && ~isnan(gvar.true_deriv2(:,hole_second+1))
        gvar.true_deriv2(:,hole_second)=gvar.true_deriv2(:,hole_second-1);
        gvar.graph(3)=scatter(real_orig_x(:,hole_second),gvar.true_deriv2(:,hole_second),'o','m');
    end
end

end

