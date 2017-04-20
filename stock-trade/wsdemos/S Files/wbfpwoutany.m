function retstr = wbfpwoutany(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsozc3*> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
fpwCPAL=4;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' GO',instruct.outrunindex,'\n']); fclose(fid1);
  clear fid1
  fpwulvl=str2num(instruct.fpwulvl);
                   
  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
  name=fpwout.name; mname=fpwout.mname; Mname1=mname; Name1=name;
  datem=fpwout.datem; stock=fpwout.stock; tradeh=fpwout.tradeh; tradeo=fpwout.tradeo;
  outrunindex=instruct.outrunindex;
  revieworrun=instruct.hdoutGOror;
  fpwsource=instruct.fpwsource;
  cd([Wherematlab,'\pattern']);
  if (isfield(instruct,'outAnyU'))
    if fpwsecucheck([instruct.outAnyU,instruct.outAnyD])>0
      error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
    end
  end
  
  %save fpwtempfile
  dataTDW='Daily';
  if strcmp(outrunindex,'21')
    %level 1 any
    if ~strcmp(name,'ZZXY')
      if strcmp(revieworrun(1:3),'New'); fpwanyot1; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpegt11.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpegt12.jpeg'];      
    else
      if strcmp(revieworrun(1:3),'New'); fpwanyotm; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpegtm1.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpegtm2.jpeg'];  
    end
    fpwout1.outGOL='Level 1';
  elseif strcmp(outrunindex,'22')
    %level 2 any
    if ~strcmp(name,'ZZXY')
      if strcmp(revieworrun(1:3),'New'); fpwany121; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg211.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg212.jpeg'];      
    else
      if strcmp(revieworrun(1:3),'New'); fpwany12m; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg2m1.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg2m2.jpeg'];  
    end
    fpwout1.outGOL='Level 2';
  elseif strcmp(outrunindex,'23')
    %level 3 any
    if ~strcmp(name,'ZZXY')
      if strcmp(revieworrun(1:3),'New'); fpwany131; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg311.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg312.jpeg'];      
    else
      if strcmp(revieworrun(1:3),'New'); fpwany13m; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg3m1.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg3m2.jpeg']; 
    end
    fpwout1.outGOL='Level 3';
  elseif strcmp(outrunindex,'24')
    %level 2 any
    if ~strcmp(name,'ZZXY')
      wsningzhu=40; if strcmp(revieworrun(1:3),'New'); fpwany12x; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg2x1.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg2x2.jpeg'];       
    else
      error(' - Ha! why to run this? There will be a mess to run this over web at this time, it takess too much CPU time and hard ROM, only desktop version allowed to run this.');
    end
    fpwout1.outGOL='Level 2x';
  elseif strcmp(outrunindex,'25')
    %level 2 any
    if ~strcmp(name,'ZZXY')
      wsningzhu=15; if strcmp(revieworrun(1:3),'New'); fpwany12x; end
      fpwout1.outanyjpeg1=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg3x1.jpeg'];
      fpwout1.outanyjpeg2=[fpwclientdirectory,fpwusername,'\pattern\outanyjpeg3x2.jpeg']; 
    else
      error([' - Haha, unbelievable, you want to run this. There will be a mess to run this, it takes too much CPU time and hard ROM, only desktop version allowed to run this.']);
    end
    fpwout1.outGOL='Level 3x';
  end

  fpwout1.fpwusername=fpwusername;
  fpwout1.fpwusername4=fpwusername4;
  fpwout1.fpwulvl=instruct.fpwulvl;
  fpwout1.fpwsource=instruct.fpwsource;
  
  if strcmp(instruct.outGOsm,'UrSym')
    fpwout1.outGOsm='no';
  else
    fpwout1.outGOsm=[upper(instruct.outGOsm),' as'];
  end
  
  if strcmp(revieworrun(1:3),'New')
    fpwout1.NewoRew='New Run';
  else
    fpwout1.NewoRew='Review';   
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwmylastngo.mat dataTDW']);
  end
  
  if ~strcmp(name,'ZZXY')
    fpwout1.ZZxy=['Market ',upper([mname,name])];
  else
    fpwout1.ZZxy='Multi-Market';      
  end
  fpwout1.dataTDW=dataTDW;
  
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  
  if exist('myanytypeI')~=1
    myanytypeI=3;
  end
  
  if (myanytypeI~=4)&(myanytypeI~=5)
    if dataTDW(1)~='T'
      templatefile = which('wbfpwoutany.html');    
    else
      if strfind(dataTDW,'05')
        fpwout1.tthn='5';
      elseif strfind(dataTDW,'10')
        fpwout1.tthn='10';
      elseif strfind(dataTDW,'15')
        fpwout1.tthn='15';
      elseif strfind(dataTDW,'30')
        fpwout1.tthn='30';
      elseif strfind(dataTDW,'60')
        fpwout1.tthn='60';
      end
      templatefile = which('wbfpwoutanytick.html');
    end
  else
    if (myanytypeI==4)
      dataTDW=[dataTDW,' - Long'];
      templatefile = which('wbfpwoutanylong.html');
    else
      dataTDW=[dataTDW,' - New'];
      templatefile = which('wbfpwoutanynew.html');
    end
    fpwout1.dataTDW=dataTDW;
  end
  if (nargin == 1)
    retstr = htmlrep(fpwout1, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(fpwout1, templatefile, outfile);
  end  
end