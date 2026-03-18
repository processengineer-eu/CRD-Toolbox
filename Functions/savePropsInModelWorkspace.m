% Reading Props from Matlab Workspace and Writing to Model Morkspace
%
% (c) Klaus Schnitzlein - 14.01.2026

function savePropsInModelWorkspace

  % fprintf('writing props* to model workspace\n');
  if(exist(bdroot(gcs)+".slx",'file'))
    sl = Simulink.data.connect(bdroot(gcs)+".slx");

    ise = evalin('base','exist(''propsLiquid'',''var'') == 1');
    if(ise)
      propsLiquid = evalin('base','propsLiquid');
      sl.set('propsLiquid',propsLiquid);
      % fprintf('propsLiquid written to model workspace\n')
      clear propsLiquid;
    end
        
    ise = evalin('base','exist(''propsGas'',''var'') == 1');
    if(ise)
      propsGas = evalin('base','propsGas');
      sl.set('propsGas',propsGas);
      % fprintf('propsGas written to model workspace\n')
      clear propsGas;
    end

    ise = evalin('base','exist(''propsSolid'',''var'') == 1');
    if(ise)
      propsSolid = evalin('base','propsSolid');
      sl.set('propsSolid',propsSolid);
      % fprintf('propSolid written to model workspace\n')
      clear propsSolid;
    end
  else
    warning('model %s not found on path\n',bdroot(gcs)+".slx");
  end
end