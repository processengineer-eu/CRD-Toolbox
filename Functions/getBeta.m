function B=getBeta(species,elements)

  if(nargin<2)
    error("usage: B=getBeta(species,elements)");
  end
  
  N =length(species);
  L = length(elements);
  B = zeros(L,N);
  for i=1:N
    for l=1:L
      pattern = sprintf("%s([0-9.]*)",elements{l});
      [s,e,te,m,token,nm,sp] = regexp(species{i},pattern);
      count = 0;
      for k=1:length(token)
        if(e(k)<length(species{i}))
          if(isstrprop(species{i}(e(k)+1),'lower')) % wegen C und Cl etc.
            break;
          end
        end
        if(~isempty(token{k}{1}))
          count = count+str2double(token{k}{1});
        else
          count = count+1;
        end
      end
      B(l,i) = count;
    end
  end
end
