function [Ids,Mw,Dv,table_T,table_cp,table_H,table_G,table_mu,table_lambda,k0] = ...
  checkGasSpecies5(model,Tmin,Tmax,nT,N,A1,A2,A3,A4,A5)
% Generiere die LookUp-Tables für maximal fünf Spezies
% alle Argumente sind dimensionslos
%
% (c) Klaus Schnitzlein - 17.11.2025

% fprintf('function checkGasSpecies called - N=%d\n',N);

% nehme die Enumeration aus dem Pfad
s = enumeration('ChemReactorDesign.Basic.Gas.enum.SpeciesName');

% enumeration values
A = [A1,A2,A3,A4,A5];
A = A(1:N);

Ids = zeros(N,1); 
for i=1:N
  k = find(s == A(i));
  if(k)
    Ids(i) = s(k);
  else
    error('Enumeration %s not found\n',A(i))
  end
end  

table_T = linspace(simscape.Value(Tmin,'K'),simscape.Value(Tmax,'K'),nT);
propsGas = getPropertiesGasTable(table_T,Ids);
Ids = propsGas.Ids;
Mw = value(propsGas.Mw,'g/mol');
Dv = value(propsGas.Dv,'1');
table_T = value(propsGas.table_T,'K');
table_cp = value(propsGas.table_cp,'J/(mol*K)');
table_H = value(propsGas.table_H,'kJ/mol');
table_G = value(propsGas.table_G,'kJ/mol');
table_mu = value(propsGas.table_mu,'Pa*s');
table_lambda = value(propsGas.table_lambda,'W/(m*K)');

if(model == ChemReactorDesign.Basic.Gas.enum.ThermodynamicModel.PengRobinson)
  k0 = getPropertiesPR(propsGas);
else
  k0 = zeros(N,N);
end
propsGas.k0 = k0;

% speichere die Properties vorübergehend im Matlab Workspace
if(~isempty(gcs))
  % bdroot(gcs) % das ist das aktuelle Model
  % save(bdroot(gcs)+".mat",'propsGas');
  assignin('base','propsGas',propsGas);
end

% compile/update model
% set_param(gcs, 'SimulationCommand', 'update')
end
