classdef ThermodynamicModel < int32
  % Enumeration class for thermodynamic model
  
  enumeration
    IdealGas(0)
    PengRobinson(1)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('IdealGas') = 'Ideal Gas';
      map('PengRobinson') = 'Real Gas (Peng-Robinson EoS)';
    end
  end
end