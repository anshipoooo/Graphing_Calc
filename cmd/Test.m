function deriv1()


global gvar;










%% Plot original graph and 1st derivative
            % real_num=zeros(1,length(num_y));
            % for real_first_plot=1:length(real_orig_y)
            %     real_num(:,real_first_plot)=num_y(:,real_first_plot);
            % end

                
                % set(0,'DefaultFigureVisible','off');



                
                


            disp('Original Function in blue');
            disp('1st Derivative in green');

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









    %% Plot 2nd derivative
      
            hold on

            plot([gvar.xMin gvar.xMax],[0 0],'k');
            hold on
            plot([0 0],[gvar.yMin gvar.yMax],'k');
            hold on

            
            hold on
            
            disp('2nd Derivative in magenta');
            grid on
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


