function deriv2()





hold on 
global gvar


if gvar.trial_number==1
gvar.deriv2_q=input('2nd derivative (y/n): ','s');
end


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
            if gvar.real_sec(:,deriv_name-1)-gvar.real_sec(:,deriv_name)>gvar.yMax
                    gvar.real_sec(:,deriv_name)=NaN;
            elseif gvar.real_sec(:,deriv_name-1)-gvar.real_sec(:,deriv_name)<gvar.yMin
                  gvar.real_sec(:,deriv_name)=NaN;
            end
    end

    %% Plot 2nd derivative
        if gvar.deriv2_q == 'y'
            hold on
            axis([gvar.xMin gvar.xMax gvar.yMin gvar.yMax]);
            plot([gvar.xMin gvar.xMax],[0 0],'k');
            hold on
            plot([0 0],[gvar.yMin gvar.yMax],'k');
            hold on

            gvar.graph(3)=plot(gvar.aH,gvar.real_orig_x(1,1:length(gvar.real_sec)-1),gvar.real_sec(1,1:length(gvar.real_sec)-1),'m');
            hold on
            
            disp('2nd Derivative in magenta');
            grid on
            hold on
%% Holes for f''(x)
            for hole_second=2:length(gvar.true_deriv2)-2
                if isnan(gvar.true_deriv2(:,hole_second)) && ~isnan(gvar.true_deriv2...
                        (:,hole_second-1)) && ~isnan(gvar.true_deriv2(:,hole_second+1))
                    gvar.true_deriv2(:,hole_second)=gvar.true_deriv2(:,hole_second-1);
                    gvar.graph(3)=scatter(real_orig_x(:,hole_second),gvar.true_deriv2(:,hole_second),'o','m');
                end
            end
        elseif gvar.deriv2_q == 'n'
            axis([gvar.xMin gvar.xMax gvar.yMin gvar.yMax]);
            plot([gvar.xMin gvar.xMax],[0 0],'k');
            hold on
            plot([0 0],[gvar.yMin gvar.yMax],'k');
            hold on

            gvar.graph(1)=plot(gvar.aH,gvar.real_orig_x,gvar.real_orig_y,'b');
            hold on

%% Holes f(x)
            for hole_orig=2:length(gvar.real_orig_y)-1
                if isnan(gvar.real_orig_y(:,hole_orig)) && ~isnan(gvar.real_orig_y(:,hole_orig-1)) && ...
                        ~isnan(gvar.real_orig_y(:,hole_orig+1))
                    gvar.real_orig_y(:,hole_orig)=gvar.real_orig_y(:,hole_orig-1);
                    hold on
                    graph(1)=scatter(real_orig_x(:,hole_orig),gvar.real_orig_y(:,hole_orig),'o','b');
                end
            end
            grid on
            hold on
            disp('Original Function in blue');
        end

