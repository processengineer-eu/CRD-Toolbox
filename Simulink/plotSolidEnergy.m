function plotSolidEnergy(~, callbackInfo)
if(contains(get_param(gcbh,'Name'),'Properties Solid'))
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  G = str2num(get_param(gcbh,'table_G'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Solid',Ids);
  species = cellstr(strcat('A',string(Ids)))
  plot(T,G,'linewidth',2.0)
  set(gca,'fontsize',16,'linewidth',1.6)
  xlabel('T [K]')
  ylabel('G [kJ/mol]')
  grid on
  legend(species)
else
  close all
  warning('no Properties Solid Block selected\n');
end
end
