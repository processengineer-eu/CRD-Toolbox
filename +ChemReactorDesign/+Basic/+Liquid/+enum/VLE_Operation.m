classdef VLE_Operation < int32
  % Enumeration class for VLE operation mode

  enumeration
    Evaporation(1)
    Boiling(2)
  end

  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Evaporation') = 'Evaporation';
      map('Boiling') = 'Boiling';
    end
  end
end