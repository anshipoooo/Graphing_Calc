function POI()
global gvar
%% POI

loc=zeros(1,length(gvar.real_sec)-1);
for i=2:length(gvar.real_sec)-1
    if gvar.real_sec(:,i-1)>0 && gvar.real_sec(:,i+1)<0
        
        loc(:,i)=i;
    elseif gvar.real_sec(:,i-1)<0 && gvar.real_sec(:,i+1)>0
        loc(:,i)=i;
        
        
    end
end

loc(loc==0)=[];

POI_x_matr=zeros(1,length(loc));
POI_y_matr=zeros(1,length(loc));

for g=1:length(loc)
    POI_x_matr(:,g)=round(gvar.real_orig_x(loc(:,g)),2);
    POI_y_matr(:,g)=round(gvar.real_orig_y(loc(:,g)),2);
end


gvar.POI_final_x=POI_x_matr;
gvar.POI_final_y=POI_y_matr;
new_location=length(gvar.POI_final_x)-1;
for i=new_location:-1:1
    if  -0.02<POI_x_matr(:,i)-POI_x_matr(:,i+1)<0.02
        gvar.POI_final_x(i)=[];
        gvar.POI_final_y(i)=[];
    end
end

gvar.POI_x=cell(1,length(gvar.POI_final_x));
gvar.POI_y=cell(1,length(gvar.POI_final_y));
gvar.POI_str=cell(1,length(gvar.POI_final_x));
for i=1:length(gvar.POI_final_x)
    
    gvar.POI_x{1,i}=num2str(gvar.POI_final_x(:,i));
    gvar.POI_y{1,i}=num2str(gvar.POI_final_y(:,i));
    gvar.POI_str{1,i}=strcat('(',gvar.POI_x{1,i},',',gvar.POI_y{1,i},')');
    
end
gvar.POI_str{1,length(gvar.POI_str)-1}=gvar.POI_str{1,length(gvar.POI_str)};
gvar.POI_str{1,length(gvar.POI_str)}=[];
end



