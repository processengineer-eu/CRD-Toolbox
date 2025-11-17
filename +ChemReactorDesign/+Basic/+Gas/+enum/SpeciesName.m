% Enumeration Class for Gas Species
%
% (c) Klaus Schnitzlein - 12.05.2025

classdef SpeciesName < int32
  enumeration
    None (0)
    N2 (1)
		O2 (2)
    H2 (3)
    Ar (4)
    H2O (5)
    CO (6)
    CO2 (7)
    CH4 (8)
    CH3OH (9)
    CH3CHO (10)
    C2H5OH (11)
    C2H4O (12)
    C3H6 (13)
    C3H4O (14)
    C3H4O2 (15)
    H2S (16)
    C4H4S (17)
    C4H8 (18)
    C4H10 (19)
    CH2O (20)
    C6H14 (21)
    C7H16 (22)
    C6H6 (23)
    C2H4 (24)
    NO2 (25)
    N2O4 (26)
    C2H2 (27)
    C2H6 (28)
  end
  methods (Static) 
    
		function map = displayText()
			map = containers.Map;
			map('None') = ' ';
      map('N2') = 'N2';
      map('O2') = 'O2';
      map('H2') = 'H2';
      map('Ar') = 'Ar';
      map('H2O') = 'H2O';
      map('CO') = 'CO';
      map('CO2') = 'CO2';
      map('CH4') = 'CH4';
      map('CH3OH') = 'CH3OH';
      map('CH3CHO') = 'CH3CHO';
      map('C2H5OH') = 'C2H5OH';
      map('C2H4O') = 'C2H4O';
      map('C3H6') = 'C3H6';
      map('C3H4O') = 'C3H4O';
      map('C3H4O2') = 'C3H4O2';
      map('H2S') = 'H2S';
      map('C4H4S') = 'C4H4S';
      map('C4H8') = 'C4H8';
      map('C4H10') = 'C4H10';
      map('CH2O') = 'CH2O';
      map('C6H14') = 'C6H14';
      map('C7H16') = 'C7H16';
      map('C6H6') = 'C6H6';
      map('C2H4') = 'C2H4';
      map('NO2') = 'NO2';
      map('N2O4') = 'N2O4';
      map('C2H2') = 'C2H2';
      map('C2H6') = 'C2H6';
    end

    function map = displayFileName()
			map = containers.Map;
			map('None') = ' ';
      map('N2') = 'Nitrogen';
      map('O2') = 'Oxygen';
      map('H2') = 'Hydrogen';
      map('Ar') = 'Argon';
      map('H2O') = 'Water';
      map('CO') = 'Carbon_monoxide';
      map('CO2') = 'Carbon_dioxide';
      map('CH4') = 'Methane';
      map('CH3OH') = 'Methanol';
      map('CH3CHO') = 'Acetaldehyde';
      map('C2H5OH') = 'Ethanol';
      map('C2H4O') = 'Ethylene_oxide';
      map('C3H6') = 'Propylene';
      map('C3H4O') = 'Acrolein';
      map('C3H4O2') = 'Acrylic_acid';
      map('H2S') = 'Hydrogen_sulfide';
      map('C4H4S') = 'Thiophene';
      map('C4H8') = '1-butene';
      map('C4H10') = 'N-butane';
      map('CH2O') = 'Formaldehyde';
      map('C6H14') = 'N-hexane';
      map('C7H16') = 'N-heptane';
      map('C6H6') = 'Benzene';
      map('C2H4') = 'Ethylene';
      map('NO2') = 'Nitrogen_dioxide';
      map('N2O4') = 'Nitrogen_tetroxide';
      map('C2H2') = 'Acetylene';
      map('C2H6') = 'Ethane';
    end
	end
end
