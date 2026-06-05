% %% Setup for CRD-Toolbox
%
%    (c) Klaus Schnitzlein - 01.06.2026

fprintf('Setting Path to %s\n',pwd);
addpath('.');
addpath(genpath('Functions')); 
addpath(genpath('Icons')); 
addpath(genpath('Data')); 
addpath(genpath('ExtendedLibrary')); 

fprintf('Setting Root Directory\n');
setenv('root_CRD',pwd);
% userdata(getenv('root_CRD'));

fprintf('Adding Units\n');
pm_addunit('cal',4.1868,'J');
pm_addunit('kcal',4.1868,'kJ');
pm_addunit('kmol',1.0e+03,'mol');
pm_addunit('torr',1.33322e-03,'bar');
pm_addunit('mmHg',1.33322e-03,'bar');

fprintf('Refreshing Simulink Customizations\n');
sl_refresh_customizations;

answer = questdlg('Compilation of Library?', ...
	'Question', ...
	'Yes','No','No');
switch answer
    case 'Yes'
      fprintf('Compiling Library\n');
      ssc_build ChemReactorDesign
      fprintf('Building Help\n');
      setHelperFunction
  case 'No'
    fprintf('Starting Simscape\n');
    run ChemReactorDesign_lib.slx
end

% answer = questdlg('Open Reference Manual?', ...
% 	'Question', ...
% 	'Yes','No','No');
% switch answer
%     case 'Yes'
%       web(sprintf("%s/Reference/Html/Main.html",getenv('root_CRD')),'-browser');
%   case 'No'
% end

% fprintf('Adding Composite Libraries\n');
% addBlockToLibrary('Gas','Composite/Subsystems Gas',40,100)
% addBlockToLibrary('Liquid','Composite/Subsystems Liquid',180,100)
% addBlockToLibrary('Solid','Composite/Subsystems Solid',320,100)
% addBlockToLibrary('Interface','Composite/Subsystems Interface',460,100
