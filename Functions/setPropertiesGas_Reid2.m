function setPropertiesGas_Reid2(model,species,block)
% Set Properties of Gas Species after Reid et al.
%
% (c) Klaus Schnitzlein - 22.02.2024
% 

species = strrep(species,'(g)',''); % strip '(g)' if present
N = length(species);

database = '~/Matlab/Simscape/ToolBox_V1/Data/Properties_of_Gases.csv';
Ids = retrieveIds(species,database);
Mw = retrieveData(species,'MOLWT',database);
cp0 = convert([retrieveData(species,'CPVAPA',database),...
                 retrieveData(species,'CPVAPB',database),...
                 retrieveData(species,'CPVAPC',database),...
                 retrieveData(species,'CPVAPD',database)],'J/(mol*K)');
vis0 = [retrieveData(species,'VISA',database),....
        retrieveData(species,'VISB',database)];
lambda0 = retrieveData(species,'LAMBDA',database);
dHf0 = retrieveData(species,'DELHF',database);
dGf0 = retrieveData(species,'DELGF',database);
dS0 = (dHf0-dGf0)/simscape.Value(298.15,'K');

np = 2;
table_p = simscape.Value([0.1,10],'bar');
nT = 10;
table_T = simscape.Value(linspace(298,373,nT),'K');

table_mu = simscape.Value(zeros(np,nT,N),'Pa*s');
table_lambda = simscape.Value(zeros(np,nT,N),'W/(m*K)');
for k=1:N
  for i=1:np
    for j=1:nT
      table_lambda(i,j,k) = lambda0(k);
    end
  end
end
table_cp = simscape.Value(zeros(np,nT,N),'J/(mol*K)');
table_H = simscape.Value(zeros(np,nT,N),'kJ/mol');
table_G = simscape.Value(zeros(np,nT,N),'kJ/mol');
for i=1:np
  for j=1:nT
    help = getCp(cp0,table_T(j));
    for k=1:N
      table_cp(i,j,k) = help(k);
    end
    help = getdH(dHf0,cp0,table_T(j));
    for k=1:N
      table_H(i,j,k) = help(k);
    end
    help = table_T(j)*getdS(dS0,cp0,table_T(j));
    for k=1:N
      table_G(i,j,k) = table_H(i,j,k)-help(k);
    end
    help = getMu(vis0,table_T(j));
    for k=1:N
      table_mu(i,:,k) = help(k);
    end
  end
end

setBlockData(model,block,...
  'N',N,...
  'Ids',Ids,...
  'Mw',Mw,...
  'table_p',table_p,...
  'table_T',table_T,...
  'table_Vm',simscape.Value(zeros(np*nT,N),'l/mol'),... % default
  'table_cp',reshape(table_cp,np*nT,N),...
  'table_mu',reshape(table_mu,np*nT,N),...
  'table_lambda',reshape(table_lambda,np*nT,N),...
  'table_H',reshape(table_H,np*nT,N),...
  'table_G',reshape(table_G,np*nT,N));
end


