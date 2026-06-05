function plotGasEnthalpy(~, callbackInfo)
if(contains(get_param(gcbh,'Name'),'Properties Gas'))
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  H = str2num(get_param(gcbh,'table_H'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Solid',Ids);
  plot(T,H,'linewidth',2.0)
  set(gca,'fontsize',16,'linewidth',1.6)
  xlabel('T [K]')
  ylabel('H [kJ/mol]')
  grid on
  legend(species)
else
  close all
  warning('no Properties Gas Block selected\n');
end
end
