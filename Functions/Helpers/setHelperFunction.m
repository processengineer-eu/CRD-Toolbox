% Eintragen des Helpers in die Maske der Blöcke
%
% (c) Norbert Heinzelmann, Klaus Schnitzlein - 09.09.2025

clear
model = 'ChemReactorDesign_lib';
load_system(model);
set_param(model,'Lock','off');
BlockPaths = find_system(model,'Type','Block');
for i = 1:length(BlockPaths)
    MO = get_param(BlockPaths{i},'MaskObject');
    if (~isempty(MO.Type))
        % set(MO,'Help','web(crt_help(gcbh),''-browser'')'); % added
        set(MO,'Help','web(crt_help(gcbh))'); % original
    end
end
save('Functions/blocks.mat','BlockPaths')
set_param(model,'Lock','on');
fileattrib('ChemReactorDesign_lib.slx','+w');
save_system(model)
fileattrib('ChemReactorDesign_lib.slx','-w');