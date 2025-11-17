function lambda = getLambda(lambda0,Tc,T)

% Calculation of Thermal Conductivities
% (c) Klaus Schnitzlein - 27.03.2025

N = size(lambda0,1);
lambda = simscape.Value(zeros(N,1),'W/(m*K)'); 
eqno = lambda0(:,1);
mult = lambda0(:,2);
coeff = lambda0(:,3:end);
for i=1:N
  lambda(i) = simscape.Value(mult(i)*getProperty_T(eqno(i),coeff(i,:),Tc(i),T),'W/(m*K)');
end
end
