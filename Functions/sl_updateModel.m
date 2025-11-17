% Update Model

function sl_updateModel(schema)
  schema.state = 'Enabled';
  schema.label = 'Setup Properties';
  schema.childrenFcns = {@do_update};
end

function schema = do_update(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Update';
  schema.userdata = {''};
  schema.callback = @callbackUpdate;
end

function callbackUpdate(callbackInfo)
  set_param(gcs, 'SimulationCommand', 'update')
  fprintf('model %s updated\n',gcs);
end