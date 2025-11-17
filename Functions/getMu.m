function mu = getMu(mu0,Tc,T)

% Calculation of Dynamic Viscosities
% (c) Klaus Schnitzlein - 27.03.2025

N = size(mu0,1);
mu = simscape.Value(zeros(N,1),'Pa*s'); 
eqno = mu0(:,1);
mult = mu0(:,2);
coeff = mu0(:,3:end);
for i=1:N
  mu(i) = simscape.Value(mult(i)*getProperty_T(eqno(i),coeff(i,:),Tc(i),T),'Pa*s');
end
end
