clc;
clear all
close all


old_str='|x+2|';
open_index=strfind(old_str,'|');
open_abs=open_index(1);
new_str=old_str;
new_str=strrep(old_str(:,open_abs),'|','abs(');

close_index=strfind(new_str,'abs(');
close_abs=close_index(1);

new_str=strrep(new_str(:,close_abs),'abs(',')');
    % new_str=[new_str(1:first-1),'abs(',new_str(first +length(old_str):end)];


