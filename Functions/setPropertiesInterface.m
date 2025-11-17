function propsInterface = setPropertiesInterface(model,species,blockname,dirname)

% Set Species Properties of Interface Domain
% Usage: setPropertiesInterface(model,species,blockname,<dirname>)
%
% (c) Klaus Schnitzlein - 13.05.2025

if(nargin == 3)
  database = sprintf('%s/Data/Interface',getenv('root_CRD'));
else
  database = dirname;
end

s = enumeration('ChemReactorDesign.Basic.Interface.enum.SpeciesName');
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

propsInterface = getPropertiesInterface(Ids,database);

setBlockData(model,blockname,...
  'N',N,...
  'Ids',propsInterface.Ids,...
  'Mw',propsInterface.Mw,...
  'Am',propsInterface.Am);
end



