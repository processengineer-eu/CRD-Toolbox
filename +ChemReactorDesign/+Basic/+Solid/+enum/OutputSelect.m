classdef OutputSelect < int32
  % Enumeration class for InterfaceOutput
  
  enumeration
    None (1)
    MoleFractions (2)
    Concentrations (3)
    Densities (4)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('None') = 'None';
      map('MoleFractions') = 'MoleFractions';
      map('Concentrations') = 'Concentrations';
      map('Densities') = 'Densities';
    end
  end
end