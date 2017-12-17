function ranges()

global gvar

if gvar.set_points=='y'
    gvar.xMin_In=input('Declare x min: ','s');
    gvar.xMax_In=input('Declare x max: ','s');
    gvar.xMin=str2num(gvar.xMin_In);
    gvar.xMax=str2num(gvar.xMax_In);
    gvar.xDist=0.0001;
    gvar.yMin_In=input('Declare y min: ','s');
    gvar.yMax_In=input('Declare y max: ','s');
    gvar.yMin=str2num(gvar.yMin_In);
    gvar.yMax=str2num(gvar.yMax_In);
elseif gvar.set_points=='n'
    gvar.xMin=-10;
    gvar.xMax=10;
    gvar.xDist=0.0001;
    gvar.yMin=-10;
    gvar.yMax=10;
end