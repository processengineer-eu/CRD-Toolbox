function z = getCharges(species)
%
% Berechnung der Ladungen der Spezies
%   - Ergebnis wird als Spaltenvektor zurückgegeben
%
%    Copyright Klaus Schnitzlein - 12.08.21
%
N = length(species);
z = zeros(N,1);
for i=1:length(species)
  c = regexp(species{i},'[\w\(\)]+\^([\-\+\d]*)','tokens');
  if(isempty(c))
    z(i) = 0;
  else
    t = regexp(c{1},'([0-9])*([\+\-])+','tokens');
    if(isempty(t{1}{1}{1}))
      z(i) = str2double(strcat(t{1}{1}{2},'1'));
    else
      z(i) = str2double(strcat(t{1}{1}{2},t{1}{1}{1}));
    end
  end
end
end