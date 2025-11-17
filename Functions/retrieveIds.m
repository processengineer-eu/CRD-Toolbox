% Retrieve Id, formula and name from ChemSep DataBase 
%
% (c) Klaus Schnitzlein - 05.03.2025

clear
root = getenv('root_CRD');
files = dir(sprintf('%s/Data',root));
for i=1:length(files)
  [~,~,ext] = fileparts(files(i).name);
  if(strcmp(files(i).name,'template.xml'))
    continue
  end
  if(isSymbolicLink(sprintf('%s/Data/%s',root,files(i).name)))
    continue
  end
  if(~strcmp(ext,'.xml'))
    continue;
  end
  data = readstruct(sprintf('%s/Data/%s',root,files(i).name));
  fprintf('%s (%d) %s\n', ...
    data.StructureFormula.valueAttribute,...
    data.LibraryIndex.valueAttribute,...
    data.CompoundID.valueAttribute);
end
