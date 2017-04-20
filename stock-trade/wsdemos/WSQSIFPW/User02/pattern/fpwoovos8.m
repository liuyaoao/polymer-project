 function y=fpwoovoS8(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh brkl brks bkei stl sts obl obs wspt stk3 dam3 stk4 dam4 stk5 dam5
  if length(obs)==0; obs=-1; end; global new305 new306 new304 ent01
  if wspt==0; yuan=tickstep*fpwrn2n(new305);  if new304=='$';
    yuan=tickstep*round(100*fpwrn2n(new305)/fpwrn2n(ent01)); end;
  if new304=='V';yuan=wd(fpwrn2n(new305)*vo(h,l,i-1,5),tickstep,-1);end;end; 
  if wspt==1; yuan=tickstep*fpwrn2n(new306); if new304=='$'; 
    yu=tickstep*round(100*fpwrn2n(new306)/fpwrn2n(ent01)); end;
  if new304=='V';yuan=wd(fpwrn2n(new306)*vo(h,l,i-1,5),tickstep,-1);end;end; 
  yuan=max([yuan sl5]);y=[max([0 enp-yuan obs]) 2];
