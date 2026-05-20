% Update Model

function sl_updateModel(schema)
  schema.state = 'Enabled';
  schema.label = 'Init Database Gas';
  schema.childrenFcns = {@do_update};
end

function schema = do_update(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Update';
  schema.userdata = {''};
  schema.callback = @callbackUpdate;
end

function callbackUpdate(callbackInfo)
  % set_param(gcs, 'SimulationCommand', 'update')
  fprintf('model %s updated\n',gcs);

  N = uint32(str2num(get_param(gcbh,'numSpecies')));
  Ids = zeros(N,1);
  for i=1:N
    Ids(i) = uint32(str2num(get_param(gcbh,sprintf('A%d',i))));
  end
 

end