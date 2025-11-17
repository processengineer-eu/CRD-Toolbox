function retrieveBlockParameters(model,filename)

% Retrieve Block Parameters from Model
% (c) Klaus Schnitzlein - 13.12.2024

load_system(sprintf('%s.slx',model));
fp = fopen(filename,'w');

BlockPaths = find_system(model,'Type','Block');
for i = 1:length(BlockPaths)  
  % blockDataSet = partrepo.simscape.dataSetFromBlock(BlockPaths{i});
  % BlockDialogParameters = blockDataSet.Parameters;
  % BlockParameterNames = BlockDialogParameters.fieldNames;
  
  BlockDialogParameters = get_param(BlockPaths{i},'DialogParameters');
  BlockParameterNames = fieldnames(BlockDialogParameters);
  ss = split(strrep(BlockPaths{i},char(10),' '),'/');
  fprintf(fp,'%s\n',ss{2});
  for j = 1:3:length(BlockParameterNames)
    name = BlockParameterNames{j};
    if(contains(BlockParameterNames{j+1},'unit') && ...
        contains(BlockParameterNames{j+2},'conf'))
      value = get_param(BlockPaths{i},BlockParameterNames{j});
      unit = get_param(BlockPaths{i},BlockParameterNames{j+1});
      conf = get_param(BlockPaths{i},BlockParameterNames{j+2});
      fprintf(fp,"%s = %s [%s]\n",name,value,unit);
    else
      break
    end
  end
  fprintf(fp,'\n');
end
fclose(fp);

close_system(model);
