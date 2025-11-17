% Generiere die LookUp-Tables für maximal fünf Spezies der Solid Domain
% - alle Argumente sind dimensionslos
%
% (c) Klaus Schnitzlein - 28.04.2025

function [Ids,Mw,table_T,table_cp,table_H,table_G,table_Vm,table_lambda] = ...
  checkSolidSpecies5(Tmin,Tmax,nT,N,A1,A2,A3,A4,A5)

s = enumeration('ChemReactorDesign.Basic.Solid.enum.SpeciesName');

% enumeration values
A = [A1,A2,A3,A4,A5];
A = A(1:N);

Ids = zeros(N,1); % enthält die enumeration values der Spezies
for i=1:N
  k = find(s == A(i));
  if(k)
    Ids(i) = s(k);
  else
    error('Enumeration %s not found\n',A(i))
  end
end 

table_T = linspace(simscape.Value(Tmin,'K'),simscape.Value(Tmax,'K'),nT);
propsSolid = getPropertiesSolidTable(table_T,Ids);
Ids = propsSolid.Ids;
Mw = value(propsSolid.Mw,'g/mol');
table_T = value(propsSolid.table_T,'K');
table_cp = value(propsSolid.table_cp,'J/(mol*K)');
table_H = value(propsSolid.table_H,'kJ/mol');
table_G = value(propsSolid.table_G,'kJ/mol');
table_Vm = value(propsSolid.table_Vm,'l/mol');
table_lambda = value(propsSolid.table_lambda,'W/(m*K)');

if(~isempty(gcs))
  assignin('base','propsSolid',propsSolid);
end
end
