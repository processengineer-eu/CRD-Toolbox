classdef RedoxType < int32
  % Enumeration class for Redox Type
  
  enumeration
    Reduction (1)
    Oxidation (2)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Reduction') = 'Cathodic Reduction';
      map('Oxidation') = 'Aniodic Oxidation';
    end
  end
end