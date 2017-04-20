clear 
clear globa;
close all
close all hidden

linewidthn=8;
linecolorn='b';
linecolorn1='w';
ftc=figure(1);
hold off
plot(-1.1:0.1:1.1,modelnor(1.2,-0.3,sin(-1.1:0.1:1.1)),'w')
set(gcf,'color','w','posi', [201   163   741   420]);
set(gca,'color','w'); 
set(get(gca,'xlabel'),'color','w');
set(get(gca,'ylabel'),'color','w');
hold on
angle=6.03*pi/64:pi/200:58.79/64*pi;
handleherep=polar(angle,ones(size(angle)),[linecolorn,'-']);hold on;  % E Crecent
set(handleherep,'linewidth',linewidthn);
set(gca,'color',get(gcf,'color'));
handleherep=gca;
set(handleherep,'xcolor',linecolorn);
set(handleherep,'ycolor',linecolorn);

angle=5*pi/64:pi/200:59/64*pi;
handlehere=polar(angle,0.8*ones(size(angle)),[linecolorn,'-']);hold on;
set(handlehere,'linewidth',linewidthn);

angle=4*pi/64:pi/200:60/64*pi;
handlehere=polar(angle,0.6*ones(size(angle)),[linecolorn,'-']);hold on;
set(handlehere,'linewidth',linewidthn);

angle=3*pi/64:pi/200:61/64*pi;
handlehere=polar(angle,0.4*ones(size(angle)),[linecolorn,'-']);hold on;
set(handlehere,'linewidth',linewidthn);

angle=2*pi/64:pi/200:62/64*pi;
handlehere=polar(angle,0.2*ones(size(angle)),[linecolorn,'-']);hold on;
set(handlehere,'linewidth',linewidthn);

angle=[[12:-1:2]*pi/128 [125:-1:116]/128*pi];
rad=[1.02:-0.1:0 0.1:0.1:1.0];
handlehere=plot(rad.*cos(angle),rad.*sin(angle),linecolorn);hold on; % Alderton St.
set(handlehere,'linewidth',linewidthn+5);

handlehere=polar([pi/2 pi/2],[0 0.99],linecolorn);hold on; % 64th Road
set(handlehere,'linewidth',linewidthn+3);

handlehere=polar([pi/4 pi/4],[0.4 1],linecolorn);hold on; 

set(handlehere,'linewidth',linewidthn);

handlehere=polar([pi*3/4 pi*3/4],[0.4 1],linecolorn);hold on;
set(handlehere,'linewidth',linewidthn);

handlehere=polar([pi*21/128 pi*21/128],[0.28 1.1],linecolorn1);hold on;
set(handlehere,'linewidth',linewidthn);
handlehere=polar([pi*3/8 pi*3/8],[0.3 1.1],linecolorn1);hold on;
set(handlehere,'linewidth',linewidthn);
handlehere=polar([pi*5/8 pi*5/8],[0.3 1.1],linecolorn1);hold on;
set(handlehere,'linewidth',linewidthn);
handlehere=polar([pi*107/128 pi*107/128],[0.28 1.1],linecolorn1);hold on;
set(handlehere,'linewidth',linewidthn);

handlehere=polar([pi/4 pi/4],[0.15 0.25],linecolorn1);hold on;
set(handlehere,'linewidth',linewidthn);

handlehere1=polar([pi*3/4 pi*3/4],[0.15 0.25],linecolorn1);hold on;
set(handlehere1,'linewidth',linewidthn);

handlehere=text(-0.125,0.01,'l');hold on;
set(handlehere,'color',linecolorn1,'fontsize',linewidthn+6,'fontname','wingdings');

texthand1=text(-0.92*sin(pi/18),0.905*cos(pi/20),'R');hold on;
set(texthand1,'color',linecolorn,'fontsize',24,'FontWeight','bold');

texthand2=text(0.94*sin(pi/40),0.895*cos(pi/60),'P');hold on;
set(texthand2,'color',linecolorn,'fontsize',24,'FontWeight','bold');

texthand1=text(0.725,0.85,'TM');hold on;
set(texthand1,'color',linecolorn,'fontsize',34,'FontWeight','bold');
set(gcf,'color',linecolorn1);

texthand1=text(-0.87,-0.15,'N i n g s t e r');hold on;
set(texthand1,'color',linecolorn,'fontsize',42,'FontWeight','bold');
set(gcf,'color',linecolorn1);

hold off