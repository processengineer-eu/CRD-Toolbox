%% Customization of Context Menu - for R2026a
%
%  (c) Klaus Schnitzlein - 25.05.2026

function sl_customization(cm)
  % cm.addCustomMenuFcn('Simulink:ContextMenu', @getMenuItems);
  cm.LibraryBrowserCustomizer.applyOrder({
    'Chemical Reactor Design ToolBox',         -3, ...
    'Chemical Reactor Design Extended Library',-2, ...
    'Chemical Reactor Design PDE Library',     -1
    });
  % Ersetzen Sie 'myCustomMenus.myAction' durch die tatsächliche Action-ID
  cm.addCustomFilterFcn('myCustomMenus.checkForAlgLoops', @myActionFilter);
end

% % % function schemaFcns = getMenuItems(~)
% % %   schemaFcns = {@Menu1};
% % % end
% % % 
% % % function schema = Menu1(~)
% % %   schema = sl_container_schema;
% % %   schema.tag = "Menu1";
% % %   schema.label = "Plot";
% % %   schema.childrenFcns = {@MenuPropertiesGas,@MenuPropertiesLiquid,@MenuPropertiesSolid};
% % % end
% % % 
% % % function schema = MenuPropertiesGas(~)
% % % schema = sl_container_schema;
% % % schema.tag = "plotPropertiesGas";
% % % schema.label = "Properties Gas";
% % % schema.childrenFcns = {@ItemGasEnthalpy,@ItemGasGibbsEnergy,...
% % %   @ItemGasHeatCapacity,@ItemGasViscosity,@ItemGasHeatConductivity};
% % % end
% % % 
% % % function schema = MenuPropertiesLiquid(~)
% % % schema = sl_container_schema;
% % % schema.tag = "plotPropertiesLiquid";
% % % schema.label = "Properties Liquid";
% % % schema.childrenFcns = {@ItemLiquidMolarVolume,@ItemLiquidEnthalpy,...
% % %   @ItemLiquidGibbsEnergy,@ItemLiquidHeatCapacity,@ItemLiquidViscosity,...
% % %   @ItemLiquidHeatConductivity,@ItemLiquidVaporPressure,...
% % %   @ItemLiquidHeatOfVaporization};
% % % end
% % % 
% % % function schema = MenuPropertiesSolid(~)
% % % schema = sl_container_schema;
% % % schema.tag = "plotPropertiesSolid";
% % % schema.label = "Properties Solid";
% % % schema.childrenFcns = {@ItemSolidMolarVolume,@ItemSolidEnthalpy,...
% % %   @ItemSolidGibbsEnergy,@ItemSolidHeatCapacity,@ItemSolidHeatConductivity};
% % % end
% % % 
% % % %% Enthalpy
% % % 
% % % function schema = ItemGasEnthalpy(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemGasEnthalpy";
% % % schema.label = "Enthalpy";
% % % schema.callback = @plotGasEnthalpy;
% % % end
% % % 
% % % function schema = ItemLiquidEnthalpy(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidEnthalpy";
% % % schema.label = "Enthalpy";
% % % schema.callback = @plotLiquidEnthalpy;
% % % end
% % % 
% % % function schema = ItemSolidEnthalpy(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemSolidEnthalpy";
% % % schema.label = "Enthalpy";
% % % schema.callback = @plotSolidEnthalpy;
% % % end
% % % 
% % % %% Gibbs Energy
% % % 
% % % function schema = ItemGasGibbsEnergy(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemGasGibbsEnergy";
% % % schema.label = "Gibbs Energy";
% % % schema.callback = @plotGasEnergy;
% % % end
% % % 
% % % function schema = ItemLiquidGibbsEnergy(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidGibbsEnergy";
% % % schema.label = "Gibbs Energy";
% % % schema.callback = @plotLiquidEnergy;
% % % end
% % % 
% % % function schema = ItemSolidGibbsEnergy(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemSolidGibbsEnergy";
% % % schema.label = "Gibbs Energy";
% % % schema.callback = @plotSolidEnergy;
% % % end
% % % 
% % % %% Heat Capacity
% % % 
% % % function schema = ItemGasHeatCapacity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemGasHeatCapacity";
% % % schema.label = "Heat Capacity";
% % % schema.callback = @plotGasHeatCapacity;
% % % end
% % % 
% % % function schema = ItemLiquidHeatCapacity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidHeatCapacity";
% % % schema.label = "Heat Capacity";
% % % schema.callback = @plotLiquidHeatCapacity;
% % % end
% % % 
% % % function schema = ItemSolidHeatCapacity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemSolidHeatCapacity";
% % % schema.label = "Heat Capacity";
% % % schema.callback = @plotSolidHeatCapacity;
% % % end
% % % 
% % % %% Viscosity
% % % 
% % % function schema = ItemGasViscosity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemGasViscosity";
% % % schema.label = "Viscosity";
% % % schema.callback = @plotGasViscosity;
% % % end
% % % 
% % % function schema = ItemLiquidViscosity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidViscosity";
% % % schema.label = "Viscosity";
% % % schema.callback = @plotLiquidViscosity;
% % % end
% % % 
% % % %% Heat Conductivity
% % % 
% % % function schema = ItemGasHeatConductivity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemGasHeatConductivity";
% % % schema.label = "Heat Conductivity";
% % % schema.callback = @plotGasHeatConductivity;
% % % end
% % % 
% % % function schema = ItemLiquidHeatConductivity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidHeatConductivity";
% % % schema.label = "Heat Conductivity";
% % % schema.callback = @plotLiquidHeatConductivity;
% % % end
% % % 
% % % function schema = ItemSolidHeatConductivity(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemSolidHeatConductivity";
% % % schema.label = "Heat Conductivity";
% % % schema.callback = @plotSolidHeatConductivity;
% % % end
% % % 
% % % %% Molar Volume
% % % 
% % % function schema = ItemLiquidMolarVolume(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidMolarVolume";
% % % schema.label = "Molar Volume";
% % % schema.callback = @plotLiquidMolarVolume;
% % % end
% % % 
% % % function schema = ItemSolidMolarVolume(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemSolidMolarVolume";
% % % schema.label = "Molar Volume";
% % % schema.callback = @plotSolidMolarVolume;
% % % end
% % % 
% % % %% Vapor Pressure
% % % 
% % % function schema = ItemLiquidVaporPressure(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidVaporPressure";
% % % schema.label = "Vapor Pressure";
% % % schema.callback = @plotLiquidVaporPressure;
% % % end
% % % 
% % % %% Heat of Vaporization
% % % 
% % % function schema = ItemLiquidHeatOfVaporization(~)
% % % schema = sl_action_schema;
% % % schema.tag = "ItemLiquidHeatOfVaporization";
% % % schema.label = "Heat of Vaporization";
% % % schema.callback = @plotLiquidHeatOfVaporization;
% end