function plotLiquidMolarVolume(~, callbackInfo)
if(contains(get_param(gcbh,'Name'),'Properties Liquid'))
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  Vm = str2num(get_param(gcbh,'table_Vm'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Solid',Ids);
  plot(T,Vm,'linewidth',2.0)
  set(gca,'fontsize',16,'linewidth',1.6)
  xlabel('T [K]')
  ylabel('Vm [l/mol]')
  grid on
  legend(species)
else
  close all
  warning('no Properties Solid Block selected\n');
end
end
