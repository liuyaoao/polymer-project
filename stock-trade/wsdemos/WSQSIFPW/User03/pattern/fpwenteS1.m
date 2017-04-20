 function y=fpwenteS1(stock,i,enp,enw)
 o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
 global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi lcps ltpd tradeh brkl brks bkei stl sts obl obs wspt stk3 dam3 stk4 dam4 stk5 dam5
 y=[0 0 i 2 1 1 1]; global wsgp;if (c(i-1)<h(i-1))&(l(i-3)<h(i-5));
 wsgp=[h(i-1)+max([1 0.3*tr(h,l,c,i-1)]) c(i-1)]; [t1 t2]=wslogic('h>=wsgp(1)',i,2,13);
 if t1==1; [t3 t4]=wslogic('(L(i)<=wsgp(2))',i,t2(6),15.5);
 if t3==1; ta=wsgettp('fsp',sj(i,:),-1,1,wsgp(2),t4(6)-1/12);
 fdctime=ta(1)-1/12; if or(ta(1)>=14.5,ta(1)<13.5); 
 y(1)=-1; y(2)=ta(2); wstime=ta(1); end; end; end; end;