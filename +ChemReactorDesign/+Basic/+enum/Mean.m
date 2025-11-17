classdef Mean < int32
  % Enumeration class for mean 
  
  enumeration
    Average(1)
    Harmonic(2)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Average') = 'Average';
      map('Harmonic') = 'Harmonic';
    end
  end
end