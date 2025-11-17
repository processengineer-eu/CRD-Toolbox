function Dk = getKDiff2(Mw,T,rp)
%% Berechnung der Knudsen Diffusionskoeffizienten [m^2/s]
%
% (c) Klaus Schnitzlein - 09.08.2025

R = 8.3143; % [J/(mol*K)]
Dk = 2/3*rp*sqrt(8*R*T./(pi*Mw)); % [m^2/s]
end
