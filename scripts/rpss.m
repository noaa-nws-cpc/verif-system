% Forecast probability density functions (pdf) for several forecasts
Fpdf=[NaN,NaN,NaN; NaN,NaN,NaN; NaN,NaN,NaN]'
% Number of forecasts where Below is observed
NF=size(Fpdf,2)
% Forecasts cumulative density functions (cdf)
Fcdf=cumsum(Fpdf,1)
% Number of categories; 3 for terciles
Ncat=3
% Climatolgy pdf
Cpdf=ones([Ncat 1])/Ncat
% Climatology cdf
Ccdf=cumsum(Cpdf,1)
% Observed pdf for Below observed in NF forecasts
Opdf=[1;0;0]
% Observed cdf
Ocdf=cumsum(Opdf)
% RPS for individual forecasts and climatology
Frps=sum((Fcdf-repmat(Ocdf, [1 NF])).^2, 1)
% Remove NaNs
bad_values=find(isnan(Frps))
Frps(bad_values)=[]
% Number of non NaN fcsts
N=size(Frps,2)
rpsF = sum(Frps)./N % mean RPS of forecasts (ignoring NaNs)
rpsCB=sum((Ccdf-Ocdf).^2,1)  % RPS is identical for every Below observed
% RPSS
rpssval=1-(rpsF./rpsCB)

