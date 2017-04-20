 function y=fpwobjeb8(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh stl sts obl obs wspt
  if length(obl)==0; obl=1000000; end; global new305 new306 new304 ent01
  if wspt==0; yuan=tickstep*fpwrn2n(new305);  if new304=='$';
    yuan=tickstep*round(100*fpwrn2n(new305)/fpwrn2n(ent01)); end;
  if new304=='V';yuan=wd(fpwrn2n(new305)*vo(h,l,i-1,5),tickstep,1);end;end;
  if wspt==1; yuan=tickstep*fpwrn2n(new306); if new304=='$'; 
    yu=tickstep*round(100*fpwrn2n(new306)/fpwrn2n(ent01)); end;
  if new304=='V';yuan=wd(fpwrn2n(new306)*vo(h,l,i-1,5),tickstep,1);end;end; 
 y=[min([enp+max([yuan sl5]) obl]) 2];
