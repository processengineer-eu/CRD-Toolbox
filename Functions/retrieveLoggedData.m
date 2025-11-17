function val = retrieveLoggedData(simout,block,var)
% Retrieve Logged Data from a Simulation
%
% (c) Klaus Schnitzlein - 22.03.2024

val = simscape.Value(eval(sprintf('simout.simlog.%s.%s.series.values',block,var)),...
  eval(sprintf('simout.simlog.%s.%s.series.unit',block,var)));
end
