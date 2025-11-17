classdef SelectedSpecies < int32
	enumeration
		S1	(2)
		S2	(1)
	end
	methods (Static)
		function map = displayText()
			map = containers.Map;
			map('S1') = 'O2';
			map('S2') = 'N2';
		end
	end
end
