classdef ReferenceVelocity < int32
  % Enumeration class for reference velocity for diffusion
  
  enumeration
    molarAverage(1)
    solvent(2)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('molarAverage') = 'molarAverage';
      map('solvent') = 'solventVelocity';
    end
  end
end