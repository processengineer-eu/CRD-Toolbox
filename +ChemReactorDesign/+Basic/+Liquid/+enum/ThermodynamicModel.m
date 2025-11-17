classdef ThermodynamicModel < int32
  % Enumeration class for thermodynamic model (Liquid Phase)
  
  enumeration
    Ideal(0)
    NRTL(1)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Ideal') = 'Ideal Liquid';
      map('NRTL') = 'Real Liquid (NRTL)';
    end
  end
end