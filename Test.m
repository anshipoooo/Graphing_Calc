clc;
clear all
close all



old_str='|x+2|';
index=strfind(old_str,'|');
first=index(1);
new_str=old_str;

final_str=strrep(old_str(:,first),'|','abs(');
    % new_str=[new_str(1:first-1),'abs(',new_str(first +length(old_str):end)];




