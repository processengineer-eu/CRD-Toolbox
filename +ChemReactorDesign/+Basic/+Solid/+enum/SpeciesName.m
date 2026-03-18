% Enumeration Class for Solid Species
%
% (c) Klaus Schnitzlein - 12.01.2026

classdef SpeciesName < int32
  enumeration
    None (0)
    V (1) 
    FeS2 (2)
    Ni (3)
    Fe (4)
    C (5)
    AgCl (6)
    Fe2O3 (7)
    Fe3O4 (8)
    Al2O3 (9)
    SiO2 (10)
    Cu (11)
    Ag (12)
  end
  methods (Static) 
    
		function map = displayText()
			map = containers.Map;
			map('None') = ' ';
      map('V') = 'V';
      map('FeS2') = 'FeS2';
      map('Ni') = 'Ni';
      map('Fe') = 'Fe';
      map('C') = 'C';
      map('AgCl') = 'AgCl';
      map('Fe2O3') = 'Fe2O3';
      map('Fe3O4') = 'Fe3O4';
      map('Al2O3') = 'Al2O3';
      map('SiO2') = 'SiO2';
      map('Cu') = 'Cu';
      map('Ag') = 'Ag';
    end

    function map = displayFileName()
			map = containers.Map;
			map('None') = ' ';
      map('V') = 'Vanadium';
      map('FeS2') = 'Pyrite';
      map('Nickel') = 'Nickel';
      map('Fe') = 'Iron';
      map('C') = 'Graphite';
      map('AgCl') = 'Silver_chloride';
      map('Fe2O3') = 'IronIII_oxide';
      map('Fe3O4') = 'IronII_III_oxide';
      map('Al2O3') = 'Aluminum_oxide';
      map('SiO2') = 'Silicon_oxide';
      map('Cu') = 'Copper';
      map('Ag') = 'Silver';
    end
	end
end
