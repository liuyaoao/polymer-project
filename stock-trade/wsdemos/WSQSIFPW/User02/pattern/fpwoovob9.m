 function y=fpwoovob9(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh stl sts obl obs wspt
 if length(obl)==0; obl=1000000; end; global zhu742 ent01 zhu743
 yuan1 = fpwrn2n(zhu742)*vo(h,l,i-1,5)/100;
 yuan2 = fpwrn2n(zhu743)*tickstep;
 yuan=wd(max([yuan1 yuan2]),tickstep,-1);
 
 y=[min([enp+max([yuan sl5]) obl]) 2];

