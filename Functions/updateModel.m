function updateModel()
  tic
  set_param(gcs, 'SimulationCommand', 'update')
  fprintf('model %s updated\n',gcs);
  toc
end