function help_url = crt_help(~)

  % Eintragen des html-Files in die Help-Variable eines Blocks  
  %
  % (c) Norbert Heinzelmann, Klaus Schnitzlein - 10.11.2025

  % name = get(block_handle,'Name')
  % parent = get(block_handle,'MaskValueString');

  url = 'https://oocrd.processengineer.eu';
  parent = get(gcbh,'MaskValueString');
  splitseparator = split(parent,'|');
  parent = splitseparator{1};
  parentsplit = split(parent,'.');
  domain = '';
  for i = 2:length(parentsplit)-1
    domain = append(domain,parentsplit{i},'/');
  end
  name = parentsplit{end};
  % help_url = sprintf('%s/Reference/Html/%s/%s.html',getenv('root_CRD'),domain,name);
  help_url = sprintf('%s/%s%s.html',url,domain,name);
  % if (~isfile(help_url))
  %   help_url = ''; % das ist der Originaleintrag
  % end
end