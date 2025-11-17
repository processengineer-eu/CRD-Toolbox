% Plot Gas Properties (DataBase)
% (c) Klaus Schnitzlein - 13.05.2024

function sl_plotDataBaseGas(schema)
  schema.state = 'Enabled';
  schema.label = 'Plot Properties Gas';
  schema.childrenFcns = {...
    @plot_Gas_H,@plot_Gas_S,...
    @plot_Gas_cp,@plot_Gas_mu,...
    @plot_Gas_lambda};
end

function schema = plot_Gas_H(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Enthalpy';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  props = mw.propsGas;
  species = props.species;
  T = value(props.table_T,'K');
  H = value(props.table_H,'kJ/mol');
  schema.userdata = {T,H,species,'Enthalpy [kJ/mol]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_S(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Entropy';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  props = mw.propsGas;
  species = props.species;
  T = value(props.table_T,'K');
  S = value(props.table_S,'kJ/(mol*K)');
  schema.userdata = {T,S,species,'Entropy [kJ/(mol*K)]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_cp(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Specific Heat';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  props = mw.propsGas;
  species = props.species;
  T = value(props.table_T,'K');
  cp = value(props.table_cp,'J/(mol*K)');
  schema.userdata = {T,cp,species,'Specific Heat [J/(mol*K)]','Gas'};
  schema.callback = @callbackPlot;
end 

function schema = plot_Gas_mu(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Dynamic Viscosity';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  props = mw.propsGas;
  species = props.species;
  T = value(props.table_T,'K');
  mu = value(props.table_mu,'Pa*s');
  schema.userdata = {T,mu,species,'Dynamic Viscosity [Pa*s]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_lambda(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat Conductivity';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  props = mw.propsGas;
  species = props.species;
  T = value(props.table_T,'K');
  lambda = value(props.table_lambda,'W/(m*K)');
  schema.userdata = {T,lambda,species,'Heat Conductivity [W/(m*K)]','Gas'};
  schema.callback = @callbackPlot;
end



