classdef SelectedSpecies < int32
	enumeration
		S1	(1)
		S2	(1)
	end
	methods (Static)
		function map = displayText()
			map = containers.Map;
			map('S1') = 'H2O';
			map('S2') = 'H2O';
		end
	end
end
