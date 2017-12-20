function first_derivative()
global gvar
%% Calculate 1st Derivative
    gvar.deriv1_y=zeros(1,length(gvar.real_orig_x));
  for orig1_name = 1:length(gvar.real_orig_x)-1
        gvar.deriv1_y(:,orig1_name)=((gvar.real_orig_y(:,orig1_name+1))-(gvar.real_orig_y(:,orig1_name)));
  end
  
  

%% Find f'(x) reals
gvar.true_deriv1=gvar.deriv1_y/gvar.xDist;
gvar.num_first=(gvar.true_deriv1==real(gvar.true_deriv1));
gvar.real_first=gvar.true_deriv1(gvar.num_first);




%% Find f'(x) asymptotes
 for deriv_name = 2:length(gvar.real_first)
    if gvar.real_first(:,deriv_name-1)-gvar.real_first(:,deriv_name)>gvar.rangeUpper
        gvar.real_first(:,deriv_name)=NaN;
    elseif gvar.real_first(:,deriv_name-1)-gvar.real_first(:,deriv_name)<gvar.rangeLower
        gvar.real_first(:,deriv_name)=NaN;
    end
end

grid on
hold on

hold on


