function sl_customization(cm)
cm.addCustomMenuFcn('Simulink:PreContextMenu', @getTestMenu);
end

function schemaFcns = getTestMenu(~)
  schemaFcns = {@testMenu};
end

function schema = testMenu(callbackInfo)
disp1sfd(cawqerllbackInfo)
schema = sl_action_schema;
schema.tag = "myTestMenu";
schema.label = "My Test Menu";
schema.callback = @myTestCallback;
end

function myTestCallback(~, callbackInfo)
msgbox("Test menu invoked");
end


% function sl_customization(cm)
% % Menü oben (PreContextMenu)
% cm.addCustomMenuFcn('Simulink:PreContextMenu', @getMyMenuItems);
% 
% % Reihenfolge für Library Browser (optional)
% cm.LibraryBrowserCustomizer.applyOrder({
%   'Chemical Reactor Design ToolBox',          -3, ...
%   'Chemical Reactor Design Extended Library', -2, ...
%   'Chemical Reactor Design PDE Library',      -1
%   });
% end
% 
% function schemaFcns = getMyMenuItems(callbackInfo)
% % Liste der Schema-Funktionen (Action-Schemata)
% schemaFcns = {
%   @menuDatabaseLiquid, ...
%   @menuPropertiesLiquid, ...
%   @menuDatabaseGas, ...
%   @menuPropertiesGas, ...
%   @menuDatabaseSolid, ...
%   @menuPropertiesSolid, ...
%   @menuPropertiesXGas
%   };
% end
% 
% function schema = menuDatabaseLiquid(~)
% schema = sl_action_schema;
% schema.tag      = "dbLiquid";
% schema.label    = 'Database Liquid';
% schema.callback = @sl_plotDataBaseLiquid; % separate Funktion
% end
% 
% function schema = menuDatabaseGas(callbackInfo)
% schema = sl_action_schema;
% schema.tag   = "dbGas";
% schema.label = "Database Gas";
% try
%   bh = callbackInfo.BlockHandle;
%   name = get_param(bh, 'Name');
% catch
%   schema.state = 'Hidden';
%   return
% end
% if contains(name, 'Database Gas')
%   schema.callback = @sl_plotDataBaseGas; % Top-Level-Funktion
% else
%   schema.state = 'Hidden';
% end
% end
% 
% function schema = menuPropertiesLiquid(~)
% schema = sl_action_schema;
% schema.tag      = "propsLiquid";
% schema.label    = 'Properties Liquid';
% schema.callback = @sl_plotPropertiesLiquid;
% end
% 
% function schema = menuPropertiesGas(~)
% schema = sl_action_schema;
% schema.tag      = "propsGas";
% schema.label    = 'Properties Gas';
% schema.callback = @sl_plotPropertiesGas;
% end
% 
% function schema = menuDatabaseSolid(~)
% schema = sl_action_schema;
% schema.tag      = "dbSolid";
% schema.label    = 'Database Solid';
% schema.callback = @sl_plotDataBaseSolid;
% end
% 
% function schema = menuPropertiesSolid(~)
% schema = sl_action_schema;
% schema.tag      = "propsSolid";
% schema.label    = 'Properties Solid';
% schema.callback = @sl_plotPropertiesSolid;
% end
% 
% function schema = menuPropertiesXGas(~)
% schema = sl_action_schema;
% schema.tag      = "propsXGas";
% schema.label    = 'PropertiesX Gas';
% schema.callback = @sl_plotPropertiesXGas;
% end
