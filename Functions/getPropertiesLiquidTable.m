% Retrieve Species Properties of Liquid Domain via Lookup Tables
% Usage: getPropertiesLiquid(table_T,Ids,<dirname>)
% - das Array Ids enthält die enumeration Werte für die Spezies
%
% (c) Klaus Schnitzlein - 10.10.2025

function propsLiquid = getPropertiesLiquidTable(table_T,Ids,dirname)

np = length(table_T);
Tmin = table_T(1);
Tmax = table_T(end);

if(nargin == 2)
  database = sprintf('%s/Data/Gas_Liquid',getenv('root_CRD'));
else
  database = dirname;
end

% Extraktion der Spezies-Information
s = enumeration('ChemReactorDesign.Basic.Liquid.enum.SpeciesName');
mapSpecies = s.displayText;
mapFiles = s.displayFileName;
N = length(Ids);

liquidSpecies = cell(1,N);
fileNames = cell(1,N);
for i=1:N
  found = false;
  for j=1:length(s)
    if(s(j) == Ids(i))
      liquidSpecies{i} = mapSpecies(char(s(j)));
      fileNames{i} = mapFiles(char(s(j)));
      found = true;
      break;
    end
  end
  if(~found)
    error('Ids %d not found\n',Ids(i))
  end  
end

% p = 1; % [bar]
Tref = simscape.Value(298.15,'K');

CAS = cell(N,1);
Mw = simscape.Value(zeros(N,1),'g/mol');
dHf0 = simscape.Value(zeros(N,1),'kJ/mol');
dGf0 = simscape.Value(zeros(N,1),'kJ/mol');
dSf0 = simscape.Value(zeros(N,1),'kJ/(mol*K)'); % neu
S0 = simscape.Value(zeros(N,1),'kJ/(mol*K)');

% Koeffizienten sind dimensionslos, da sie #eqno und #mult enthalten
cp0 = zeros(N,7);
rho0 = zeros(N,7);
lambda0 = zeros(N,7);
mu0 = zeros(N,7);
pvap0 = zeros(N,7);
Hv0 = zeros(N,7);

Tc = simscape.Value(zeros(N,1),'K');
Tb = simscape.Value(zeros(N,1),'K');
pc = simscape.Value(zeros(N,1),'bar');
omega = simscape.Value(ones(N,1),'1');
charge = simscape.Value(zeros(N,1),'1');

for i=1:length(Ids)
  filename = sprintf("%s/%s.xml",database,fileNames{i});
  data = readstruct(filename);

  CAS{i} = char(data.CAS.valueAttribute);
  
  Mw(i) = simscape.Value(data.MolecularWeight.valueAttribute,...
    data.MolecularWeight.unitsAttribute);
 
  cp0(i,1) = data.LiquidHeatCapacityCp.eqno.valueAttribute;
  cp0(i,2) = simscape.Value(1,data.LiquidHeatCapacityCp.unitsAttribute)/...
    simscape.Value(1,'J/(mol*K)');
  cp0(i,3:end) = scanField(data.LiquidHeatCapacityCp);
  if(value(Tmin,'K')<data.LiquidHeatCapacityCp.Tmin.valueAttribute)
     warning('cp0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.LiquidHeatCapacityCp.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.LiquidHeatCapacityCp.Tmax.valueAttribute)
     warning('cp0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.LiquidHeatCapacityCp.Tmax.valueAttribute);
  end
  
  rho0(i,1) = data.LiquidDensity.eqno.valueAttribute;
  rho0(i,2) =  simscape.Value(1,strrep(data.LiquidDensity.unitsAttribute,'m3','m^3'))/...
    simscape.Value(1,'mol/l');
  rho0(i,3:end) = scanField(data.LiquidDensity);
  if(value(Tmin,'K')<data.LiquidDensity.Tmin.valueAttribute)
     warning('rho0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.LiquidDensity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.LiquidDensity.Tmax.valueAttribute)
     warning('rho0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.LiquidDensity.Tmax.valueAttribute);
  end

  dHf0(i) = simscape.Value(data.HeatOfFormation.valueAttribute,...
    data.HeatOfFormation.unitsAttribute);
      
  dGf0(i) = simscape.Value(data.GibbsEnergyOfFormation.valueAttribute,...
    data.GibbsEnergyOfFormation.unitsAttribute);
  dSf0(i) = (dHf0(i)-dGf0(i))/Tref;
  S0(i) =  simscape.Value(data.AbsEntropy.valueAttribute,...
    data.AbsEntropy.unitsAttribute);
        
  lambda0(i,1) = data.LiquidThermalConductivity.eqno.valueAttribute;
  lambda0(i,2) = simscape.Value(1,data.LiquidThermalConductivity.unitsAttribute)/...
    simscape.Value(1,'W/(m*K)');
  lambda0(i,3:end) = scanField(data.LiquidThermalConductivity);
   if(value(Tmin,'K')<data.LiquidThermalConductivity.Tmin.valueAttribute)
     warning('lamda0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.LiquidThermalConductivity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.LiquidThermalConductivity.Tmax.valueAttribute)
     warning('lambda0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.LiquidThermalConductivity.Tmax.valueAttribute);
  end
      
  mu0(i,1) = data.LiquidViscosity.eqno.valueAttribute;
  mu0(i,2) = simscape.Value(1,strrep(data.LiquidViscosity.unitsAttribute,'.','*'))/...
    simscape.Value(1,'Pa*s');
  mu0(i,3:end) = scanField(data.LiquidViscosity);
  if(value(Tmin,'K')<data.LiquidViscosity.Tmin.valueAttribute)
     warning('mu0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.LiquidViscosity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.LiquidViscosity.Tmax.valueAttribute)
     warning('mu0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.LiquidViscosity.Tmax.valueAttribute);
  end
  
  pvap0(i,1) = data.VaporPressure.eqno.valueAttribute;
  pvap0(i,2) = simscape.Value(1,strrep(data.VaporPressure.unitsAttribute,'.','*'))/...
    simscape.Value(1,'Pa');
  pvap0(i,3:end) = scanField(data.VaporPressure);
  if(value(Tmin,'K')<data.VaporPressure.Tmin.valueAttribute)
     warning('pvap0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.VaporPressure.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.VaporPressure.Tmax.valueAttribute)
     warning('pvap0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.VaporPressure.Tmax.valueAttribute);
  end

  Hv0(i,1) = data.HeatOfVaporization.eqno.valueAttribute;
  Hv0(i,2) = simscape.Value(1,strrep(data.HeatOfVaporization.unitsAttribute,'.','*'))/...
    simscape.Value(1,'kJ/mol');
  Hv0(i,3:end) = scanField(data.HeatOfVaporization);
  if(value(Tmin,'K')<data.HeatOfVaporization.Tmin.valueAttribute)
     warning('Hv0: %g - T(%g) < Tmin(%g)\n',Ids(i),...
     value(Tmin,'K'),data.HeatOfVaporization.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')>data.HeatOfVaporization.Tmax.valueAttribute)
     warning('Hv0: %g - T(%g) > Tmax(%g)\n',Ids(i),...
     value(Tmax,'K'),data.HeatOfVaporization.Tmax.valueAttribute);
  end
  
  Tc(i) = simscape.Value(data.CriticalTemperature.valueAttribute,...
    data.CriticalTemperature.unitsAttribute);
 
  Tb(i) = simscape.Value(data.NormalBoilingPointTemperature.valueAttribute,...
    data.NormalBoilingPointTemperature.unitsAttribute);

  pc(i) = simscape.Value(data.CriticalPressure.valueAttribute,...
    data.CriticalPressure.unitsAttribute);

  omega(i) = simscape.Value(data.AcentricityFactor.valueAttribute,'1');

  charge(i) = simscape.Value(data.Charge.valueAttribute,'1');
end

table_cp = simscape.Value(zeros(N,np),'J/(mol*K)');
table_Vm = simscape.Value(zeros(N,np),'l/mol');
table_H = simscape.Value(zeros(N,np),'kJ/mol');
table_S = simscape.Value(zeros(N,np),'kJ/(mol*K)');
table_G = simscape.Value(zeros(N,np),'kJ/mol');
table_mu = simscape.Value(zeros(N,np),'Pa*s');
table_lambda = simscape.Value(zeros(N,np),'W/(m*K)');
table_pvap = simscape.Value(zeros(N,np),'Pa');
table_Hv = simscape.Value(zeros(N,np),'kJ/mol');

S0Liquid = simscape.Value(zeros(N,1),'kJ/(mol*K)');
for i=1:N
  S0Liquid(i) = getHv(Hv0(i,:),value(Tc(i),'K'),value(Tb(i),'K'))./(Tb(i)+simscape.Value(eps,'K'));
end

for k=1:np
  table_cp(:,k) = getCp(cp0,value(Tc,'K'),value(table_T(k),'K'));
  table_Vm(:,k) = getVm(rho0,value(Tc,'K'),value(table_T(k),'K'));
  table_Hv(:,k) = getHv(Hv0,value(Tc,'K'),value(table_T(k),'K'));
  table_H(:,k) = getH(dHf0,cp0,value(Tc,'K'),value(table_T(k),'K'))-table_Hv(:,k);
  table_S(:,k) = getS(dSf0,cp0,value(Tc,'K'),value(table_T(k),'K'))-S0Liquid; 
  for i=1:N
    if(charge(i) ~= 0)
      table_G(i,k) = dGf0(i)-S0(i)*(table_T(k)-Tref);
    else
      table_G(i,k) = table_H(i,k)-table_T(k)*table_S(i,k);
    end
  end
  table_mu(:,k) = getMu(mu0,value(Tc,'K'),value(table_T(k),'K'));
  table_lambda(:,k) = getLambda(lambda0,value(Tc,'K'),value(table_T(k),'K'));
  table_pvap(:,k) = getPvap(pvap0,value(Tc,'K'),value(table_T(k),'K'));
end

propsLiquid.species = liquidSpecies;
propsLiquid.Ids = Ids;
propsLiquid.CAS = CAS;
propsLiquid.Mw = Mw;
propsLiquid.Tc = Tc;
propsLiquid.Tb = Tb;
propsLiquid.pc = pc;
propsLiquid.charge = charge;
propsLiquid.omega = omega;
propsLiquid.table_T = table_T;

% Achtung: die Properties müssen transponiert werden, wegen getProperty_T().
propsLiquid.table_cp = table_cp';
propsLiquid.table_H = table_H';
propsLiquid.table_S = table_S';
propsLiquid.table_G = table_G';
propsLiquid.table_Vm = table_Vm';
propsLiquid.table_mu = table_mu';
propsLiquid.table_lambda = table_lambda';
propsLiquid.table_Hv = table_Hv';
propsLiquid.table_pvap = table_pvap';

% schreibe den enumeration file 
fp = fopen(sprintf('%s/+ChemReactorDesign/+Basic/+Liquid/+enum/SelectedSpecies.m',getenv('root_CRD')),'w');
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
  fprintf(fp,sprintf('\t\t\tmap(''S%d'') = ''%s'';\n',i,liquidSpecies{i}));
end
fprintf(fp,'\t\tend\n');
fprintf(fp,'\tend\n');
fprintf(fp,'end\n'); 
fclose(fp);
end

