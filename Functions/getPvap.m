function pvap = getPvap(pvap0,Tc,T)

% Calculation of Saturation Pressure Table
% (c) Klaus Schnitzlein - 27.03.2025

N = size(pvap0,1);
pvap = simscape.Value(zeros(N,1),'Pa'); 
eqno = pvap0(:,1);
mult = pvap0(:,2);
coeff = pvap0(:,3:end);
for i=1:N
  pvap(i) = simscape.Value(mult(i)*getProperty_T(eqno(i),coeff(i,:),Tc(i),T),'Pa');
end
end
