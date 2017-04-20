 function y=fpwenteB1(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5
 global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
 global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspo wspo1; wspo='; wspo1='; wsgf='; wsgf1='; wsgp4=[stock sj]; wstd350g;
 y=[0 o(i) i 2 1 1 1]; 
 if c(i-1)<h(i-2);
   if (h(i-2)>=c(i-3))&(c(i-2)<h(i-3))
     a12=mean(c(i-12:i-1));  if or(h(i-2)>=c(i-4),o(i)>=l(i-5)); 
     if (h(i-1)-l(i-1))<=2*vo(h,l,i-1,10); if  c(i-1)>=mean(c(i-3:i-1))
     a6=mean(c(i-6:i-1));a3=mean(c(i-3:i-1)); if h(i-1)<h(i-4)
     r1=mean(h(i-10:i-1)-l(i-10:i-1));if (a3<a6)&(a6<a12) 
    if a12-a3>r1/2; y(1)=1; wstime=MyOT; fdctime=wstime;
  end; end; end; end; 
end; end; end; end