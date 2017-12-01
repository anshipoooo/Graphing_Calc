function deriv(x,y)

xDist=0.01
deriv1_q = 'y';
aH=axes;

%%Real numbers
num_y=(y==real(y));
real_orig_y=y(num_y);
real_orig_x=x(num_y);

%% Calculate 1st Derivative
    deriv1_y=zeros(1,length(real_orig_x));
  for orig1_name = 1:length(real_orig_x)-1
        deriv1_y(:,orig1_name)=((real_orig_y(:,orig1_name+1))-(real_orig_y(:,orig1_name)));
  end
true_deriv1=deriv1_y/xDist;
num_first=(true_deriv1==real(true_deriv1));
real_first=true_deriv1(num_first);
real_first_x=x(num_first);


%% Find asymptotes
 for deriv_name = 2:length(real_first)
                if real_first(:,deriv_name-1)-real_first(:,deriv_name)>1
                    real_first(:,deriv_name)=NaN;
                elseif real_first(:,deriv_name-1)-real_first(:,deriv_name)<-1
                  real_first(:,deriv_name)=NaN;
                end
            end

            if deriv1_q == 'y'
%% Plot original graph and 1st derivative
            real_num=zeros(1,length(num_y));
            for real_first_plot=1:length(real_orig_y)
                real_num(:,real_first_plot)=num_y(:,real_first_plot);
            end
                grid on
                hold on
                graph(1)=plot(aH,real_orig_x,real_orig_y,'b');
                hold on
                graph(2)=plot(aH,real_orig_x(:,1:length(real_first)-1),real_first(:,1:length(real_first)-1),'g');
                hold on

%% Holes f(x)
            for hole_orig=2:length(real_first)-1
                if isnan(y(:,hole_orig))
                    graph(2)=scatter(real_orig_x(:,hole_orig),real_first(:,hole_orig),'o','g');
                    hold on
                    graph(3)=scatter(real_orig_x(:,hole_orig),real_sec(:,hole_orig),'o','m');
                    hold on
                elseif isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    graph(1)=scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end

            end
%% Holes f'(x)
            for hole_first=2:length(true_deriv1)-1
                if isnan(true_deriv1(:,hole_first)) && ~isnan(true_deriv1...
                        (:,hole_first-1)) && ~isnan(true_deriv1(:,hole_first +1))
                    true_deriv1(:,hole_first)=true_deriv1(:,hole_first-1);
                    hold on
                    graph(2)=scatter(real_orig_x(:,hole_first),true_deriv1(:,hole_first),'o','g');
                end
            end
            hold on
            disp('Original Function in blue');
            disp('1st Derivative in green');
%% No 1st derivative function
        elseif deriv1_q =='n'
                graph(1)=plot(aH,real_orig_x,real_orig_y,'b');
                hold on


%% Holes f(x)
            for hole_orig=2:length(y)-1
                if isnan(y(:,hole_orig)) && ~isnan(y(:,hole_orig-1)) && ...
                        ~isnan(y(:,hole_orig+1))
                    y(:,hole_orig)=y(:,hole_orig-1);
                    hold on
                    graph(1)=scatter(real_orig_x(:,hole_orig),y(:,hole_orig),'o','b');
                end
            end
            disp('Original Function in blue');
    end