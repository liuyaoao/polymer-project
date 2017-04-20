 function y=fpwobjeB9(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh brkl brks bkei stl sts obl obs wspt stk3 dam3 stk4 dam4 stk5 dam5
 if length(obl)==0; obl=1000000; end; global zhu742 ent01 zhu743;
 yuan1 = fpwrn2n(zhu742)*vo(h,l,i-1,5)/100;
 yuan2 = fpwrn2n(zhu743)*tickstep;
 yuan=wd(max([yuan1 yuan2]),tickstep,-1);
 
 y=[min([enp+max([yuan sl5]) obl]) 2];
