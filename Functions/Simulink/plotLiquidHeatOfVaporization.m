function plotLiquidHeatOfVaporization(~, callbackInfo)
if(contains(get_param(gcbh,'Name'),'Properties Liquid'))
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  Hv = str2num(get_param(gcbh,'table_Hv'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Liquid',Ids);
  plot(T,pvap,'linewidth',2.0)
  set(gca,'fontsize',16,'linewidth',1.6)
  xlabel('T [K]')
  ylabel('H_{v} [kJ/mol]')
  grid on
  legend(species)
else
  close all
  warning('no Properties Liquid Block selected\n');
end
end
