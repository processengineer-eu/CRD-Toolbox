function cp = getCp(cp0,Tc,T)

% Calculation of Molar Heat Capacities
% (c) Klaus Schnitzlein - 27.03.2025

N = size(cp0,1);
cp = simscape.Value(zeros(N,1),'J/(mol*K)');
eqno = cp0(:,1);
mult = cp0(:,2);
coeff = cp0(:,3:end);
cpfun = @(i,T) mult(i).*getProperty_T(eqno(i),coeff(i,:),Tc(i),T);
for i=1:N
  cp(i) = simscape.Value(cpfun(i,T), 'J/(mol*K)');
end
end
