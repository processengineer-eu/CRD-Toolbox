function propsLiquid = setPropertiesLiquidTable(thermo,table_T,model,species,blockname,dirname)

% Set Species Properties of Liquid Domain via Lookup Tables
% Usage: setPropertiesLiquid(table_T,model,species,blockname,<dirname>)
% - das Array species enthält die Klarnamen der Spezies (SpeciesName)
%
% (c) Klaus Schnitzlein - 07.05.2025

if(nargin == 5)
  database = sprintf('%s/Data/Gas_Liquid',getenv('root_CRD'));
else
  database = dirname;
end

s = enumeration('ChemReactorDesign.Basic.Liquid.enum.SpeciesName');
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

propsLiquid = getPropertiesLiquidTable(table_T,Ids,database);
if(thermo == ChemReactorDesign.Basic.Liquid.enum.ThermodynamicModel.NRTL)
  [A,alpha] = getPropertiesNRTL(propsLiquid);
else
  A = eye(N,N);
  alpha = zeros(N,N);
end
propsLiquid.A = A;
propsLiquid.alpha = alpha;

setBlockData(model,blockname,...
  'model',thermo,...
  'N',N,...
  'Ids',propsLiquid.Ids,...
  'Mw',propsLiquid.Mw,...
  'charge',propsLiquid.charge,...
  'table_T',propsLiquid.table_T,...
  'table_cp',propsLiquid.table_cp,...
  'table_Vm',propsLiquid.table_Vm,...
  'table_mu',propsLiquid.table_mu,...
  'table_lambda',propsLiquid.table_lambda,...
  'table_H',propsLiquid.table_H,...
  'table_S',propsLiquid.table_S,...
  'table_Hv',propsLiquid.table_Hv,...
  'table_pvap',propsLiquid.table_pvap,...
  'A',propsLiquid.A,...
  'alpha',propsLiquid.alpha);
end



