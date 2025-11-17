classdef FlowOut < int32
  % Enumeration class for Flow Output
  
  enumeration
    Current(1)
    Standard(2)
    Off(3)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Current') = 'Current';
      map('Standard') = 'Standard';
      map('Off') = 'Off';
    end
  end
end
