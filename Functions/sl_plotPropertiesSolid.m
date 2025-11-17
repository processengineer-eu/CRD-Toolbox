% Plot Solid Properties
% (c) Klaus Schnitzlein - 17.11.2025

function sl_plotPropertiesSolid(schema)
  schema.state = 'Enabled';
  schema.label = 'Plot Properties Solid';
  schema.childrenFcns = {...
    @plot_Solid_H,@plot_Solid_g,...
    @plot_Solid_cp,...
    @plot_Solid_lambda,@plot_Solid_Vm};
end

function schema = plot_Solid_H(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Enthalpy';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  H = str2num(get_param(gcbh,'table_H'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Solid',Ids);
  species = Ids;
  schema.userdata = {T,H,species,'Enthalpy [kJ/mol]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_G(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Entropyy';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  G = str2num(get_param(gcbh,'table_G'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Solid',Ids);
  schema.userdata = {T,G,species,'Gibbs Energy [kJ/mol]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_cp(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Specific Heat';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  cp = str2num(get_param(gcbh,'table_cp'));
  Ids = str2num(get_param(gcbh,'Ids'));
  species = retrieveSpecies('Solid',Ids);
  schema.userdata = {T,cp,species,'Specific Heat [J/(mol*K)]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_lambda(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Heat Conductivity';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  lambda = str2num(get_param(gcbh,'table_lambda'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Solid',Ids);
  species = Ids;
  schema.userdata = {T,lambda,species,'Heat Conductivity [W/(m*K)]','Solid'};
  schema.callback = @callbackPlot;
end

function schema = plot_Solid_Vm(callbackInfo)
  schema = sl_action_schema;
  schema.label = 'Molar Volume';
  N = str2num(get_param(gcbh,'N'));
  T = str2num(get_param(gcbh,'table_T'));
  Vm = str2num(get_param(gcbh,'table_Vm'));
  Ids = str2num(get_param(gcbh,'Ids'));
  % species = retrieveSpecies('Solid',Ids);
  species = Ids;
  schema.userdata = {T,Vm,species,'Molar Volume [l/mol]','Solid'};
  schema.callback = @callbackPlot;
end

