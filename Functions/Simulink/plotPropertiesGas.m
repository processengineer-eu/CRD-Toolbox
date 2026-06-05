function plotPropertiesGas(schema)
schema.state = 'Enabled';
schema.label = 'Plot Properties Gas';
schema.tag = 'Properties Gas';
schema.childrenFcns = {...
  @myTestCallback,@myTestCallback};
end