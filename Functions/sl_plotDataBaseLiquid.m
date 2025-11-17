% Plot Liquid Properties (DataBase)
% (c) Klaus Schnitzlein - 13.05.2024

function sl_plotDataBaseLiquid(schema)
  schema.state = 'Enabled';
  schema.label = 'Plot Properties Liquid';
  schema.childrenFcns = {...
    @plot_Liquid_H,@plot_Liquid_S,...
    @plot_Liquid_cp,@plot_Liquid_mu,...
    @plot_Liquid_lambda,@plot_Liquid_Vm,...
    @plot_Liquid_Hv,@plot_Liquid_pvap};
end

function schema = plot_Liquid_H(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Enthalpy';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  H = value(propsLiquid.table_H,'kJ/mol');
  schema.userdata = {T,H,species,'Enthalpy [kJ/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_S(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Entropy';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  S = value(propsLiquid.table_S,'kJ/(mol*K)');
  schema.userdata = {T,S,species,'Entropy [kJ/(mol*K)]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_cp(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Specific Heat';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  cp = value(propsLiquid.table_cp,'J/(mol*K)');
  schema.userdata = {T,cp,species,'Specific Heat [J/(mol*K)]','Liquid'};
  schema.callback = @callbackPlot;
end 

function schema = plot_Liquid_mu(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Dynamic Viscosity';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  mu = value(propsLiquid.table_mu,'Pa*s');
  schema.userdata = {T,mu,species,'Dynamic Viscosity [Pa*s]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_lambda(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat Conductivity';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  lambda = value(propsLiquid.table_lambda,'W/(m*K)');
  schema.userdata = {T,lambda,species,'Heat Conductivity [W/(m*K)]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_Vm(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Molar Volume';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  Vm = value(propsLiquid.table_Vm,'l/mol');
  schema.userdata = {T,Vm,species,'Molar Volume [l/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_Hv(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat of Vaporization';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  Hv = value(propsLiquid.table_Hv,'kJ/mol');
  schema.userdata = {T,Hv,species,'Heat of Vaporization [kJ/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_pvap(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Vaporization Pressure';
  if(~exist(bdroot(gcs)+".slx",'file'))
    return
  end
  mw = Simulink.data.connect(bdroot(gcs)+".slx");
  propsLiquid = mw.propsLiquid;
  species = propsLiquid.species;
  T = value(propsLiquid.table_T,'K');
  pvap = value(propsLiquid.table_pvap,'Pa');
  schema.userdata = {T,pvap,species,'Vaporization Pressure [Pa]','Liquid'};
  schema.callback = @callbackPlot;
end

