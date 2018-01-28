function holes()

global c

% for i=2:length(gvar.real_sec)-1
% 
%    if ~isnan(gvar.real_orig_y(:,i-1)) && isnan(gvar.real_orig_y(:,i)) ...
%            && isnan(gvar.real_orig_y(:,i))
%       scatter(gvar.real_orig_x(:,i),gvar.real_orig_y(:,i),'c','b'); 
%        
%        
%    end
%     
% end
x=-10:0.01:10;
c.raw_in='((x.^2)+(2*x)+1)/(x+1)';
c.y=eval(c.raw_in);
if contains(c.raw_in,'/')

    c.divSplit=strsplit(c.raw_in,'/');
    c.denom=eval(c.divSplit{2});
    
    for i=1:length(c.denom)
        if c.denom(1,i)==0
            c.x(:,i)=NaN;
            c.y(:,i)=NaN;
        end
    end
    


end






end

