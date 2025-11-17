classdef OnOff < int32
  % Enumeration class for OnOff
  
  enumeration
    Off(0)
    On(1)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Off') = 'Off';
      map('On') = 'On';
    end
  end
end