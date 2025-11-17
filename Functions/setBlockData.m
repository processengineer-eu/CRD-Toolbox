function setBlockData(model,block,varargin)
%% Parameter Settings for Block in Model
% - revised and improved version
% - extended to logical values
%
% (c) Klaus Schnitzlein - 28.07.2025

if(mod(length(varargin),2)~=0)
  error('invalid number arguments');
end

for i=1:2:nargin-2
  names = varargin{i};
  values = varargin{i+1};
  if(islogical(values)) % neu 
    set_param(sprintf('%s/%s',model,block),names,values);
  elseif(ischar(values)) % neu
    set_param(sprintf('%s/%s',model,block),names,values);
  else
    if(isa(values,'simscape.Value'))
      set_param(sprintf('%s/%s',model,block),names,mat2str(value(values)));
      set_param(sprintf('%s/%s',model,block),sprintf('%s_unit',names),char(unit(values)));
    else
      set_param(sprintf('%s/%s',model,block),names,mat2str(values));
    end
  end
end
end

  



