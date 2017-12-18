function deriv1()


global gvar;

if gvar.trial_number==1
disp('1st derivative? (y/n)');
end

[gvar.deriv1_keyIsDown,gvar.deriv1_timeSecs,gvar.deriv1_keyCode] = KbCheck();
    while ~gvar.deriv1_keyCode(gvar.keyYes) && ~gvar.deriv1_keyCode(gvar.keyNo)
        [gvar.deriv1_keyIsDown,gvar.deriv1_timeSecs,gvar.deriv1_keyCode] = KbCheck();
    end

WaitSecs(0.5);
clc;

if gvar.trial_number==1
disp('2nd derivative? (y/n)');
end
[gvar.deriv2_keyIsDown,gvar.deriv2_timeSecs,gvar.deriv2_keyCode] = KbCheck();
    while ~gvar.deriv2_keyCode(gvar.keyYes) && ~gvar.deriv2_keyCode(gvar.keyNo)
        [gvar.deriv2_keyIsDown,gvar.deriv2_timeSecs,gvar.deriv2_keyCode] = KbCheck();
    end
clc;
gvar.aH=axes;
screen_size=get(0,'ScreenSize');
set(gvar.aH,'Position',[0.05 0.05 0.9 0.9]);

%% Find f(x) asymptotes
for orig_asym_loop=2:length(gvar.real_orig_y)
    if gvar.real_orig_y(:,orig_asym_loop-1)-gvar.real_orig_y(:,orig_asym_loop)>gvar.yMax
        gvar.real_orig_y(:,orig_asym_loop)=NaN;
    elseif gvar.real_orig_y(:,orig_asym_loop-1)-gvar.real_orig_y(:,orig_asym_loop)<gvar.yMin
        gvar.real_orig_y(:,orig_asym_loop)=NaN;
    end
end


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
    if gvar.real_first(:,deriv_name-1)-gvar.real_first(:,deriv_name)>gvar.yMax
        gvar.real_first(:,deriv_name)=NaN;
    elseif gvar.real_first(:,deriv_name-1)-gvar.real_first(:,deriv_name)<gvar.yMin
        gvar.real_first(:,deriv_name)=NaN;
    end
end

grid on
hold on
set(gvar.aH,'FontName','Californian FB');

            if gvar.deriv1_keyCode(gvar.keyYes)==1
%% Plot original graph and 1st derivative
            % real_num=zeros(1,length(num_y));
            % for real_first_plot=1:length(real_orig_y)
            %     real_num(:,real_first_plot)=num_y(:,real_first_plot);
            % end

                
                % set(0,'DefaultFigureVisible','off');



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
        elseif gvar.deriv1_keyCode(gvar.keyNo)==1



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
        if  gvar.deriv2_keyCode(gvar.keyYes)==1
            hold on

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
        elseif gvar.deriv2_keyCode(gvar.keyNo)==1
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
            xlim([gvar.xMin gvar.xMax]);
            ylim([gvar.yMin gvar.yMax]);
            disp('Original Function in blue');
        end

