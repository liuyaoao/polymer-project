function retstr = wbfpwsimufs(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stsimulp>, <stsiedit>, <stsirun> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);
%save fpwtempfile

retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=4;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

  WhereOrderFrom=instruct.WhereOrderFrom;
  if (strcmp(WhereOrderFrom,'SLFE'))
    urbanwords='';
    [fpwscpass1,whereban1,whatban1]=wbcheckbanw('FPWFile',instruct.fpwptfilef);
    if fpwscpass1~=1
      urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
    end            
    [fpwscpass2,whereban2,whatban2]=wbcheckbanw('FPWPTNAME',instruct.fpwptname);
    if fpwscpass2~=1
      urbanwords=[urbanwords,whereban2,': ',whatban2,'; '];
    end                     
    if (fpwscpass1+fpwscpass2)~=2
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' FAIL: ',urbanwords,'\n']); fclose(fid1);
      clear fid1    
      WhereOrderFrom='SCFL'
      sfpw.urbanwords=urbanwords;
    end
    clear urbanwords fpwscpass1 whereban1 whatban1 fpwscpass2 whereban2 whatban2
  end
    
  cd([Wherematlab,'pattern']);
  if (strcmp(WhereOrderFrom,'MSET'))
    fpwfmtype=instruct.fpwfmtype;
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' PWMS - ',fpwfmtype,'\n']); fclose(fid1);
    clear fid1
    s=instruct;
    listorun={};
    j=1;
    if fpwfmtype=='F'
      % checks
      fpwfmchosen=['000000000000000000000000000000000000000000'];
      for i=1:42
        if isfield(instruct,['fpwfmn',num2str(i+10)])
          if eval(['length(noempty(instruct.fpwfmn',num2str(i+10),'s))'])
            fpwfmchosen(i)='1';
            eval(['listorun{j}=instruct.fpwfmn',num2str(i+10),'s;']);
            j=j+1;
          else
            eval(['s.fpwfmn',num2str(i+10),'s='' '';']);
          end      
        end
      end
      if length(listorun)>0
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf listorun']);
        s.StatusReport = [' Future Markets list updated successfully. ',time]; 
      else
        %error(' No market chosen, must choose at least one market.');  
        s.StatusReport = ['Nothing done, did not choose any market. Run again. ',time];
      end
      s.fpwfmchosen=fpwfmchosen;
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimuf s']);
      %fpwsimwindow=1;
      fpwsimwindow=3;      
    else
      % checks
      fpwsmchosen='000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
      for i=1:108
        if isfield(instruct,['fpwsmn',num2str(i+10)])
          if eval(['length(noempty(instruct.fpwsmn',num2str(i+10),'s))'])
            fpwsmchosen(i)='1';
            eval(['listorun{j}=instruct.fpwsmn',num2str(i+10),'s;']);
            j=j+1;
          else
            eval(['s.fpwsmn',num2str(i+10),'s='' '';']);
          end 
        end
      end
      if length(listorun)>0
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns listorun']);
        s.StatusReport = [' Stock symbols list updated successfully. ',time];       
      else
        %error(' No market chosen, must choose at least one market.');  
        s.StatusReport = ['Nothing done, did not choose any market. Run again. ',time];
      end
      s.fpwsmchosen=fpwsmchosen;
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimus s']); 
      %fpwsimwindow=2;
      fpwsimwindow=3;         
    end
    cd(fpwserverplace);
    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');     
  elseif (strcmp(WhereOrderFrom,'SLFE'))
    if instruct.hdzhu99=='F'
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimuf.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimuf']);
      else
        s.fpwfmchosen=['100001000001000000100000000010000000100000'];
        stocklist=['sp';'us';'ed';'ty';'fy';'  ';'dx';'jy';'ec';'bp';'sf';'cd';'cl';'ho';'ng';'hu';'  ';'  ';'gc';'si';'za';'zc';'zn';
            'pl';'c ';'w ';'s ';'sm';'bo';'  ';'lc';'lh';'pb';'dj';'nd';'  ';'sb';'kc';'cc';'ct';'  ';'  '];
        for i=1:42
          eval(['s.fpwfmn',num2str(i+10),'s=upper(stocklist(i,:));']);
        end
      end
      s.fpwfmtype='F';
      fpwsimwindow=1;      
    else
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimus.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimus']);
      else
        s.fpwsmchosen='000010000001000000001000000000001000000010000100000000100000001000100001000000010000001000000000010000000000'; 
        stocklist=['dell';'csco';'intc';'msft';'hpq ';'yhoo';'orcl';'amat';'c   ';'cien';'sunw';'cd  ';'psft';'lu  ';
                   'nt  ';'dis ';'t   ';'aol ';'ge  ';'jpm ';'aapl';'amzn';'ibm ';'bac ';'mu  ';'g   ';'ba  ';'pfe ';
                   'pep ';'hd  ';'ko  ';'mer ';'wmt ';'xon ';'mrk ';'slb ';'spls';'amgn';'mtc ';'dd  ';'sbc ';'emc ';
                   'lly ';'bmy ';'txn ';'f   ';'gm  ';'gd  ';'mwd ';'hal ';'ftu ';'fnm ';'one ';'ca  ';'pg  ';'rd  ';
                   'mot ';'aig ';'klac';'jnj ';'ups ';'fdx ';'bhi ';'amd ';'mcd ';'abt ';'axp ';'umg ';'col ';'tyc ';
                   'spy ';'qqq ';'dia ';'bgen';'fore';'sebl';'lfc ';'chn ';'neng';'erts';'bel ';'fdc ';'hrc ';'novl';
                   'chv ';'all ';'cost';'hi  ';'rn  ';'afs ';'txu ';'nsm ';'thc ';'cdn ';'ait ';'glm ';'low ';'usb ';
                   'unh ';'amr ';'ual ';'cat ';'bls ';'eds ';'nem ';'gps ';'ek  ';'xrx '];
        for i=1:108
          eval(['s.fpwsmn',num2str(i+10),'s=upper(noempty(stocklist(i,:)));']);
        end
      end
      s.fpwfmtype='S';
      fpwsimwindow=2;      
    end
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
  elseif (strcmp(WhereOrderFrom,'MMWC'))
    s.StatusReport = ['Nothing done, you choose to close the market window. ',time];
    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');
    fpwsimwindow=3; 
  elseif (strcmp(WhereOrderFrom,'SCFL'))
    fpwsimwindow=4;
    Rno=instruct.fpwrunindex;
    if (strcmp(Rno(1),'5'))|(strcmp(Rno(1),'6'))
      s.StatusReport = ['Warning, banned words found: ',urbanwords];
      fpwsimwindow=1; 
    end
  end 
  
  cd(fpwserverplace);
  %save fpwtempfile1
  cids=fpwloginstatus(fpwusername,clock);
  if fpwsimwindow==1   % status report
    templatefile = which('fpwmarketf.html');
    if (nargin == 1)      
      retstr = htmlrep(s, templatefile);
    elseif (nargin == 2)
      retstr = htmlrep(s, templatefile, outfile);
    end    
  elseif fpwsimwindow==2  % simulation graphic output
    templatefile = which('fpwmarkets.html');    
    if (nargin == 1)
      retstr = htmlrep(s, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(s, templatefile, outfile);
    end
  elseif fpwsimwindow==3  % simulation graphic output
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput']);  
    sfpw.MRlist='';
    %sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist">')];
    sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist" onmouseover="window.status=''For MM simulation only, the market list you chose most recently.''" onmouseout="window.status=''Done''">')];      
    if sfpw.zhu99=='F'
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf']);
      else
        listorun{1}='SP';
        listorun{2}='US  ';
      end
    else
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns']);
      else
        listorun{1}='GE';
        listorun{2}='MSFT';
      end
    end
    thisnamene=noempty(listorun{1});
    thisnamele=length(noempty(listorun{1}));
    sfpw.MRlist=[sfpw.MRlist,sprintf(['<option selected value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
    if length(listorun)>1
      for i=2:length(listorun)
        thisnamene=noempty(listorun{i});
        thisnamele=length(noempty(listorun{i}));
        sfpw.MRlist=[sfpw.MRlist,sprintf(['<option value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
      end
    end
    sfpw.MRlist=[sfpw.MRlist,sprintf('</select>')]; sfpw.fpwmrlist=upper(noempty(listorun{1}));
    
    templatefile = which('wbfpwinput.html');
    if (nargin == 1)
      retstr = htmlrep(sfpw, templatefile); 
    elseif (nargin == 2)
      retstr = htmlrep(sfpw, templatefile, outfile);
    end  
  elseif fpwsimwindow==4  % trading list
    templatefile = which('wbcheckbanw.html');    
    s.mpgfoutput=' ';
    if (nargin == 1)
      retstr = htmlrep(s, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(s, templatefile, outfile);
    end  
  end
end