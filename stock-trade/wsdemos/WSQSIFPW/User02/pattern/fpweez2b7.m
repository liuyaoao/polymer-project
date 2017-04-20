 function y=fpwexitb7(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi lcps ltpd
  y=[1000000 3];
  global new301 new302; a=fpwrn2n(new301);
  b=fpwrn2n(new302);
   if (or(c(i)-enp<=tickstep*a,(c(i)-l(i))/(h(i)-l(i))>b))&(i==enw)
      y(1)=c(i); 
  end
