function plotGasHeatCapacity(~, callbackInfo)
if(contains(get_param(gcbh,'Name'),'Properties Gas'))
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  cp = str2num(get_param(gcbh,'table_cp'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Gas',Ids);
  species = cellstr(strcat('A',string(Ids)))
  plot(T,cp,'linewidth',2.0)
  set(gca,'fontsize',16,'linewidth',1.6)
  xlabel('T [K]')
  ylabel('c_p [kJ/(mol*K)]')
  grid on
  legend(species)
else
  close all
  warning('no Properties Gas Block selected\n');
end
end
