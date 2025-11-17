% Enumeration Class for Interface Species
%
% (c) Klaus Schnitzlein - 05.05.2025

classdef SpeciesName < int32
  enumeration
    None (0)
    N2 (1)
    O2 (2)
    H2 (3)
    H2O (4)
    CO (5)
    CO2 (6)
    CH4 (7)
    C2H6 (8)
    C3H7OH (9)
    C4H8 (10)
    C4H10 (11)
    C6H6 (12)
    C7H16 (13)
    N2O (14)
  end
  methods (Static) 
    
		function map = displayText()
			map = containers.Map;
			map('None') = ' ';
      map('N2') = 'N2';
      map('O2') = 'O2';
      map('H2') = 'H2';
      map('H2O') = 'H2O';
      map('CO') = 'CO';
      map('CO2') = 'CO2';
      map('CH4') = 'CH4';
      map('C2H6') = 'C2H6';
      map('C3H7OH') = 'C3H7OH';
      map('C4H8') = 'C4H8';
      map('C4H10') = 'C4H10';
      map('C6H6') = 'C6H6';
      map('C7H16') = 'C7H16';
      map('N2O') = 'N2O';
    end
    
    function map = displayFileName()
			map = containers.Map;
			map('None') = ' ';
      map('N2') = 'Nitrogen';
      map('O2') = 'Oxygen';
      map('H2') = 'Hydrogen';
      map('H2O') = 'Water';
      map('CO') = 'Carbon_monoxide';
      map('CO2') = 'Carbon_dioxide';
      map('CH4') = 'Methane';
      map('C2H6') = 'Ethane';
      map('C3H7OH') = 'Propanol';
      map('C4H8') = '1-Butene';
      map('C4H10') = 'Butane';
      map('C6H6') = 'Benzene';
      map('C7H16') = 'n-Heptane';
      map('N2O') = 'Nitrous_oxide';
    end
  end
end
