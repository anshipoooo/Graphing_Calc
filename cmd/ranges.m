function ranges()

global gvar

disp('Would you like to enter your own range? (y/n)');
[gvar.ranges_keyIsDown,gvar.ranges_timeSecs,gvar.ranges_keyCode] = KbCheck();
    while ~gvar.ranges_keyCode(gvar.keyYes) && ~gvar.ranges_keyCode(gvar.keyNo)
        [gvar.ranges_keyIsDown,gvar.ranges_timeSecs,gvar.ranges_keyCode] = KbCheck();
    end
clc

if  gvar.ranges_keyCode(gvar.keyYes)==1
    gvar.xMin_In=input('Declare x min: ','s');
    gvar.xMax_In=input('Declare x max: ','s');
    gvar.xMin=str2num(gvar.xMin_In);
    gvar.xMax=str2num(gvar.xMax_In);
    gvar.xDist=0.0001;
    gvar.yMin_In=input('Declare y min: ','s');
    gvar.yMax_In=input('Declare y max: ','s');
    gvar.yMin=str2num(gvar.yMin_In);
    gvar.yMax=str2num(gvar.yMax_In);
elseif gvar.ranges_keyCode(gvar.keyNo)==1
    gvar.xMin=-10;
    gvar.xMax=10;
    gvar.xDist=0.0001;
    gvar.yMin=-10;
    gvar.yMax=10;
end