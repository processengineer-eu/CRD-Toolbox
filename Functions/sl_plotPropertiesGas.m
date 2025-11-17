% Plot Gas Properties
% (c) Klaus Schnitzlein - 17.11.2025

function sl_plotPropertiesGas(schema)
  schema.state = 'Enabled';
  schema.label = 'Plot Properties Gas';
  schema.childrenFcns = {...
    @plot_Gas_H,@plot_Gas_G,...
    @plot_Gas_cp,@plot_Gas_mu,...
    @plot_Gas_lambda};
  end

function schema = plot_Gas_H(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Enthalpy';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  H = str2num(get_param(gcbh,'table_H'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Gas',Ids);
  species =Ids;
  schema.userdata = {T,H,species,'Enthalpy [kJ/mol]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_G(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Gibbs Energy';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  G = str2num(get_param(gcbh,'table_G'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Gas',Ids);
  species =Ids;
  schema.userdata = {T,G,species,'Gibbs Energy [kJ/mol]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_cp(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Specific Heat';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  cp = str2num(get_param(gcbh,'table_cp'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Gas',Ids);
  schema.userdata = {T,cp,species,'Specific Heat [J/(mol*K)]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_mu(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Dynamic Viscosity';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  mu = str2num(get_param(gcbh,'table_mu'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Gas',Ids);
  species =Ids;
  schema.userdata = {T,mu,species,'Dynamic Viscosity [Pa*s]','Gas'};
  schema.callback = @callbackPlot;
end

function schema = plot_Gas_lambda(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat Conductivity';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  lambda = str2num(get_param(gcbh,'table_lambda'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Gas',Ids);
  species =Ids;
  schema.userdata = {T,lambda,species,'Heat Conductivity [W/(m*K)]','Gas'};
  schema.callback = @callbackPlot;
end

