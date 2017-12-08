function deriv1();







global gvar;

%% Calculate 1st Derivative
    gvar.deriv1_y=zeros(1,length(gvar.real_orig_x));
  for orig1_name = 1:length(gvar.real_orig_x)-1
        gvar.deriv1_y(:,orig1_name)=((gvar.real_orig_y(:,orig1_name+1))-(gvar.real_orig_y(:,orig1_name)));
  end

%% Find f'(x) reals
gvar.true_deriv1=gvar.deriv1_y/gvar.xDist;
gvar.num_first=(gvar.true_deriv1==real(gvar.true_deriv1));
gvar.real_first=gvar.true_deriv1(gvar.num_first);


%% Find asymptotes
 for deriv_name = 2:length(gvar.real_first)
                if gvar.real_first(:,deriv_name-1)-gvar.real_first(:,deriv_name)>gvar.yMax
                    gvar.real_first(:,deriv_name)=NaN;
                elseif gvar.real_first(:,deriv_name-1)-gvar.real_first(:,deriv_name)<gvar.yMin
                  gvar.real_first(:,deriv_name)=NaN;
                end
            end

            if gvar.deriv1_q == 'y'
%% Plot original graph and 1st derivative
            % real_num=zeros(1,length(num_y));
            % for real_first_plot=1:length(real_orig_y)
            %     real_num(:,real_first_plot)=num_y(:,real_first_plot);
            % end
                grid on
                hold on
                gvar.graph(1)=plot(gvar.aH,gvar.real_orig_x,gvar.real_orig_y,'b');
                hold on
                gvar.graph(2)=plot(gvar.aH,gvar.real_orig_x(:,1:length(gvar.real_first)-1),gvar.real_first(:,1:length(gvar.real_first)-1),'g');
                hold on

%% Holes f(x)
            for hole_orig=2:length(gvar.real_first)-1
                if isnan(gvar.real_orig_y(:,hole_orig))
                    gvar.graph(2)=scatter(gvar.real_orig_x(:,hole_orig),gvar.real_first(:,hole_orig),'o','g');
                    hold on
                elseif isnan(gvar.real_orig_y(:,hole_orig)) && ~isnan(gvar.real_orig_y(:,hole_orig-1)) && ...
                        ~isnan(gvar.real_orig_y(:,hole_orig+1))
                    gvar.real_orig_y(:,hole_orig)=gvar.real_orig_y(:,hole_orig-1);
                    hold on
                    gvar.graph(1)=scatter(gvar.real_orig_x(:,hole_orig),gvar.real_orig_y(:,hole_orig),'o','b');
                end

            end
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
            disp('Original Function in blue');
            disp('1st Derivative in green');
%% No 1st derivative function
        elseif gvar.deriv1_q =='n'
                gvar.graph(1)=plot(gvar.aH,gvar.real_orig_x,gvar.real_orig_y,'b');
                hold on


%% Holes f(x)
            for hole_orig=2:length(gvar.real_orig_y)-1
                if isnan(gvar.real_orig_y(:,hole_orig)) && ~isnan(gvar.real_orig_y(:,hole_orig-1)) && ...
                        ~isnan(gvar.real_orig_y(:,hole_orig+1))
                    gvar.real_orig_y(:,hole_orig)=gvar.real_orig_y(:,hole_orig-1);
                    hold on
                    gvar.graph(1)=scatter(gvar.real_orig_x(:,hole_orig),gvar.real_orig_y(:,hole_orig),'o','b');
                end
            end
            disp('Original Function in blue');
    end