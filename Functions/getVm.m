% Calculation of Molar Volumes
% (c) Klaus Schnitzlein - 27.03.2025

function Vm = getVm(rho0,Tc,T)

N = size(rho0,1);
Vm = simscape.Value(zeros(N,1),'l/mol'); 
eqno = rho0(:,1);
mult = rho0(:,2);
coeff = rho0(:,3:end);
% Elektrolyte besitzen keine Dichte und kein molares Volumen
for i=1:N
  rho = simscape.Value(mult(i)*getProperty_T(eqno(i),coeff(i,:),Tc(i),T),'mol/l');
  if(rho == 0) 
    Vm(i) = simscape.Value(0,'l/mol');
  else
    Vm(i) = 1/rho;
  end
end
end
