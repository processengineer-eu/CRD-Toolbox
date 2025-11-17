function propsGas = setPropertiesGasTable(thermo,table_T,model,species,blockname,dirname)

% Set Species Properties of Gas Domain via Lookup Tables
% Usage: setPropertiesGasTable(table_T,model,species,blockname,<dirname>)
% - das Array species enthält die Klarnamen der Spezies (SpeciesName)
%
% (c) Klaus Schnitzlein - 15.08.2025

if(nargin == 5)
  database = sprintf('%s/Data/Gas',getenv('root_CRD'));
else
  database = dirname;
end

s = enumeration('ChemReactorDesign.Basic.Gas.enum.SpeciesName');
mapSpecies = s.displayText;
N = length(species);
Ids = zeros(N,1);
for i=1:N
  found = false;
  for j=1:length(mapSpecies)
    if(strcmp(species{i},mapSpecies(char(s(j)))))
      Ids(i) = s(j); 
      found = true;
      break
    end
  end
  if(~found)
    error('Species %s not found\n',species{i})
  end
end

propsGas = getPropertiesGasTable(table_T,Ids,database);
if(thermo == ChemReactorDesign.Basic.Gas.enum.ThermodynamicModel.PengRobinson)
  k0 = getPropertiesPR(propsGas);
else
  k0 = zeros(N,N);
end
propsGas.k0 = k0;

setBlockData(model,blockname,...
  'model',thermo,...
  'N',N,...
  'Ids',propsGas.Ids,...
  'Mw',propsGas.Mw,...
  'Dv',propsGas.Dv,...
  'table_T',propsGas.table_T,...
  'table_cp',propsGas.table_cp,...
  'table_mu',propsGas.table_mu,...
  'table_lambda',propsGas.table_lambda,...
  'table_H',propsGas.table_H,...
  'table_S',propsGas.table_S,...
  'Tc',propsGas.Tc,...
  'pc',propsGas.pc,...
  'omega',propsGas.omega,...
  'k0',propsGas.k0);



end



