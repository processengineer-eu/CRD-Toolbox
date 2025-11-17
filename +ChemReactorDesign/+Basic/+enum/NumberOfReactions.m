classdef NumberOfReactions < int32
	enumeration
    one (1)
    two (2)
    three (3)
  end
	methods (Static, Hidden)
	function map = displayText()
	    map = containers.Map;
            map('one') = '1';
            map('two') = '2';
	    map('three') = '3';
        end
end
end
