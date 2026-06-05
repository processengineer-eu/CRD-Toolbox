function myTestCallback(~, callbackInfo)
% msgbox("Test1 menu invoked");
name = get_param(gcbh,'Name');
fprintf('name = %s\n',name);
if(contains(name,'Properties'))
  fprintf('das ist der Properties Block\n');
  fprintf('N = %d\n',get_param(gcb,'N'));
else
  warning('no Properties Block selected\n');
end
end
