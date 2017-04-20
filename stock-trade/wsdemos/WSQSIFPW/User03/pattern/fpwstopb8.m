 function y=fpwstopB8(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh brkl brks bkei stl sts obl obs wspt stk3 dam3 stk4 dam4 stk5 dam5
 global bdsdayf bdsday;  y=[-1 3];
 if MiMi(i,1)<=0;
    y(2)=MiMi(i,4);
    
  y(1)=MiMi(i,3);
 end;
