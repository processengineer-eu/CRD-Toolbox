% Retrieve Species Name from DataBase with Index
% (c) Klaus Schnitzlein - 13.05.2025

function species = retrieveSpecies(phase,Ids)
  file = sprintf('ChemReactorDesign.Basic.%s.enum.SpeciesName',phase);
  s = enumeration(file);
  mapSpecies = s.displayText;
  N = length(Ids);
  species = cell(1,N);
  for i=1:N
    k = find(s == Ids(i));
    if(k)
      species{i} = mapSpecies(char(s(k)));
    else
      error('Ids %d not found\n',Ids(i))
    end
  end
end