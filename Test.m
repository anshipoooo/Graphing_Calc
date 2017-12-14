%% NEED TO CONVERT TO SCREEN FOR BETTER GUI AND LIVE REFRESH

clc
clear all
close all

%% Load Screen
Screen('Preference', 'SkipSyncTests', 1);


RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

[window, rect] = Screen('OpenWindow', 0); 
HideCursor();

window_w = rect(3); 
window_h = rect(4);


%% X and Y dimensions
dimen_x = window_w/2;
dimen_y = window_h/2;


% while true


% Graph_Calc()

% movegui(gvar.graph,'center');
Screen('DrawText',window,'Press any key to continue',dimen_x-250,dimen_y);
Screen('Flip',window);
pause;

% while true
% try
% orig_input=input('Enter equation','s');
% Screen('DrawText',window,['Enter your equation in terms of x: ' orig_input],dimen_x-250,dimen_y);
% Screen('Flip',window);
% y=eval(orig_input);
% catch
% WaitSecs(0.000000001);
% end
% end

KbName('UnifyKeyNames');
key_delete=KbName('delete');
key_return=KbName('return');

g=1;
while true
w=waitforbuttonpress;
if w
p(:,g)=get(gcf,'CurrentCharacter');

[keyIsDown,timeSecs,keyCode] = KbCheck();
while ~keyCode(key_return)
    [keyIsDown,timeSecs,keyCode] = KbCheck();
end

if keyCode(key_return)==1
    break
end

if keyCode(key_delete)==1
    p(:,g)=[];
    g=g-1;
end
Screen('DrawText',window,['Enter your equation in terms of x: ' p],dimen_x-250,dimen_y);
Screen('Flip',window);


g=g+1
try
y=eval(p)
catch
WaitSecs(0.0000001);
end
end
end


%% Close screen
Screen('CloseAll');


% end

