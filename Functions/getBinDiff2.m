function Dbin = getBinDiff2(diffVol,M,T,p)
%% Berechnung der binären Diffusionskoeffizienten [m^2/s]
% nach der Methode von Fuller, Schettler & Giddings
% after [Reid et al. p.555]
%
% (c) Klaus Schnitzlein - 09.08.2025

N = length(diffVol);
Dbin = zeros(N,N); % [m^2/s]
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
