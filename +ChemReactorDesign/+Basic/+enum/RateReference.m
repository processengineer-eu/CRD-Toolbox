classdef RateReference < int32
  % Enumeration class for rate reference
  
  enumeration
    Volume(1)
    Area(2)
    Mass(3)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Volume') = 'Volume';
      map('Area') = 'Area';
      map('Mass') = 'Mass';
    end
  end
end