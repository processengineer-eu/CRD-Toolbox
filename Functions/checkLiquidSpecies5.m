function [Ids,Mw,charge,table_T,table_cp,table_H,table_G,table_Vm,table_mu,table_lambda,table_Hv,table_pvap,A,alpha] = ...
  checkLiquidSpecies5(model,Tmin,Tmax,nT,N,A1,A2,A3,A4,A5)
% Generiere die LookUp-Tables für maximal fünf Spezies
% alle Argumente sind dimensionslos
%
% (c) Klaus Schnitzlein - 28.04.2025

% fprintf('function checkLiquidSpecies called - N=%d\n',N);

% nehme die Enumeration aus dem Pfad
s = enumeration('ChemReactorDesign.Basic.Liquid.enum.SpeciesName');

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
propsLiquid = getPropertiesLiquidTable(table_T,Ids);
Ids = propsLiquid.Ids;
Mw = value(propsLiquid.Mw,'g/mol');
charge = value(propsLiquid.charge,'1');
table_T = value(propsLiquid.table_T,'K');
table_cp = value(propsLiquid.table_cp,'J/(mol*K)');
table_H = value(propsLiquid.table_H,'kJ/mol');
table_G = value(propsLiquid.table_G,'kJ/mol');
table_Vm = value(propsLiquid.table_Vm,'l/mol');
table_mu = value(propsLiquid.table_mu,'Pa*s');
table_lambda = value(propsLiquid.table_lambda,'W/(m*K)');
table_pvap = value(propsLiquid.table_pvap,'Pa');
table_Hv = value(propsLiquid.table_Hv,'kJ/mol');

if(model == ChemReactorDesign.Basic.Liquid.enum.ThermodynamicModel.NRTL)
  [tmp_A,alpha] = getPropertiesNRTL(propsLiquid);
  A = value(tmp_A,'cal/mol'); % Rückgabewert muss dimlos sein
  propsLiquid.A = tmp_A;
else
  A = eye(N,N);
  alpha = zeros(N,N);
  propsLiquid.A = A;
end
propsLiquid.alpha = alpha;

% speichere die Properties vorübergehend im Matlab Workspace
if(~isempty(gcs))
  % bdroot(gcs) % das ist das aktuelle Model
  % save(bdroot(gcs)+".mat",'propsLiquid');
  assignin('base','propsLiquid',propsLiquid);
end
end
