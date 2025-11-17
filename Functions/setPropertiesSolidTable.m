function propsSolid = setPropertiesSolidTable(table_T,model,species,blockname,dirname)

% Set Species Properties of Solid Domain via Lookup Tables
% Usage: setPropertiesSolid(table_T,model,species,blockname,<dirname>)
%
% (c) Klaus Schnitzlein - 13.05.2025

if(nargin == 4)
  database = sprintf('%s/Data/Solid',getenv('root_CRD'));
else
  database = dirname;
end

s = enumeration('ChemReactorDesign.Basic.Solid.enum.SpeciesName');
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

propsSolid = getPropertiesSolidTable(table_T,Ids,database);

setBlockData(model,blockname,...
  'N',N,...
  'Ids',propsSolid.Ids,...
  'Mw',propsSolid.Mw,...
  'table_T',propsSolid.table_T,...
  'table_cp',propsSolid.table_cp,...
  'table_Vm',propsSolid.table_Vm,...
  'table_lambda',propsSolid.table_lambda,...
  'table_H',propsSolid.table_H,...
  'table_S',propsSolid.table_S);
end



