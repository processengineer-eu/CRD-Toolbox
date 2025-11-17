function Dk = getKDiff(species,T,rp)
%% Berechnung der Knudsen Diffusionskoeffizienten [m^2/s]
%
% Copyright Klaus Schnitzlein - 13.06.22

R = simscape.Value(8.3143,'J/(mol*K)');
Mw = getMolwt(species);
Dk = convert(2/3*rp*sqrt(8*R*T./(pi*Mw)),'m^2/s');
end
