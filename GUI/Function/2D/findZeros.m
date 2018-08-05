function findZeros()
global gvar

loc=zeros(1,length(gvar.real_sec)-1);
for i=2:length(gvar.real_sec)-1
    if gvar.real_orig_y(:,i-1)>0 && gvar.real_orig_y(:,i+1)<0
        
        loc(:,i)=i;
    elseif gvar.real_orig_y(:,i-1)<0 && gvar.real_orig_y(:,i+1)>0
        loc(:,i)=i;
        
        
    end
end

loc(loc==0)=[];

zeros_x_matr=zeros(1,length(loc));
zeros_y_matr=zeros(1,length(loc));

for g=1:length(loc)
    zeros_x_matr(:,g)=round(gvar.real_orig_x(loc(:,g)),2);
    zeros_y_matr(:,g)=round(gvar.real_orig_y(loc(:,g)),2);
end


gvar.zeros_final_x=zeros_x_matr;
gvar.zeros_final_y=zeros_y_matr;
new_location=length(gvar.zeros_final_x)-1;
for i=new_location:-1:1
    if -0.02<zeros_x_matr(:,i)-zeros_x_matr(:,i+1)<0.02
        gvar.zeros_final_x(i)=[];
        gvar.zeros_final_y(i)=[];
%     elseif zeros_x_matr(:,i)==zeros_x_matr(:,i+1)
%         gvar.zeros_final_x(i)=[];
%         gvar.zeros_final_y(i)=[];
    end
    
end
gvar.zeros_x=cell(1,length(gvar.zeros_final_x));
gvar.zeros_y=cell(1,length(gvar.zeros_final_y));
gvar.zeros_str=cell(1,length(gvar.zeros_final_x));
for i=1:length(gvar.zeros_final_x)
    
    gvar.zeros_x{1,i}=num2str(gvar.zeros_final_x(:,i));
    gvar.zeros_y{1,i}=num2str(gvar.zeros_final_y(:,i));
    gvar.zeros_str{1,i}=strcat('(',gvar.zeros_x{1,i},',',gvar.zeros_y{1,i},')');
    
end


    if length(gvar.zeros_str)>1
        gvar.zeros_str{1,length(gvar.zeros_str)-1}=gvar.zeros_str{1,length(gvar.zeros_str)};
        gvar.zeros_str{1,length(gvar.zeros_str)}=[];
    end

end


