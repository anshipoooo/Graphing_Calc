function second_derivative()
global gvar
%% Calculate 2nd derivative (d/dx (f'(x))
    deriv2_y=zeros(1,length(gvar.real_first));
    for orig2_name = 1:length(gvar.real_first)-1
        deriv2_y(:,orig2_name)=((gvar.real_first(:,orig2_name+1))-(...
            gvar.real_first(:,orig2_name)));
    end

    
    %% Find reals for second derivative
gvar.true_deriv2=deriv2_y/gvar.xDist;
num_sec=(gvar.true_deriv2==real(gvar.true_deriv2));
gvar.real_sec=gvar.true_deriv2(num_sec);
gvar.real_sec_x=gvar.real_orig_x(num_sec);

%% Set f''(x) asymptotes
    for deriv_name = 2:length(gvar.real_sec)
            if gvar.real_sec(:,deriv_name-1)-gvar.real_sec(:,deriv_name)>gvar.rangeUpper
                    gvar.real_sec(:,deriv_name)=NaN;
            elseif gvar.real_sec(:,deriv_name-1)-gvar.real_sec(:,deriv_name)<gvar.rangeLower
                  gvar.real_sec(:,deriv_name)=NaN;
            end
    end
    
    
    
    