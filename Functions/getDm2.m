function Dm = getDm2(Dbin,x)
%% Berechung der Fick'schen Mehrkomponentendiffusionskoeffizienten
%
% (c) Klaus Schnitzlein - 09.08.2025

N=length(x);
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
if(det(B) > eps)
  Dm = inv(B); % [m^2/s]
else
  Dm = eye(N-1);
end
end

