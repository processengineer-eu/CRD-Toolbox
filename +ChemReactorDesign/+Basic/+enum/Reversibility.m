classdef Reversibility < int32
  % Enumeration class for reversibility
  
  enumeration
    Irreversible(1)
    Reversible(2)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Irreversible') = 'Irreversible';
      map('Reversible') = 'Reversible';
    end
  end
end