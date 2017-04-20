 function y=fpwexitS7(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh brkl brks bkei stl sts obl obs wspt stk3 dam3 stk4 dam4 stk5 dam5
  y=[-1 3];
  global new301 new302; a=fpwrn2n(new301);
  b=fpwrn2n(new302);
  if (or(enp-c(i)<=tickstep*a,(c(i)-l(i))/(h(i)-l(i))>b))&(i==enw);
      y(1)=c(i); 
  end;
