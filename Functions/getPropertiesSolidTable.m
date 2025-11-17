% Retrieve Species Properties of Solid Domain via Lookup Tables
% Usage: getPropertiesSolid(table_T,Ids,<dirname>)
% - das Array Ids enthält die enumeration Werte für die Spezies
%
% (c) Klaus Schnitzlein - 17.11.2025

function propsSolid = getPropertiesSolidTable(table_T,Ids,dirname)

np = length(table_T);
Tmin = table_T(1);
Tmax = table_T(end);

if(nargin == 2)
  database = sprintf('%s/Data/Solid',getenv('root_CRD'));
else
  database = dirname;
end

% Extraktion der Spezies-Information
s = enumeration('ChemReactorDesign.Basic.Solid.enum.SpeciesName');
mapSpecies = s.displayText;
mapFiles = s.displayFileName;
N = length(Ids);

solidSpecies = cell(1,N);
fileNames = cell(1,N);
for i=1:N
  found = false;
  for j=1:length(s)
    if(s(j) == Ids(i))
      solidSpecies{i} = mapSpecies(char(s(j)));
      fileNames{i} = mapFiles(char(s(j)));
      found = true;
      break;
    end
  end
  if(~found)
    error('Ids %d not found\n',Ids(i))
  end  
end

Tref = simscape.Value(298.15,'K');
CAS = cell(N,1);
Mw = simscape.Value(zeros(N,1),'g/mol');
dHf0 = simscape.Value(zeros(N,1),'kJ/mol');
dSf0 = simscape.Value(zeros(N,1),'kJ/(mol*K)');
dGf0 = simscape.Value(zeros(N,1),'kJ/mol');
S0 = simscape.Value(zeros(N,1),'kJ/(mol*K)');

% Koeffizienten sind dimensionslos, da sie #eqno und #mult enthalten
cp0 = zeros(N,7);
rho0 = zeros(N,7);
lambda0 = zeros(N,7);

for i=1:length(Ids)
  filename = sprintf("%s/%s.xml",database,fileNames{i});
  data = readstruct(filename);
  
  CAS{i} = char(data.CAS.valueAttribute);

  Mw(i) = simscape.Value(data.MolecularWeight.valueAttribute,...
    data.MolecularWeight.unitsAttribute);
  
  cp0(i,1) = data.SolidHeatCapacityCp.eqno.valueAttribute;
  cp0(i,2) = simscape.Value(1,data.SolidHeatCapacityCp.unitsAttribute)/...
    simscape.Value(1,'J/(mol*K)');
  cp0(i,3:end) = scanField(data.SolidHeatCapacityCp);
  if(value(Tmin,'K')<data.SolidHeatCapacityCp.Tmin.valueAttribute)
     warning('cp0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.SolidHeatCapacityCp.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.SolidHeatCapacityCp.Tmax.valueAttribute)
     warning('cp0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.SolidHeatCapacityCp.Tmax.valueAttribute);
  end
  
  rho0(i,1) = data.SolidDensity.eqno.valueAttribute;
  rho0(i,2) =  simscape.Value(1,strrep(data.SolidDensity.unitsAttribute,'m3','m^3'))/...
    simscape.Value(1,'mol/l');
  rho0(i,3:end) = scanField(data.SolidDensity);
      
  dHf0(i) = simscape.Value(data.HeatOfFormation.valueAttribute,...
    data.HeatOfFormation.unitsAttribute);
      
  dGf0(i) = simscape.Value(data.GibbsEnergyOfFormation.valueAttribute,...
    data.GibbsEnergyOfFormation.unitsAttribute);
  dSf0(i) = (dHf0(i)-dGf0(i))/Tref;
  S0(i) =  simscape.Value(data.AbsEntropy.valueAttribute,...
    data.AbsEntropy.unitsAttribute);
        
  lambda0(i,1) = data.SolidThermalConductivity.eqno.valueAttribute;
  lambda0(i,2) = simscape.Value(1,data.SolidThermalConductivity.unitsAttribute)/...
    simscape.Value(1,'W/(m*K)');
  lambda0(i,3:end) = scanField(data.SolidThermalConductivity);
  if(value(Tmin,'K')<data.SolidThermalConductivity.Tmin.valueAttribute)
     warning('lamda0: %g- T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.SolidThermalConductivity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.SolidThermalConductivity.Tmax.valueAttribute)
     warning('lambda0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.SolidThermalConductivity.Tmax.valueAttribute);
  end
end

p = 1; % [bar]
Tc = simscape.Value(ones(N,1)*298.15,'K');
table_cp = simscape.Value(zeros(N,np),'J/(mol*K)');
table_H = simscape.Value(zeros(N,np),'kJ/mol');
table_S = simscape.Value(zeros(N,np),'kJ/(mol*K)');
table_G = simscape.Value(zeros(N,np),'kJ/mol');
table_Vm = simscape.Value(zeros(N,np),'l/mol');
table_lambda = simscape.Value(zeros(N,np),'W/(m*K)');

for k=1:np
  table_cp(:,k) = getCp(cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_H(:,k) = getH(dHf0,cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_S(:,k) = getS(dSf0,cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_G(:,k) = table_H(:,k)-table_S(:,k)*table_T(k);
  table_Vm(:,k) = getVm(rho0,value(Tc,'K'),value(table_T(k),'K'));
  table_lambda(:,k) = getLambda(lambda0,value(Tc,'K'),value(table_T(k),'K'));
end

propsSolid.species = solidSpecies;
propsSolid.Ids = Ids;
propsSolid.CAS = CAS;
propsSolid.Mw = Mw;
propsSolid.table_T = table_T;

% Achtung: die Properties müssen transponiert werden, wegen getProperty_T().
propsSolid.table_cp = table_cp';
propsSolid.table_H = table_H';
propsSolid.table_S = table_S';
propsSolid.table_G = table_G';
propsSolid.table_Vm = table_Vm';
propsSolid.table_lambda = table_lambda';

% schreibe den enumeration file 
fp = fopen(sprintf('%s/+ChemReactorDesign/+Basic/+Solid/+enum/SelectedSpecies.m',getenv('root_CRD')),'w');
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
  fprintf(fp,sprintf('\t\t\tmap(''S%d'') = ''%s'';\n',i,solidSpecies{i}));
end
fprintf(fp,'\t\tend\n');
fprintf(fp,'\tend\n');
fprintf(fp,'end\n'); 
fclose(fp);
end

