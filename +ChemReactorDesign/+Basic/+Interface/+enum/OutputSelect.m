classdef OutputSelect < int32
  % Enumeration class for InterfaceOutput
  
  enumeration
    gamma (1)
    Theta (2)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('gamma') = 'SurfaceConcentrations';
      map('Theta') = 'FractionalCoverages';
    end
  end
end