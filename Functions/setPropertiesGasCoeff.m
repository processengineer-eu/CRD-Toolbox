function [cp0,dHf0,S0,mu0,lambda0] = setPropertiesGasCoeff(Trange,model,species,blockname)

% Set Species Properties of Gas Domain via Coefficients
% Usage: setPropertiesGas(model,species,blockname)
%
% (c) Klaus Schnitzlein - 10.01.2025

database = sprintf('%s/Data',getenv('root_CRD'));
Tmin = Trange(1);
Tmax = Trange(2);
N = length(species);
Ids = zeros(N,1);
Mw = simscape.Value(zeros(N,1),'g/mol');
cp0 = zeros(N,7);
dHf0 = simscape.Value(zeros(N,1),'kJ/mol');
dGf0 = simscape.Value(zeros(N,1),'kJ/mol');
S0 = simscape.Value(zeros(N,1),'kJ/(mol*K)');
lambda0 = zeros(N,7);
mu0 = zeros(N,7);
Dv = simscape.Value(zeros(N,1),'1');
Tc = simscape.Value(zeros(N,1),'K');
formula = zeros(N,50); % maximale Länge

for i=1:length(species)
  filename = sprintf("%s/%s.xml",database,species{i});
  data = readstruct(filename);

  name = char(data.StructureFormula.valueAttribute);
  formula(i,1:length(name)) = name;
  structure = cellstr(char(formula))'; 
  
  Ids(i) = double(data.LibraryIndex.valueAttribute);

  Mw(i) = simscape.Value(data.MolecularWeight.valueAttribute,...
    data.MolecularWeight.unitsAttribute);
    
  cp0(i,1) = data.IdealGasHeatCapacityCp.eqno.valueAttribute;
  cp0(i,2) = simscape.Value(1,data.IdealGasHeatCapacityCp.unitsAttribute)/...
    simscape.Value(1,'J/(mol*K)');
  cp0(i,3:end) = [data.IdealGasHeatCapacityCp.A.valueAttribute...
    data.IdealGasHeatCapacityCp.B.valueAttribute...
    data.IdealGasHeatCapacityCp.C.valueAttribute...
    data.IdealGasHeatCapacityCp.D.valueAttribute...
    data.IdealGasHeatCapacityCp.E.valueAttribute];
  if(value(Tmin,'K')<data.IdealGasHeatCapacityCp.Tmin.valueAttribute)
     warning('cp0: %s - T(%g) < Tmin(%g)\n',species{i},...
     value(Tmin,'K'),data.IdealGasHeatCapacityCp.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')<data.IdealGasHeatCapacityCp.Tmin.valueAttribute)
     warning('cp0: %s - T(%g) > Tmax(%g)\n',species{i},...
     value(Tmax,'K'),data.IdealGasHeatCapacityCp.Tmin.valueAttribute);
  end
  
  dHf0(i) = simscape.Value(data.HeatOfFormation.valueAttribute,...
    data.HeatOfFormation.unitsAttribute);
      
  dGf0(i) = simscape.Value(data.GibbsEnergyOfFormation.valueAttribute,...
    data.GibbsEnergyOfFormation.unitsAttribute);
        
  S0(i) =  simscape.Value(data.AbsEntropy.valueAttribute,...
    data.AbsEntropy.unitsAttribute);
        
  lambda0(i,1) = data.VaporThermalConductivity.eqno.valueAttribute;
  lambda0(i,2) = simscape.Value(1,data.VaporThermalConductivity.unitsAttribute)/...
    simscape.Value(1,'W/(m*K)');
  lambda0(i,3:6) = [data.VaporThermalConductivity.A.valueAttribute...
    data.VaporThermalConductivity.B.valueAttribute...
    data.VaporThermalConductivity.C.valueAttribute...
    data.VaporThermalConductivity.D.valueAttribute];
  if(value(Tmin,'K')<data.VaporThermalConductivity.Tmin.valueAttribute)
     warning('lamda0: %s- T(%g) < Tmin(%g)\n',species{i},...
     value(Tmin,'K'),data.VaporThermalConductivity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')<data.VaporThermalConductivity.Tmin.valueAttribute)
     warning('cp0: %s - T(%g) > Tmax(%g)\n',species{i},...
     value(Tmax,'K'),data.VaporThermalConductivity.Tmin.valueAttribute);
  end
      
  mu0(i,1) = data.VaporViscosity.eqno.valueAttribute;
  mu0(i,2) = simscape.Value(1,strrep(data.VaporViscosity.unitsAttribute,'.','*'))/...
    simscape.Value(1,'Pa*s');
  mu0(i,3:6) = [data.VaporViscosity.A.valueAttribute...
    data.VaporViscosity.B.valueAttribute...
    data.VaporViscosity.C.valueAttribute...
    data.VaporViscosity.D.valueAttribute];
  if(value(Tmin,'K')<data.VaporViscosity.Tmin.valueAttribute)
     warning('mu0: %s - T(%g) < Tmin(%g)\n',species{i},...
     value(Tmin,'K'),data.VaporViscosity.Tmin.valueAttribute);
  end
  if(value(Tmax,'K')<data.VaporViscosity.Tmin.valueAttribute)
     warning('mu0: %s - T(%g) > Tmax(%g)\n',species{i},...
     value(Tmax,'K'),data.VaporViscosity.Tmin.valueAttribute);
  end
  
  % Dv(i) = simscape.Value(data.FullerVolume.valueAttribute,...
  %   strrep(data.FullerVolume.unitsAttribute,'_','1'));
  % 
  % Tc(i) = value(simscape.Value(data.CriticalTemperature.valueAttribute,...
  %   data.CriticalTemperature.unitsAttribute),'K');
end

if(strlength(model) > 0)
  setBlockData(model,blockname,...
    'N',N,...
    'Ids',Ids,...
    'Mw',Mw,...
    'cp0',cp0,...
    'mu0',mu0,...
    'lambda0',lambda0,...
    'dHf0',dHf0,...
    'S0',S0);
end
end

