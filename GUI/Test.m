global gvar


loc=zeros(1,length(gvar.real_sec)-1);
for i=2:length(gvar.real_sec)-1
    if gvar.real_sec(:,i-1)>0 && gvar.real_sec(:,i+1)<0
        
        loc(:,i)=i;
        
        
    end
end

loc(loc==0)=[];
POI_x_matr=zeros(1,length(loc));
POI_y_matr=zeros(1,length(loc));
for g=1:length(loc)
    POI_x_matr(:,g)=gvar.real_orig_x(loc(:,g));
    POI_y_matr(:,g)=gvar.real_orig_y(loc(:,g));
end