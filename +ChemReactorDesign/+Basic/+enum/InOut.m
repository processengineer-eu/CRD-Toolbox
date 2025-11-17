classdef InOut < int32
  % Enumeration class for Input/Output
  
  enumeration
    Input(1)
    Output(2)
    Off(3)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Input') = 'Input';
      map('Output') = 'Output';
      map('Off') = 'Off';
    end
  end
end