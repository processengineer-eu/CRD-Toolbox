function result = retrieveData(species,parameter,filename)
% Retrieve thermodynamic data from database

%% Syntax
%   result = retrieveData(species,parameter,filename)

%% Input
%   species [string] - selector for species 
%   parameter [string] - name of parameter to be retrieved
%   filename [string] - filename of database

%% Output
%   result [simscape.Value/string] - parameter value/s

%% Disclaimer
%   (c) Klaus Schnitzlein - 17.06.2024

species = strrep(species,' ',''); % remove blanks
t = readtable(filename,'EmptyValue',0,'ReadRowNames',0,'VariableUnitsLine',2);
unit = t.Properties.VariableUnits(parameter);
N = length(species);
if(strcmpi(parameter,'Formula') == 0)
  result = simscape.Value(zeros(N,1),unit{1});
end
for i=1:N
  found = 0;
  for j=1:size(t,1)
    nameSubstance = strrep(t.Name(j),' ','');
    if(strcmpi(t.Formula(j),species(i)) || strcmpi(nameSubstance,species(i)))
      if(strcmpi(parameter,'Formula'))
        result(i) = t{j,parameter};
      else
        result(i) = simscape.Value(t{j,parameter},unit{1});
      end
      found = 1;
      break
    end
  end
  if(found == 0)
    error('Species %s not found in Database',species{i});
  end
end

end

