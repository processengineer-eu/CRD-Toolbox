function Molwt = getMolwt(species)
%% Berechnung der Molekulargewichte der Spezies
%
% Copyright Klaus Schnitzlein - 30.03.22

comp.Name = {'H2','D2','He','N2','O2','Air','Ar','Kr','Xe','CO','CO2','N2O','NH3','H2O','CCL2F2','SF6','Cl2','Br2','SO2'};
comp.Mw = [2.016 4.032 4.003 28.014 31.998 28.577 39.948 83.8 131.29 28.01 44.009 44.013 17.031 18.015 120.913 146.054 70.906 159.80 64.064];
N = length(species);
Molwt = simscape.Value(zeros(N,1),'g/mol');
for i=1:N
  index = find(strcmp(species{i},comp.Name), 1);
  if(~isempty(index))
    Molwt(i) = simscape.Value(comp.Mw(index),'g/mol');
  end
end

elem.Name = {'C','H','O','N','S','Cl'};
elem.Mw = [12.011 1.008 15.999 14.007 32.066 35.453];
index = find(Molwt==0);
B = getBeta({species{index}},elem.Name);
Molwt(index) = simscape.Value(B'*elem.Mw','g/mol');

end