function relMinMax()
global gvar
%% Relative min/max



loc=ones(1,length(gvar.real_sec)-1);
for i=2:length(gvar.real_sec)-1
    if gvar.real_first(:,i-1)>0 && gvar.real_first(:,i+1)<0
        
        loc(:,i)=i;
    elseif gvar.real_first(:,i-1)<0 && gvar.real_first(:,i+1)>0
        loc(:,i)=i;
        
        
    end
end

loc(loc==1)=[];

RMM_x_matr=zeros(1,length(loc));
RMM_y_matr=zeros(1,length(loc));

for g=1:length(loc)
    RMM_x_matr(:,g)=round(gvar.real_orig_x(loc(:,g)),2);
    RMM_y_matr(:,g)=round(gvar.real_orig_y(loc(:,g)),2);
end


gvar.RMM_final_x=RMM_x_matr;
gvar.RMM_final_y=RMM_y_matr;
new_location=length(gvar.RMM_final_x)-1;
for i=new_location:-1:1
    if -0.02<RMM_x_matr(:,i)-RMM_x_matr(:,i+1)<0.02
        gvar.RMM_final_x(i)=[];
        gvar.RMM_final_y(i)=[];
    end


end
gvar.RMM_x=cell(1,length(gvar.RMM_final_x));
gvar.RMM_y=cell(1,length(gvar.RMM_final_y));
gvar.RMM_str=cell(1,length(gvar.RMM_final_x));
for i=1:length(gvar.RMM_final_x)
    
    gvar.RMM_x{1,i}=num2str(gvar.RMM_final_x(:,i));
    gvar.RMM_y{1,i}=num2str(gvar.RMM_final_y(:,i));
    gvar.RMM_str{1,i}=strcat('(',gvar.RMM_x{1,i},',',gvar.RMM_y{1,i},')');
    
end
if length(gvar.RMM_str)>1
    gvar.RMM_str{1,length(gvar.RMM_str)-1}=gvar.RMM_str{1,length(gvar.RMM_str)};
    gvar.RMM_str{1,length(gvar.RMM_str)}=[];
end
end


