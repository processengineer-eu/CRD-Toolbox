% Plot Solid Properties (DataBase)
% (c) Klaus Schnitzlein - 13.05.2024

function sl_plotDataBaseSolid(schema)
  schema.state = 'Enabled';
  schema.label = 'Plot Properties Solid';
  schema.childrenFcns = {...
    @plot_Solid_H,@plot_Solid_S,...
    @plot_Solid_cp,@plot_Solid_lambda,...
    @plot_Solid_Vm};
end

function schema = plot_Solid_H(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Enthalpy';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsSolid = mw.propsSolid;
  species = propsSolid.species;
  T = value(propsSolid.table_T,'K');
  H = value(propsSolid.table_H,'kJ/mol');
  schema.userdata = {T,H,species,'Enthalpy [kJ/mol]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_S(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Entropy';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsSolid = mw.propsSolid;
  species = propsSolid.species;
  T = value(propsSolid.table_T,'K');
  S = value(propsSolid.table_S,'kJ/(mol*K)');
  schema.userdata = {T,S,species,'Entropy [kJ/(mol*K)]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_cp(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Specific Heat';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsSolid = mw.propsSolid;
  species = propsSolid.species;
  T = value(propsSolid.table_T,'K');
  cp = value(propsSolid.table_cp,'J/(mol*K)');
  schema.userdata = {T,cp,species,'Specific Heat [J/(mol*K)]','Solid'};
  schema.callback = @callbackPlot;
end 

function schema = plot_Solid_lambda(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat Conductivity';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsSolid = mw.propsSolid;
  species = propsSolid.species;
  T = value(propsSolid.table_T,'K');
  lambda = value(propsSolid.table_lambda,'W/(m*K)');
  schema.userdata = {T,lambda,species,'Heat Conductivity [W/(m*K)]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_Vm(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Molar Volume';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsSolid = mw.propsSolid;
  species = propsSolid.species;
  T = value(propsSolid.table_T,'K');
  Vm = value(propsSolid.table_Vm,'l/mol');
  schema.userdata = {T,Vm,species,'Molar Volume [l/mol]','Solid'};
  schema.callback = @callbackPlot;
end