classdef SelectedSpecies < int32
	enumeration
		S1	(12)
		S2	(13)
		S3	(1)
	end
	methods (Static)
		function map = displayText()
			map = containers.Map;
			map('S1') = 'A1';
			map('S2') = 'A2';
			map('S3') = 'H2O';
		end
	end
end
