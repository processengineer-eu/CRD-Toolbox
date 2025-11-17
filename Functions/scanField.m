% Retrieving valueAttriutes for Data Set
%
% (c) Klaus Schnitzlein - 17.04.2025

function val = scanField(s)
  val = zeros(5,1);
  if(isfield(s,'A'))
    val(1) = s.A.valueAttribute;
  end
  if(isfield(s,'B'))
    val(2) = s.B.valueAttribute;
  end
  if(isfield(s,'C'))
    val(3) = s.C.valueAttribute;
  end
  if(isfield(s,'D'))
    val(4) = s.D.valueAttribute;
  end
  if(isfield(s,'E'))
    val(5) = s.E.valueAttribute;
  end
end

