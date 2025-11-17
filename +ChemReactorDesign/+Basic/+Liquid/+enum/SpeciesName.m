% Enumeration Class for Liquid Species and Electrolytes
%
% (c) Klaus Schnitzlein - 27.03.2025

classdef SpeciesName < int32
  enumeration
    None (0)
    H2O (1)
		CH3OH (2)
    C2H5OH (3)
    C3H6O (4)
    K_p (5)
		Cl_m (6)
    Cl2_aq (7)
		Cu_2p (8)
		SO4_2m (9)
		FeCN6_3m (10)
		FeCN6_4m (11)
    A1 (12)
    A2 (13)
    A3 (14)
    A4 (15)
    RuNH36_2p (16)
    RuNH36_3p (17)
    C6H6 (18)
    C2H4O2 (19)
    CH3CHO (20)
    Ag_p (21)
    H_p (22)
  end
  methods (Static) 
    
		function map = displayText()
			map = containers.Map;
			map('None') = ' ';
      map('H2O') = 'H2O';
      map('CH3OH') = 'CH3OH';
      map('C2H5OH') = 'C2H5OH';
      map('C3H6O') = 'C3H6O';
      map('K_p') = 'K^+';
			map('Cl_m') = 'Cl^-';
      map('Cl2_aq') = 'Cl2(aq)';
			map('Cu_2p') = 'Cu^2+';
			map('SO4_2m') = 'SO4^2-';
			map('FeCN6_3m') = 'Fe(CN)6^3-';
			map('FeCN6_4m') = 'Fe(CN)6^4-';
      map('A1') = 'A1';
      map('A2') = 'A2';
      map('A3') = 'A3';
      map('A4') = 'A4';
      map('RuNH36_2p') = 'Ru(NH3)6^2+';
      map('RuNH36_3p') = 'Ru(NH3)6^3+';
      map('C6H6') = 'C6H6';
      map('C2H4O2') = 'C2H4O2';
      map('CH3CHO') = 'CH3CHO';
      map('Ag_p') = 'Ag^+';
      map('H_p')= 'H^+';
    end

    function map = displayFileName()
			map = containers.Map;
			map('None') = ' ';
      map('H2O') = 'Water';
      map('CH3OH') = 'Methanol';
      map('C2H5OH') = 'Ethanol';
      map('C3H6O') = 'Acetone';
      map('K_p') = 'Potassium_cation';
			map('Cl_m') = 'Chloride';
      map('Cl2_aq') = 'Chlorine_aq';
			map('Cu_2p') = 'Copper_cation2';
			map('SO4_2m') = 'Sulfate_anion2';
			map('FeCN6_3m') = 'HexacyanoferratIII';
			map('FeCN6_4m') = 'HexacyanoferratII';
      map('A1') = 'A1';
      map('A2') = 'A2';
      map('A3') = 'A3';
      map('A4') = 'A4';
      map('RuNH36_2p') = 'HexaaminrutheniumII';
      map('RuNH36_3p') = 'HexaaminrutheniumIII';
      map('C6H6') = 'Benzene';
      map('C2H4O2') = 'Methyl_formate';
      map('CH3CHO') = 'Acetaldehyde';
      map('Ag_p') = 'Silver_cation';
      map('H_p') = 'Hydrogen_cation';
    end
	end
end
