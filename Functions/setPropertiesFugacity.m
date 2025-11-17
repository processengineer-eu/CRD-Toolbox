function setPropertiesFugacity(model,species,blockname)
% Set Properties for Mixture Fugacity Calculations
% für Peng-Robinson EOS
%
% Usage: setPropertiesGas(model,species,blockname)
%
% (c) Klaus Schnitzlein - 12.11.2024

database = sprintf('%s',getenv('root_CRD'));
N = length(species);
pc = simscape.Value(zeros(N,1),'Pa');
Tc = simscape.Value(zeros(N,1),'K');
omega = simscape.Value(zeros(N,1),'1');

for i=1:length(species)
  filename = sprintf("%s/Data/%s.xml",database,species{i});
  data = readstruct(filename);
  pc(i) = simscape.Value(data.CriticalPressure.valueAttribute,...
    data.CriticalPressure.unitsAttribute);
  Tc(i) = simscape.Value(data.CriticalTemperature.valueAttribute,...
    data.CriticalTemperature.unitsAttribute);
  omega(i) = simscape.Value(data.AcentricityFactor.valueAttribute,...
      strrep(data.AcentricityFactor.unitsAttribute,'_','1'));
  cas{i} = data.CAS.valueAttribute{1};
end

ipd = fileread(sprintf("%s/Data/ipd/pr.ipd",database));
k = zeros(N,N);
for i=1:N
  for j=i+1:N
    if(i~=j)
      expr = [cas{i} '\s+' cas{j} '\s+' '([\.+-e0-9]+)'];
      [~,matches] = regexp(ipd,expr,'match','tokens');
      switch(length(matches))
        case 0
          fprintf('nichts gefunden für %s  %s\n',cas{i},cas{j});
        case 1
          k(i,j) = str2double(matches{1});
        otherwise
          fprintf('mehrere Einträge für %s  %s gefunden\n',cas{i},cas{j});
      end
    end
  end
end
k = k + k';

setBlockData(model,blockname,...
  'pc',pc,...
  'Tc',Tc,...
  'omega',omega,...
  'k',k);
end
