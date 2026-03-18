%% Customization of Context Menu
%  after MathWorks
%  (c) Klaus Schnitzlein - 14.01.2026

function sl_customization(cm)
  cm.addCustomMenuFcn('Simulink:PreContextMenu',@getMyMenuItems);
  % cm.addCustomMenuFcn('Simulink:PreContextMenu',@getMyMenuItems2);
end  

function schemaFcns = getMyMenuItems(callbackInfo) 
  schemaFcns = {@Menu,@Menu2};
end

function schema = Menu2(callbackInfo)
  schema = sl_container_schema;
  if(contains(get_param(gcbh,'Name'),'PropertiesX Gas'))
    % sl_updateModel(schema);
    sl_plotPropertiesXGas(schema);
  else
    schema.state = 'Hidden';
    return
  end
end

function schema = Menu(callbackInfo)
  schema = sl_container_schema;
  if(contains(get_param(gcbh,'Name'),'Database Liquid'))
    sl_plotDataBaseLiquid(schema);
  elseif(contains(get_param(gcbh,'Name'),'Properties Liquid'))
    sl_plotPropertiesLiquid(schema);
  elseif(contains(get_param(gcbh,'Name'),'Database Gas'))
    sl_plotDataBaseGas(schema);
  elseif(contains(get_param(gcbh,'Name'),'Properties Gas'))
    sl_plotPropertiesGas(schema);
  elseif(contains(get_param(gcbh,'Name'),'Database Solid'))
    sl_plotDataBaseSolid(schema);
  elseif(contains(get_param(gcbh,'Name'),'Properties Solid'))
     sl_plotPropertiesSolid(schema);
  else
    schema.state = 'Hidden';
    return
  end
end

% function sl_writeSelectedSpeciesGas(schema)
%   schema.state = 'Enabled';
%   schema.label = 'Write Selected Species Gas';
%   schema.childrenFcns = {...
%     @doit};
%   end
% 
% function schema = doit(callbackInfo)
% ;
% end


% function schema = Menu(callbackInfo)
%   schema = sl_container_schema;
%   if(contains(get_param(gcbh,'Name'),'Properties Liquid'))
%     sl_plotPropertiesLiquid(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Properties Gas'))
%      sl_plotPropertiesGas(schema);
%   elseif(contains(get_param(gcbh,'Name'),'Properties Solid'))
%      sl_plotPropertiesSolid(schema);
%   else
%     schema.state = 'Hidden';
%     return
%   end
% end