 function y=fpwsshlb8(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh stl sts obl obs wspt
 y=[-1 2]; if MiMi(i,1)<=0
 ep=enp-2*mean(tr(h,l,c,i-15:i-1));
 sp=min(l(i-MiMi(i-1,3):i-1))-tickstep;  
 sp=max([sp ep]); if or(l(i)<=sp,i==length(c));
 y(1)=wd(min([o(i) sp]),tickstep,-1);
 end; end
