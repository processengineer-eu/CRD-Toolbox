function [A,alpha] = getPropertiesNRTL(props) 
% Retrieve interaction parameters for NRTL
% (c) Klaus Schnitzlein - 14.09.2025

% wenn für Spezies kein Entrag in der Datenbank vorhanden ist, wird
% der Wert 0 für die Interaction Coefficients verwendet (default value).

N = length(props.Ids);
A = simscape.Value(zeros(N,N),'cal/mol');
alpha = zeros(N,N);
ipd = fileread(sprintf('%s/Data/ipd/nrtl.ipd',getenv('root_CRD')));
lines = regexp(ipd,'\r\n|\r|\n','split');
for i=1:N
  for j=1:N
    if(i == j) 
      continue
    end
    for k=17:length(lines)
      expr = [props.CAS{i} '\s+' props.CAS{j}];
      [~,matches] = regexp(lines{k},expr,'match');
      if(isscalar(matches))
        items = split(lines{k});
        A(i,j) = simscape.Value(str2double(items{3}),'cal/mol');
        A(j,i) = simscape.Value(str2double(items{4}),'cal/mol');
        alpha(i,j) = str2double(items{5});
        alpha(j,i) = alpha(i,j);
        break
      end
    end
  end
end
end
