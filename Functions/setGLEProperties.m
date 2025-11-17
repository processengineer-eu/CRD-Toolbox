function setGLEProperties(table_T,model,species,block)

% Set Properties for Gas Dissolution 
%
% (c) Klaus Schnitzlein - 07.10.2025

species = strrep(species,'(g)',''); % strip '(s)' if present
N = length(species);

database = '~/Matlab/Simscape/ToolBox_V1/Data/Henry.csv';

A = retrieveData(species,'A',database);
B = retrieveData(species,'B',database);
C = retrieveData(species,'C',database);
D = retrieveData(species,'D',database);
Tmin = retrieveData(species,'Tmin',database);
Tmax = retrieveData(species,'Tmax',database);
dHs = retrieveData(species,'dHs0',database);

for i=1:N
  if(table_T(1) < Tmin(i) || table_T(end)>Tmax(i))
    error('setPropertiesSolution: invalid temperature range');
  end
end
nT = length(table_T);
table_Henry = simscape.Value(zeros(nT,N),'bar');

for i=1:nT
  table_Henry(i,:) = simscape.Value(10.^(A+B/table_T(i)+C*log10(value(table_T(i),'K'))+D*table_T(i)),'bar')';
end
table_dHs = repmat(dHs',nT,1);

setBlockData(model,block,...
  'table_T',table_T,...
  'table_Henry',table_Henry,...
  'table_dHs',table_dHs);
end
