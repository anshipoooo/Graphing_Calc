function getCoord(aH,evnt)
drawnow
f = ancestor(aH,'figure');
click_type = get(f,'SelectionType');
ptH = getappdata(aH,'CurrentPoint');
delete(ptH)
if strcmp(click_type,'normal')
    %Finding the closest point and highlighting it
    lH = findobj(aH,'Type','line');
    minDist = realmax;
    finalIdx = NaN;
    finalH = NaN;
    pt = get(aH,'CurrentPoint'); %Getting click position
    for ii = lH'
        xp=get(ii,'Xdata'); %Getting coordinates of line object
        yp=get(ii,'Ydata');
        dx=daspect(aH);      %Aspect ratio is needed to compensate for uneven axis when calculating the distance
        [newDist idx] = min( ((pt(1,1)-xp).*dx(2)).^2 + ((pt(1,2)-yp).*dx(1)).^2 );
        if (newDist < minDist)
            finalH = ii;
            finalIdx = idx;
            minDist = newDist;
        end
    end
    xp=get(finalH,'Xdata'); %Getting coordinates of line object
    yp=get(finalH,'Ydata');
    ptH = plot(aH,xp(finalIdx),yp(finalIdx),'k*','MarkerSize',20);
    setappdata(aH,'CurrentPoint',ptH);




    rnd_xp=round(xp,3);
    rnd_yp=round(yp,3);

    fprintf('\n (');
    fprintf('%.3f',rnd_xp(finalIdx));
    fprintf(',');

    fprintf('%.3f',rnd_yp(finalIdx));
    fprintf(')\n');
%     disp(xp(finalIdx));
%     disp(yp(finalIdx));
end