function Dm = getDm(D,x)
%% Berechung der Fick'schen Mehrkomponentendiffusionskoeffizienten
%
%   (c) Klaus Schnitzlein - 03.06.2025

N=length(x);
Dbin = value(D,'m^2/s');
B=zeros(N-1,N-1);
for i=1:N-1
  for j=1:N-1
    if(i==j)
      B(i,i)=x(i)/Dbin(i,N);
      for k=1:N
        if(i~=k)
          B(i,j)=B(i,j)+x(k)/Dbin(i,k);
        end
      end
    else
      B(i,j)=-x(i)*(1/Dbin(i,j)-1/Dbin(i,N));
    end
  end
end
Dm = simscape.Value(inv(B),'m^2/s');
end

