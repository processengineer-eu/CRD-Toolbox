function propsGas = getPropertiesGasTable(table_T,Ids,dirname)

% Retrieve Species Properties of Gas Domain via Lookup Tables
% Usage: getPropertiesGasTable(table_T,Ids,<dirname>)
% - das Array Ids enthält die enumeration Werte für die Spezies
% 
% (c) Klaus Schnitzlein - 17.11.2025

np = length(table_T);
Tmin = table_T(1);
Tmax = table_T(end);

if(nargin == 2)
  database = sprintf('%s/Data/Gas',getenv('root_CRD'));
else
  database = dirname;
end

% Ausgehend von den enumeration-Values -> Extraktion der Spezies-Information
s = enumeration('ChemReactorDesign.Basic.Gas.enum.SpeciesName');
mapSpecies = s.displayText;
mapFiles = s.displayFileName;
N = length(Ids);

gasSpecies = cell(1,N);
fileNames = cell(1,N);
for i=1:N
  found = false;
  for j=1:length(s)
    if(s(j) == Ids(i))
      gasSpecies{i} = mapSpecies(char(s(j)));
      fileNames{i} = mapFiles(char(s(j)));
      found = true;
      break;
    end
  end
  if(~found)
    error('Ids %d not found\n',Ids(i))
  end  
end

p = 1; % [bar]
Tref = simscape.Value(298.15,'K');

CAS = cell(N,1);
Mw = simscape.Value(zeros(N,1),'g/mol');
Dv = simscape.Value(zeros(N,1),'1');
dHf0 = simscape.Value(zeros(N,1),'kJ/mol');
dGf0 = simscape.Value(zeros(N,1),'kJ/mol');
dSf0 = simscape.Value(zeros(N,1),'kJ/(mol*K)');
S0 = simscape.Value(zeros(N,1),'kJ/(mol*K)');

% Koeffizienten sind dimensionslos, da sie #eqno und #mult enthalten
cp0 = zeros(N,7);
lambda0 = zeros(N,7);
mu0 = zeros(N,7);

Tc = simscape.Value(zeros(N,1),'K');
pc = simscape.Value(zeros(N,1),'bar');
omega = simscape.Value(ones(N,1),'1');

for i=1:length(Ids)
  filename = sprintf("%s/%s.xml",database,fileNames{i});
  data = readstruct(filename);

  CAS{i} = char(data.CAS.valueAttribute);
  
  Mw(i) = simscape.Value(data.MolecularWeight.valueAttribute,...
    data.MolecularWeight.unitsAttribute);
 
  cp0(i,1) = data.IdealGasHeatCapacityCp.eqno.valueAttribute;
  cp0(i,2) = simscape.Value(1,data.IdealGasHeatCapacityCp.unitsAttribute)/...
    simscape.Value(1,'J/(mol*K)');
  cp0(i,3:end) = scanField(data.IdealGasHeatCapacityCp);
  if(value(Tmin,'K')<data.IdealGasHeatCapacityCp.Tmin.valueAttribute)
     warning('cp0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.IdealGasHeatCapacityCp.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.IdealGasHeatCapacityCp.Tmax.valueAttribute)
     warning('cp0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.IdealGasHeatCapacityCp.Tmax.valueAttribute);
  end
  
  dHf0(i) = simscape.Value(data.HeatOfFormation.valueAttribute,...
    data.HeatOfFormation.unitsAttribute);
      
  dGf0(i) = simscape.Value(data.GibbsEnergyOfFormation.valueAttribute,...
    data.GibbsEnergyOfFormation.unitsAttribute);
  dSf0(i) = (dHf0(i)-dGf0(i))/Tref; % neu
  S0(i) =  simscape.Value(data.AbsEntropy.valueAttribute,...
    data.AbsEntropy.unitsAttribute);
        
  lambda0(i,1) = data.VaporThermalConductivity.eqno.valueAttribute;
  lambda0(i,2) = simscape.Value(1,data.VaporThermalConductivity.unitsAttribute)/...
    simscape.Value(1,'W/(m*K)');
  lambda0(i,3:end) = scanField(data.VaporThermalConductivity);
  if(value(Tmin,'K')<data.VaporThermalConductivity.Tmin.valueAttribute)
     warning('lamda0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.VaporThermalConductivity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.VaporThermalConductivity.Tmax.valueAttribute)
     warning('lambda0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.VaporThermalConductivity.Tmax.valueAttribute);
  end
      
  mu0(i,1) = data.VaporViscosity.eqno.valueAttribute;
  mu0(i,2) = simscape.Value(1,strrep(data.VaporViscosity.unitsAttribute,'.','*'))/...
    simscape.Value(1,'Pa*s');
  mu0(i,3:end) = scanField(data.VaporViscosity);
  if(value(Tmin,'K')<data.VaporViscosity.Tmin.valueAttribute)
     warning('mu0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.VaporViscosity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.VaporViscosity.Tmax.valueAttribute)
     warning('mu0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.VaporViscosity.Tmax.valueAttribute);
  end
  
  Tc(i) = simscape.Value(data.CriticalTemperature.valueAttribute,...
    data.CriticalTemperature.unitsAttribute);
  
  pc(i) = simscape.Value(data.CriticalPressure.valueAttribute,...
    data.CriticalPressure.unitsAttribute);

  omega(i) = simscape.Value(data.AcentricityFactor.valueAttribute,'1');

  Dv(i) = simscape.Value(data.FullerVolume.valueAttribute,'1');
end


table_cp = simscape.Value(zeros(N,np),'J/(mol*K)');
table_H = simscape.Value(zeros(N,np),'kJ/mol');
table_S = simscape.Value(zeros(N,np),'kJ/(mol*K)');
table_G = simscape.Value(zeros(N,np),'kJ/mol');
table_mu = simscape.Value(zeros(N,np),'Pa*s');
table_lambda = simscape.Value(zeros(N,np),'W/(m*K)');

for k=1:np
  table_cp(:,k) = getCp(cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_H(:,k) = getH(dHf0,cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_S(:,k) = getS(dSf0,cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_G(:,k) = table_H(:,k)-table_T(k)*table_S(:,k);
  table_mu(:,k) = getMu(mu0,value(Tc,'K'),value(table_T(k),'K'));
  table_lambda(:,k) = getLambda(lambda0,value(Tc,'K'),value(table_T(k),'K'));
end

propsGas.species = gasSpecies;
propsGas.Ids = Ids;
propsGas.CAS = CAS;
propsGas.Mw = Mw;
propsGas.Dv = Dv;
propsGas.Tc = Tc;
propsGas.pc = pc;
propsGas.omega = omega;
propsGas.table_T = table_T;

% Achtung: die Properties müssen transponiert werden, wegen getProperty_T().
propsGas.table_cp = table_cp';
propsGas.table_H = table_H';
propsGas.table_S = table_S';
propsGas.table_G = table_G';
propsGas.table_mu = table_mu';
propsGas.table_lambda = table_lambda';

% Schreibe den enumeration File mit den ausgewählten Spezies 
fp = fopen(sprintf('%s/+ChemReactorDesign/+Basic/+Gas/+enum/SelectedSpecies.m',getenv('root_CRD')),'w');
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
  fprintf(fp,sprintf('\t\t\tmap(''S%d'') = ''%s'';\n',i,gasSpecies{i}));
end
fprintf(fp,'\t\tend\n');
fprintf(fp,'\tend\n');
fprintf(fp,'end\n'); 
fclose(fp);
end

