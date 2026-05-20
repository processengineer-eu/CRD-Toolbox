% Plot Data from sl_customization
% (c) Klaus Schnitzlein - 15.04.2025

function callbackPlot(callbackInfo)
  clf
  plot(callbackInfo.userdata{1},callbackInfo.userdata{2},...
    '-','linewidth',2);
  set(gca,'fontsize',14,'linewidth',1.6)
  xlabel('Temperature [K]')
  ylabel(callbackInfo.userdata{4});
  grid
  species = callbackInfo.userdata{3};
  species = string(species); % only test
  legend(species,'location','best','fontsize',12)
  title(callbackInfo.userdata{5});
end
