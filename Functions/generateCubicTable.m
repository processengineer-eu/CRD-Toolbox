function table_zdd = generateCubicTable

  % Generate Interpolation Tables for Cubic Equations
  % (c) Klaus Schnitzlein - 17.05.2025

  table_yndh = -10:0.01:10; 
  np = length(table_yndh);
  table_zdd = zeros(np,4);

  for i=1:np
    table_zdd(i,:) = [table_yndh(i),calculate(table_yndh(i))];
  end
end

function sol = calculate(yndh)
  if(-1 <= yndh && yndh <= 1)  % three real roots
    theta = acos(-yndh);
    sol(1) = 2*cos(theta/3);
    sol(2) = 2*cos((theta+2*pi)/3);
    sol(3) = 2*cos((theta+4*pi)/3);
  elseif(abs(yndh) > 1) % one real root
    help = sign(yndh^2-1)*sqrt(abs(yndh^2-1));
    sol(1) = nthroot(-yndh+help,3)+...
             nthroot(-yndh-help,3);
    sol(2) = sol(1);
    sol(3) = sol(2);
  end
end
