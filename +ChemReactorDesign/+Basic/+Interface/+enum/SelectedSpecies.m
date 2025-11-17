classdef SelectedSpecies < int32
	enumeration
		S1	(1)
		S2	(2)
	end
	methods (Static)
		function map = displayText()
			map = containers.Map;
			map('S1') = 'N2';
			map('S2') = 'O2';
		end
	end
end
