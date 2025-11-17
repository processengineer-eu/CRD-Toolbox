% Enumeration Class for Solid Species
%
% (c) Klaus Schnitzlein - 29.09.2025

classdef SpeciesName < int32
  enumeration
    None (0)
    Vanadium (1) 
    Pyrite (2)
    Nickel (3)
    Iron (4)
    Graphite (5)
    AgCl (6)
    Fe2O3 (7)
    Al2O3 (8)
    SiO2 (9)
    Cu (10)
    Ag (11)
  end
  methods (Static) 
    
		function map = displayText()
			map = containers.Map;
			map('None') = ' ';
      map('Vanadium') = 'V';
      map('Pyrite') = 'FeS2';
      map('Nickel') = 'Ni';
      map('Iron') = 'Fe';
      map('Graphite') = 'C';
      map('AgCl') = 'AgCl';
      map('Fe2O3') = 'Fe2O3';
      map('Al2O3') = 'Al2O3';
      map('SiO2') = 'SiO2';
      map('Cu') = 'Cu';
      map('Ag') = 'Ag';
    end

    function map = displayFileName()
			map = containers.Map;
			map('None') = ' ';
      map('Vanadium') = 'Vanadium';
      map('Pyrite') = 'Pyrite';
      map('Nickel') = 'Nickel';
      map('Iron') = 'Iron';
      map('Graphite') = 'Graphite';
      map('AgCl') = 'Silver_chloride';
      map('Fe2O3') = 'Iron_oxide';
      map('Al2O3') = 'Aluminum_oxide';
      map('SiO2') = 'Silicon_oxide';
      map('Cu') = 'Copper';
      map('Ag') = 'Silver';
    end
	end
end
