% Retrieve Species Properties of Interface Domain 
% Usage: getPropertiesInterface(Ids,<dirname>)
% - das Array Ids enthält die enumeration Werte für die Spezies
%
% (c) Klaus Schnitzlein - 30.05.2025

function propsInterface = getPropertiesInterface(Ids,dirname)

if(nargin == 1)
  database = sprintf('%s/Data/Interface',getenv('root_CRD'));
else
  database = dirname;
end

% Extraktion der Spezies-Information
s = enumeration('ChemReactorDesign.Basic.Interface.enum.SpeciesName');
mapSpecies = s.displayText;
mapFiles = s.displayFileName;
N = length(Ids);

interfaceSpecies = cell(1,N);
fileNames = cell(1,N);
for i=1:N
  found = false;
  for j=1:length(s)
    if(s(j) == Ids(i))
      interfaceSpecies{i} = mapSpecies(char(s(j)));
      fileNames{i} = mapFiles(char(s(j)));
      found = true;
      break;
    end
  end
  if(~found)
    error('Ids %d not found\n',Ids(i))
  end  
end

Mw = simscape.Value(zeros(N,1),'g/mol');
Am = simscape.Value(zeros(N,1),'m^2/mol');

for i=1:length(Ids)
  filename = sprintf("%s/%s.xml",database,fileNames{i});
  data = readstruct(filename);

  Mw(i) = simscape.Value(data.MolecularWeight.valueAttribute,...
    data.MolecularWeight.unitsAttribute);
  Am(i) = simscape.Value(data.MolarArea.valueAttribute,...
    data.MolarArea.unitsAttribute);
end

propsInterface.species = interfaceSpecies;
propsInterface.Ids = Ids;
propsInterface.Mw = Mw;
propsInterface.Am = Am;

% schreibe den enumeration file 

fp = fopen(sprintf('%s/+ChemReactorDesign/+Basic/+Interface/+enum/SelectedSpecies.m',getenv('root_CRD')),'w');
fprintf(fp,'classdef SelectedSpecies < int32\n');
fprintf(fp,'\tenumeration\n');
for i=1:N
  fprintf(fp,sprintf('\t\tS%d\t(%d)\n',i,Ids(i)));
end
fprintf(fp,'\tend\n'); 
fprintf(fp,'\tmethods (Static)\n');
fprintf(fp,'\t\tfunction map = displayText()\n');
fprintf(fp,'\t\t\tmap = containers.Map;\n');
for i=1:N
  fprintf(fp,sprintf('\t\t\tmap(''S%d'') = ''%s'';\n',i,interfaceSpecies{i}));
end
fprintf(fp,'\t\tend\n');
fprintf(fp,'\tend\n');
fprintf(fp,'end\n'); 
fclose(fp);
end

