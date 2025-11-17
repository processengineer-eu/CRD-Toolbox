% Generiere die LookUp-Tables für maximal fünf Spezies der Interface Domain
% - alle Argumente sind dimensionslos
%
% (c) Klaus Schnitzlein - 05.05.2025

function [Ids,Mw,Am] = checkInterfaceSpecies5(N,A1,A2,A3,A4,A5)

s = enumeration('ChemReactorDesign.Basic.Interface.enum.SpeciesName');

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

propsInterface = getPropertiesInterface(Ids);
Ids = propsInterface.Ids;
Mw = value(propsInterface.Mw,'g/mol');
Am = value(propsInterface.Am,'m^2/mol');

if(~isempty(gcs))
  assignin('base','propsInterface',propsInterface);
end
end
