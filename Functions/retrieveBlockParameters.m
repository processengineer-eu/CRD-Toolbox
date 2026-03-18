%% Retrieve Block Parameters from Model
% The data will be stored in the BlockParameters folder in individual files
% 
% (c) Klaus Schnitzlein - 29.01.2025

function retrieveBlockParameters(model)

if(~exist('BlockParameters','dir'))
  mkdir([pwd '/' 'BlockParameters']);
end

load_system(model);

BlockPaths = find_system(model,'LookUnderModelBlocks','on','Type','Block');
for i = 1:length(BlockPaths)  
  type = get_param(BlockPaths{i},'BlockType');
  if(strcmp(type,'SimscapeBlock'))
    blockDataSet = partrepo.simscape.dataSetFromBlock(BlockPaths{i});
    ss = split(strrep(BlockPaths{i},'newline',' '),'/');
    % fprintf('%s - %s\n',BlockPaths{i},type);
    fileName = 'BlockParameters/';
    for j=2:length(ss)-1
      fileName = strcat(fileName,ss{j},'_'); 
    end
    fileName = strcat(fileName,ss{end});
    fileName = strrep(fileName,'\n',' ');
    blockDataSet.Metadata.Manufacturer = "Klaus Schnitzlein";
    blockDataSet.Metadata.PartNumber = ss{end};
    partrepo.exportDataSetsToJSON(blockDataSet,fileName);
  end
end

% fp = fopen(filename,'w');
% 
% BlockPaths = find_system(model,'Type','Block');
% for i = 1:length(BlockPaths)  
%   % blockDataSet = partrepo.simscape.dataSetFromBlock(BlockPaths{i});
%   % BlockDialogParameters = blockDataSet.Parameters;
%   % BlockParameterNames = BlockDialogParameters.fieldNames;
% 
%   BlockDialogParameters = get_param(BlockPaths{i},'DialogParameters');
%   BlockParameterNames = fieldnames(BlockDialogParameters);
%   ss = split(strrep(BlockPaths{i},char(10),' '),'/');
%   fprintf(fp,'%s\n',ss{2});
%   for j = 1:3:length(BlockParameterNames)
%     name = BlockParameterNames{j};
%     if(contains(BlockParameterNames{j+1},'unit') && ...
%         contains(BlockParameterNames{j+2},'conf'))
%       value = get_param(BlockPaths{i},BlockParameterNames{j});
%       unit = get_param(BlockPaths{i},BlockParameterNames{j+1});
%       conf = get_param(BlockPaths{i},BlockParameterNames{j+2});
%       fprintf(fp,"%s = %s [%s]\n",name,value,unit);
%     else
%       break
%     end
%   end
%   fprintf(fp,'\n');
% end
% fclose(fp);
%close_system(model);
