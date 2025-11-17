function Hv = getHv(Hv0,Tc,T)

% Calculation of Heat of Vaporization
% (c) Klaus Schnitzlein - 27.03.2025

N = size(Hv0,1);
eqno = Hv0(:,1);
mult = Hv0(:,2);
coeff = Hv0(:,3:end);
Hv = simscape.Value(zeros(N,1),'kJ/mol'); 
for i=1:N
  Hv(i) = simscape.Value(mult(i)*getProperty_T(eqno(i),coeff(i,:),Tc(i),T),'kJ/mol');
end
end