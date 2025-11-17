function Dbin = getBinDiff(species,Tin,pin)
%% Berechnung der binären Diffusionskoeffizienten [m^2/s]
% nach der Methode von Fuller, Schettler & Giddings
% after [Reid et al. p.555]
%
% (c) Klaus Schnitzlein - 05.07.2023

T = value(convert(Tin,'K'));
p = value(convert(pin,'atm'));

N = length(species);
M = value(getMolwt(species));

indexRing = [];
for i=1:N
  if(strfind(species{i},'*')>0)
    indexRing = [indexRing,i];
  end
end
strrep(species,'*','');

%% Compounds
comp.Name = {'H2','D2','He','N2','O2','Air','Ar','Kr','Xe','CO','CO2','N2O','NH3','H2O','CCL2F2','SF6','Cl2','Br2','SO2'};
comp.Vol = [7.07 6.7 2.88 17.9 16.6 20.1 16.1 22.8 37.9 18.9 26.9 35.9 14.9 12.7 114.8 69.7 37.7 67.2 41.1];
diffVol = zeros(N,1);
for i=1:N
  index = find(strcmp(species{i},comp.Name), 1);
  if(~isempty(index))
    diffVol(i) = comp.Vol(index);
  end
end

%% Elements
elem.Name = {'C','H','O','N','S','Cl'};
elem.Vol = [16.5 1.98 5.48 5.69 17 19.5];
incRing = -20.2;
index = find(diffVol==0);
B = getBeta({species{index}},elem.Name);
diffVol(index) = B'*elem.Vol';

%% Aromatic Rings
if(~isempty(indexRing))
  diffVol(indexRing) = diffVol(indexRing)+incRing;
end

%% Binary Diffusion Coefficients
Dbin = zeros(N,N);
for i = 1:N
  for j = 1:N
    if(i ~= j)
      Dbin(i,j) = 1.0e-07*(T^1.75)*sqrt(1/M(i)+1/M(j))/(...
        p*(diffVol(i)^(1/3)+diffVol(j)^(1/3))^2);
    else
      Dbin(i,j) = 1; % Defaultwert wichtig für die weiteren Rechnungen
    end
  end
end
Dbin = simscape.Value(Dbin,'m^2/s');