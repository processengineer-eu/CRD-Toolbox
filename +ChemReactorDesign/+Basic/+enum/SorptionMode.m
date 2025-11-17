classdef SorptionMode < int32
  % Enumeration class for sorption
  %
  % (c) Klaus Schnitzlein - 11.02.2025
  
  enumeration
    Langmuir(1)
    Frumkin(2)
    Tempkin(3)
    Linear(4)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Langmuir') = 'Langmuir';
      map('Frumkin') = 'Frumkin';
      map('Tempkin') = 'Tempkin';
      map('Linear') = 'Linear';
    end
  end
end