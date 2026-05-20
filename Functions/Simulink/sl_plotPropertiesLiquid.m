% Plot Liquid Properties
% (c) Klaus Schnitzlein - 17.11.2025

function sl_plotPropertiesLiquid(schema)
  schema.state = 'Enabled';
  schema.label = 'Plot Properties Liquid';
  schema.childrenFcns = {...
    @plot_Liquid_H,@plot_Liquid_G,...
    @plot_Liquid_cp,@plot_Liquid_mu,...
    @plot_Liquid_lambda,@plot_Liquid_Vm,...
    @plot_Liquid_Hv,@plot_Liquid_pvap};
end

function schema = plot_Liquid_H(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Enthalpy';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  H = str2num(get_param(gcbh,'table_H'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Liquid',Ids);
  species =Ids;
  schema.userdata = {T,H,species,'Enthalpy [kJ/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_G(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Gibbs Energy';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  G = str2num(get_param(gcbh,'table_G'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Liquid',Ids);
  species =Ids;
  schema.userdata = {T,G,species,'Gibbs Energy [kJ/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_cp(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Specific Heat';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  cp = str2num(get_param(gcbh,'table_cp'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Liquid',Ids);
  species =Ids;
  schema.userdata = {T,cp,species,'Specific Heat [J/(mol*K)]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_mu(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Dynamic Viscosity';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  mu = str2num(get_param(gcbh,'table_mu'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Liquid',Ids);
  species = Ids;
  schema.userdata = {T,mu,species,'Dynamic Viscosity [Pa*s]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_lambda(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat Conductivity';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  lambda = str2num(get_param(gcbh,'table_lambda'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Liquid',Ids);
  species = Ids;
  schema.userdata = {T,lambda,species,'Heat Conductivity [W/(m*K)]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_Vm(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Molar Volume';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  Vm = str2num(get_param(gcbh,'table_Vm'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Liquid',Ids);
  schema.userdata = {T,Vm,species,'Molar Volume [l/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_Hv(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat of Vaporization';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  Hv = str2num(get_param(gcbh,'table_Hv'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Liquid',Ids);
  schema.userdata = {T,Hv,species,'Heat of Vaporization [kJ/mol]','Liquid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Liquid_pvap(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Vaporization Pressure';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  pvap = str2num(get_param(gcbh,'table_pvap'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Liquid',Ids);
  schema.userdata = {T,pvap,species,'Vaporization Pressure [bar]','Liquid'};
  schema.callback = @callbackPlot;
end