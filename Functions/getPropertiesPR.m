function k0 = getPropertiesPR(props) 
% Retrieve interaction parameters for PengRobinson EoS
% (c) Klaus Schnitzlein - 14.09.2025

% wenn für Spezies kein Entrag in der Datenbank vorhanden ist, wird
% der Wert 0 für die Interaction Coefficients verwendet (default value).

N = length(props.Ids);
k0 = zeros(N,N);
ipd = fileread(sprintf('%s/Data/ipd/pr.ipd',getenv('root_CRD')));
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
        k0(i,j) = str2double(items{3});
        k0(j,i) = k0(i,j);
        break
      end
    end
  end
end
end
