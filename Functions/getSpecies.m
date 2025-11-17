function species=getSpecies(schema)
% Ermittlung der Spezies aus einem Reaktionsschema
%
% Copyright Klaus Schnitzlein - 12.08.2021
% Usage: species=getSpecies(schema)
  
  M = length(schema);
  species = {};
  for j = 1:M
    [s,e,te,m,t,nm,sp] = regexp(schema{j},"([A-Za-z]+[\(\)0-9\w\^\+\-\d]*)+");
    species = [species,m];
  end
  species = unique(species);
end
