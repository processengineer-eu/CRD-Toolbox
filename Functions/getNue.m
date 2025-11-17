function Nue=getNue(schema,select)
  % Ermittlung der Matrix der stöchiometrischen Koeffizienten aus einem Reaktionsschema
  % Copyright Klaus Schnitzlein - 11.08.2021
  %
  % Usage: Nue=getNue(schema,select)
  % - select: Cell-Array mit Speziesnamen in der gewünschten Reihenfolge
  % - einschließlich etwaiger inerter Spezies
  % - der Speziesname darf kein - Zeichen enthalten
  %
  % Beachte:
  % es muss vor dem + und dem = ein Leerzeichen stehen, damit auch bei
  % einer Ladung die Spezies erkannt werden kann.
  
  species = getSpecies(schema);
  N = length(select); %species);
  M = length(schema);
  Nue = zeros(N,M);
  for j=1:M
    stemp = strsplit(schema{j},"=");
    edukte = strsplit(stemp{1}," +" );
    for k=1:length(edukte)
      t = regexp(edukte{k},'([0-9\.]*)[\*]*([\w\(\)]+[\^\+\-\d]*)','tokens');
      species_found = t{1}{2};
      for i=1:N
       if(strcmp(species_found,select{i}))  % species
         if(~isempty(t{1}{1}))
            Nue(i,j) = -str2double(t{1}{1});
          else
            Nue(i,j) = -1;
          end
        end
      end
    end
    produkte = strsplit(stemp{2}," + ");
    for k=1:length(produkte)
      t = regexp(produkte{k},'([0-9\.]*)[\*]*([\w\(\)]+[\^\+\-\d]*)','tokens');
      species_found = t{1}{2};
      for i=1:N
        if(strcmp(species_found,select{i}))   % species
          if(~isempty(t{1}{1}))
            Nue(i,j) = str2double(t{1}{1});
          else
            Nue(i,j) = 1;
          end
        end
      end
    end
  end
  
  % Sortierung der Zeilen - brauche ich das denn noch?
%   for i=1:N
%     for k=1:N
%       if(strcmp(species{k},select{i}))
%         Nue1(i,:) = Nue(k,:);
%         break
%       end
%     end
%   end
end
