classdef FunctionGeneratorMode < int32
  % Enumeration class for function generator
  % Copyright Klaus Schnitzlein - 01.09.21
  
  enumeration
    constant(1)
    step(2)
    ramp(3)
    triangle(4)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('constant') = 'constant';
      map('step') = 'step';
      map('ramp') = 'ramp';
      map('triangle') = 'triangle';
    end
  end
end