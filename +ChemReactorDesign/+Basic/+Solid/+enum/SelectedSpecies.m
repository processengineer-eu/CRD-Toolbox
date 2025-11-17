classdef SelectedSpecies < int32
	enumeration
		S1	(5)
		S2	(5)
	end
	methods (Static)
		function map = displayText()
			map = containers.Map;
			map('S1') = 'C';
			map('S2') = 'C';
		end
	end
end
