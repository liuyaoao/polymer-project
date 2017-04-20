 function y=fpwssvob8(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh stl sts exl exs
  if length(stl)==0; stl=-1; end;  global new303 ent01 new304
  if new304=='V'; hmtk=wd(fpwrn2n(new303)*vo(h,l,i-1,5),tickstep,-1)/tickstep; end
  if new304=='T'; hmtk=fpwrn2n(new303); end
  if new304=='$';
  hmtk=round(100*fpwrn2n(new303)/fpwrn2n(ent01)); end
  yuan=tickstep*hmtk;   y=[max([0 enp-yuan stl]) 2];
 
 
