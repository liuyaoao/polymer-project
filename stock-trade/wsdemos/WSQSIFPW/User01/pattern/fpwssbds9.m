 function y=fpwssbds9(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh stl sts obl obs wspt
 y=[1000000 3];
 if MiMi(i,1)>=0;
        y(2)=MiMi(i,4);
   
   y(1)=MiMi(i,3);
 end;  
