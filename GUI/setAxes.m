function setAxes()

global gvar

    gvar.xDist=0.001;
    gvar.domainLower=-10;
    gvar.domainUpper=10;
    gvar.rangeLower=-10;
    gvar.rangeUpper=10;
    axis([gvar.domainLower gvar.domainUpper gvar.rangeLower gvar.rangeUpper]);
    
    gvar.axis_plot(1)=plot([-100000 100000],[0 0],'k');
    hold on
    gvar.axis_plot(2)=plot([0 0],[-100000 100000],'k');



end

