function [kappaf,kappab]=getKappa(Nue)

  % Copyright Klaus Schnitzlein - 03.01.2023
  
  if(nargin<1)
    error("usage: [kappaf,kappab]=getKappa(Nue)");
  end

  help = Nue;
  help(help>0)=0;		% select negative entries
  kappaf = abs(help);
  
  help = Nue;
  help(help<0)=0;		% select positive entries
  kappab = help;

end

