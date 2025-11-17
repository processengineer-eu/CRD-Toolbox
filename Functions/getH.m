function H = getH(dHf0,cp0,Tc,T)

% Calculation of Molar Enthalpies
% (c) Klaus Schnitzlein - 27.03.2025

N = length(dHf0);
Tref = 298.15;
eqno = cp0(:,1);
mult = cp0(:,2);
coeff = cp0(:,3:end);
H = simscape.Value(zeros(N,1),'kJ/mol');
for i=1:N
  cpfun = @(T) mult(i).*getProperty_T(eqno(i),coeff(i,:),Tc(i),T);
  H(i) = dHf0(i)+simscape.Value(integral(cpfun,Tref,T),'J/mol');
end
end
