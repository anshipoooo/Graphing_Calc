
clc;
close all
clear all



aH = axes;
 lH(1) = plot(aH,rand(10,1),'bs');
 hold on
 lH(2) = plot(aH,rand(10,1),'ro');
 lH(3) = plot(aH,rand(10,1),'k+');
 lH(4) = plot(aH,rand(10,1),'g^'); % some lines
 set(lH,'hittest','off'); % so you can click on the Markers
 hold on; 
 set(aH,'ButtonDownFcn',@getCoord); % Defining what happens when clicking
 uiwait(f) %so multiple clicks can be used






