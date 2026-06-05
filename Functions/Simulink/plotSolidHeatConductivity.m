function plotSolidHeatConductivity(~, callbackInfo)
if(contains(get_param(gcbh,'Name'),'Properties Solid'))
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  lambda = str2num(get_param(gcbh,'table_lambda'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Solid',Ids);
  plot(T,lambda,'linewidth',2.0)
  set(gca,'fontsize',16,'linewidth',1.6)
  xlabel('T [K]')
  ylabel('\lambda [W/(m*K)]')
  grid on
  legend(species)
else
  close all
  warning('no Properties Solid Block selected\n');
end
end