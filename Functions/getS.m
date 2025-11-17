function S = getS(S0,cp0,Tc,T)

% Calculation of Entropies
% (c) Klaus Schnitzlein - 27.03.2025

N = length(S0);
Tref = 298.15;
eqno = cp0(:,1);
mult = cp0(:,2);
coeff = cp0(:,3:end);
S = simscape.Value(zeros(N,1),'kJ/(mol*K)');
for i=1:N
  fun = @(T) mult(i).*getProperty_T(eqno(i),coeff(i,:),Tc(i),T)./T;
  S(i) = S0(i)+simscape.Value(integral(fun,Tref,T),'J/(mol*K)');
end
end
