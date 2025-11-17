%% Customization of Context Menu
%  after MathWorks
%  (c) Klaus Schnitzlein - 22.04.2025

function sl_customization(cm)
  cm.addCustomMenuFcn('Simulink:PreContextMenu',@getMyMenuItems);
  cm.addCustomMenuFcn('Simulink:PreContextMenu',@getMyMenuItems2);
end  

function schemaFcns = getMyMenuItems(callbackInfo) 
  schemaFcns = {@Menu};
end

function schemaFcns = getMyMenuItems2(callbackInfo) 
  schemaFcns = {@Menu2};
end

function schema = Menu2(callbackInfo)
  schema = sl_container_schema;
  if(contains(get_param(gcbh,'Name'),'Database Gas'))
    sl_updateModel(schema);
  else
    schema.state = 'Hidden';
    return
  end
end

% function schema = Menu(callbackInfo)
%   schema = sl_container_schema;
%   if(contains(get_param(gcbh,'Name'),'Database Liquid'))
%     sl_plotDataBaseLiquid(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Properties Liquid'))
%     sl_plotPropertiesLiquid(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Database Gas'))
%     sl_plotDataBaseGas(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Properties Gas'))
%      sl_plotPropertiesGas(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Database Solid'))
%     sl_plotDataBaseSolid(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Properties Solid'))
%      sl_plotPropertiesSolid(schema);
%   else
%     schema.state = 'Hidden';
%     return
%   end
% end

function schema = Menu(callbackInfo)
  schema = sl_container_schema;
  if(contains(get_param(gcbh,'Name'),'Properties Liquid'))
    sl_plotPropertiesLiquid(schema);
  elseif(contains(get_param(gcbh,'Name'),'Properties Gas'))
     sl_plotPropertiesGas(schema);
  elseif(contains(get_param(gcbh,'Name'),'Properties Solid'))
     sl_plotPropertiesSolid(schema);
  else
    schema.state = 'Hidden';
    return
  end
end