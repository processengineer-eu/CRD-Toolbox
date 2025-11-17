function val = getProperty_T(eqno,p,Tc,T)

% Calculation of temperature dependent property
% (c) Klaus Schnitzlein - 10.09.2025

% Achtung: noch nicht alle Gleichungen sind auf vektorielle Berechnung
% angepaßt

Tr = T/Tc;
switch eqno
  case 0
    val = 0; % default
  case 1
    val = p(1)*ones(size(T));
  case 2
    val = p(1)+p(2)*T;
  case 3
    val = p(1)+p(2)*T+p(3)*T.^2;
  case 4
    val = p(1)+p(2)*T+p(3)*T.^2+p(4)*T.^3;
  case 5
    val = p(1)+p(2)*T+p(3)*T.^2+p(4)*T.^3+p(5)*T.^4;
  case 10
    val = exp(p(1)-p(2)./(p(3)+T));
  case 11
    val = exp(p(1))*ones(size(T));
  case 12
    val = exp(p(1)+p(2)*T);
  case 13
    val = exp(p(1)+p(2)*T+p(3)*T.^2);
  case 14
    val = exp(p(1)+p(2)*T+p(3)*T^2+p(4)*T.^3);
  case 15
    val = exp(p(1)+p(2)*T+p(3)*T^2+p(4)*T^3+p(5)*T^4);
  case 16
    val = p(1)+exp(p(2)./T+p(3)+p(4)*T+p(5)*T.^2);
  case 17
    val = p(1)+exp(p(2)+p(3)*T+p(4)*T.^2+p(5)*T.^3);
  case 45
    val = p(1)*T+p(2)*T.^2/2+p(3)*T.^3/3+p(4)*T.^4/4+p(5)*T.^5/5;
  case 75
    val = p(2)+2*p(3).*T+3*p(4)*T.^2+4*p(5)^3;
  case 100
    val = p(1)+p(2)*T+p(3)*T.^2+p(4)*T.^3+p(5)*T.^4;
  case 101
    val = exp(p(1)+p(2)./T+p(3).*log(T)+p(4)*T.^p(5));
  case 102
    val = p(1)*T.^p(2)/(1+p(3)./T+p(4)/T.^2);
  case 103
    val = p(1)+p(2)*exp(-p(3)./T.^p(4));
  case 104
    val = p(1)+p(2)./T+p(3)./T.^3+p(4)/T.^8+p(5)/T.^9;
  case 105
    val = p(1)/p(2).^(1+(1-T./p(3)).^p(4));
  case 106
    val = p(1)*(1-Tr).^(p(2)+p(3)*Tr+p(4)*Tr.^2+p(5)*Tr.^3);
  case 107
    val = p(1)+p(2)*((p(3)/T)/sinh(p(3)/T))^2+p(4)*((p(5)/T)/cosh(p(5)/T))^2;
  case 114
    val = p(1)^2*(1-Tr)+p(2)-2*p(1)*p(3)*(1-Tr)-p(1)*p(4)*(1-Tr)^2-...
      p(3)^2*(1-Tr)^3/3-p(3)*p(4)*(1-Tr)^4/2-p(4)^2*(1-Tr)^5/5;
  case 115
    val = exp(p(1)+p(2)/T+p(3)*log(T)+p(4)*T^2+p(4)*T^2);
  case 116
    val = p(1)+p(2)*(1-Tr)^0.35+p(3)*(1-Tr)^2/3+p(4)*(1-Tr)+p(5)*(1-Tr)^4/3;
  case 117
    val = p(1)*T+p(2)*(p(3)/T)/tanh(p(3)/T)-p(4)*(p(5)/T)/tanh(p(5)/T);
  case 120
    val = p(1)-p(2)/(T+p(3));
  case 121
    val = p(1)+p(2)/T+p(3)*log(T)+p(4)*T^p(5);
  case 122
    val = p(1)+p(2)/T+p(3)*log(T)+p(4)*T^2+p(5)/T^2;
  case 207
    val = exp(p(1)-p(2)/(p(3)+T));
  case 208
    val = 10^(p(1)-p(2)/(T+p(3)));
  case 209
    val = 10^(p(1)*(1/T-1/p(2)));
  case 210
    val = 10^(p(1)+p(2)/T+p(3)*T+p(4)*T^2);
  case 211
    val = p(1)*((p(2)-T)/(p(2)-p(3)))^p(4);
  otherwise
    error('unknown equation number');
end
end
