function PageString = webstockrnd(InputSet, OutFile)
%WEBSTOCKRND stock future price path simulation.
%   Graphs simulated price paths over the next year.
%   PAGESTRING = WEBSTOCKRND(INPUTSET) creates HTML output
%   and graphic file.  Returns HTML output in PAGESTRING.
%   PAGESTRING = WEBSTOCKRND(INPUTSET, OUTFILE) is the same
%   as the previous example and additionally puts the HTML
%   output in file OUTFILE.
%
%   Inputs : char fields set by page webstock.html
%      Inputset.spot   : Current Stock Price
%      Inputset.r      : Annualized Expected Return (percent)
%      Inputset.sigma  : Annualized Volatility (percent)
%      Inputset.numsim : Number of Simulated Paths
%      Inputset.symbol : Ticker symbol							
%
%   Inputs : char fields supplied by matweb
%      Inputset.mldir  : working directory 
%      Inputset.mlid   : unique identifier for this call
% 
%   Uses a template file webstock2.html
%   Generates the jpeg file "wsrml#####.jpeg"
%   Writes a web page OutFile if requested.
% 
%   This is a Monte-Carlo simulation of the price of a stock 
%   over the next year. Input today's price, the expected rate
%   of return, and the volatility of the stock.  You can plot
%   a number of possible price scenarios at once.
% 
%   The prices are generated by sampling a lognormal stock 
%   price process.  See, for example, N. Chriss "Black-Scholes 
%   and Beyond", Irwin, 1997.  The lognormal stock price model
%   is used in finance to value stock options.
%

%   Author(s): J. Akao, 04-01-98
%   Copyright 1998-2001 The MathWorks, Inc.
%   $Revision: 1.8 $  $Date: 2001/04/25 18:49:31 $  

%------------------------------------------------------------
% Parse inputs from the page
spot   = str2double(InputSet.spot);
r      = str2double(InputSet.r);
sigma  = str2double(InputSet.sigma);
numsim = str2double(InputSet.numsim);
s.symbol = InputSet.symbol;

%------------------------------------------------------------
% Inputs
% spot   [scalar] spot > 0
% r      [scalar]
% sigma  [scalar] sigma > 0
% numsim [scalar]

% Set directory path for storage of graphic files.
cd(InputSet.mldir);

% Cleanup jpegs over an hour old.
wscleanup('wsrml*.jpeg', 1);

% Check input arguments.
if (nzmax(spot)~=1)
  error('Enter a scalar Current Stock Price');
elseif ( spot <= 0 )
  error('The Current Stock Price must be positive');
end
  
if (nzmax(sigma)~=1)
  error('Enter a scalar Stock Volatility');
elseif ( sigma <= 0 )
  error('The Stock Volatility must be positive');
end

if (nzmax(r)~=1)
  error('Enter a scalar Expected Rate of Return');
end

if (nzmax(numsim)~=1)
  error('Enter a scalar Number of Simulations');
elseif ( numsim <=0 | numsim~=round(numsim) )
  error('The Number of Simulations must be a positive integer');
end

%------------------------------------------------------------
% Generate data
% t [366 by 1]      : times to sample the price paths (0 to 1 year)
% S [366 by numsim] : matrix of price paths along the columns
%------------------------------------------------------------
t = (0:365)'/365;

% convert r and sigma to decimal from percent
S = localstockrnd(spot, r/100, t, sigma/100, numsim);

%------------------------------------------------------------
% Create the plot
%------------------------------------------------------------

% setup to create a jpeg file
Fig = figure('visible','off');

plot(t,S);
ylabel('Stock Price');
title(['Possible ' InputSet.symbol ' Stock Price Paths']);
  
% set the x ticks by hand to dates
% Don't worry about end-of-month or leap years

% Get the current date with the clock function
TodayVector = clock;
y0 = TodayVector(1); % year
m0 = TodayVector(2); % month
d0 = TodayVector(3); % day

% Build dates into the future, moving by months
MonthList = [0; 4; 8; 12];
NDayList  = datenum(y0, m0+MonthList, d0);

% Corresponding years from today
TickYears = (NDayList - NDayList(1))/365;

% String representations of the dates
TickLabels = datestr(NDayList, 1);

% Set the X axis ticks
set(gca, 'XTick', TickYears, 'XTickLabel', TickLabels)

% Adjust size
pos = get(gcf, 'position');
pos(3) = 380;
pos(4) = 310;
set(gcf, 'Position', pos, 'PaperPosition', [.25 .25 4 3]);

%------------------------------------------------------------
% Write the figure file
%------------------------------------------------------------
%Render jpeg and write to file
PlotFile = sprintf('wsr%s.jpeg', InputSet.mlid);

drawnow;
wsprintjpeg(Fig, PlotFile);
close(Fig);

templatefile = which('webstock2.html');
if ( exist('OutFile','var') == 1 )
  % write Page to a diagnostic file
  s.GraphFileName = [ PlotFile];
  PageString = htmlrep(s, templatefile, OutFile);
else
  s.GraphFileName = ['/icons/' PlotFile];
  PageString = htmlrep(s, templatefile);
end

%------------------------------------------------------------
% End of function webstockrnd
%------------------------------------------------------------

function S = localstockrnd(s0, r, t, sig, NUMRND)
%STOCKRND random lognormal stock process Monte Carlo simulation.
%   S = STOCKRND(SO, R, T, SIG, NUMRND) returns NT by NUMRND random
%   values of the stock process at times in T.
% 
%   Inputs
%      S0  : initial stock price (scalar)
%      R   : expected instantaneous rate of return (scalar)
%      T   : times between initial and final stock values (NT by 1)
%      SIG : instantaneous volatility of the stock (scalar)
%      NUMRND : number of random trials to generate
% 

%   Author(s): J. Akao, 04-01-98
%   Ref. Hull 

% reorder the times 
[t, torder] = sort(t(:));
NT = length(t);

% compute interval lengths dt
dt = zeros(NT,1);
dt(1) = t(1);
dt(2:end) = diff(t);

% increment parameters in time
logdrifts = (r - 0.5*sig.*sig).*dt;
logstds = sig.*sqrt(dt);

% logS : sum the increments along time if needed
if (NT==1)
  % scalar multiplication and addition
  logS = logdrifts + logstds*randn(1,NUMRND);
else
  % expand logdrifts and logstds to NT by NUMRND
  logS = cumsum( logdrifts(:,ones(1,NUMRND)) + ... 
      logstds(:,ones(1,NUMRND)).*randn(NT,NUMRND) );
end
  
% compute the stock values 
S = s0*exp(logS);

% place the times back into the original order
S(torder,:) = S;

