classdef RateFormulatedInTermsOf < int32
  % Enumeration class for RateFormulatedInTermsOf
  
  enumeration
    Concentrations(1)
    MoleFractions(2)
  end
  
  methods (Static, Hidden)
    function map = displayText()
      map = containers.Map;
      map('Concentrations') = 'Concentrations';
      map('MoleFractions') = 'MoleFractions';
    end
  end
end