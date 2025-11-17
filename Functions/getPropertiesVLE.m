function val = getPropertiesVLE(Ids,Tvar)
  % Retrieving VLE Data with Species Ids
  % (c) Klaus Schnitzlein - 03.04.2025

  N = length(Ids);
  nT = length(Tvar);
  database = sprintf('%s/Data',getenv('root_CRD'));

  if(sum(Ids) == 0) % keine Spezies gesetzt, default
    val = zeros(N,nT);
    return
  end

  table_T = simscape.Value(Tvar,'K');
  Tmin = table_T(1);
  Tmax = table_T(end);
  np = length(table_T);

  [s,keys] = enumeration('ChemReactorDesign.Basic.Liquid.enum.SpeciesName');
  mapSpecies = s.displaySpecies;
  mapFiles = s.displayFileName;
  species = cell(N,1);
  for i=1:N
    species{i} = mapSpecies(keys{Ids(i)});
  end
  fileNames = cell(1,N);
  for i=1:length(species)
    for j=1:length(keys)
      if(strcmp(species{i},mapSpecies(keys{j})))
        fileNames{i} = mapFiles(keys{j});
      end
    end
  end

  Tc = simscape.Value(zeros(N,1),'K');
  pvap0 = zeros(N,7);
  for i=1:length(species)
    filename = sprintf("%s/%s.xml",database,fileNames{i});
    data = readstruct(filename);
    pvap0(i,1) = data.VaporPressure.eqno.valueAttribute;
    pvap0(i,2) = simscape.Value(1,strrep(data.VaporPressure.unitsAttribute,'.','*'))/...
      simscape.Value(1,'Pa');
    pvap0(i,3:7) = [data.VaporPressure.A.valueAttribute...
      data.VaporPressure.B.valueAttribute...
      data.VaporPressure.C.valueAttribute...
      data.VaporPressure.D.valueAttribute,...
      data.VaporPressure.E.valueAttribute];
    if(value(Tmin,'K')<data.VaporPressure.Tmin.valueAttribute)
      warning('mu0: %s - T(%g) < Tmin(%g)\n',species{i},...
        value(Tmin,'K'),data.VaporPressure.Tmin.valueAttribute);
    end
    if(value(Tmax,'K')<data.VaporPressure.Tmin.valueAttribute)
      warning('mu0: %s - T(%g) > Tmax(%g)\n',species{i},...
        value(Tmax,'K'),data.VaporPressure.Tmin.valueAttribute);
    end
    Tc(i) = simscape.Value(data.CriticalTemperature.valueAttribute,...
      data.CriticalTemperature.unitsAttribute);
  end
  table_pvap = simscape.Value(zeros(N,np),'Pa');
  for k=1:np
    table_pvap(:,k) = getPvap(pvap0,value(Tc,'K'),value(table_T(k),'K'));
  end
  val = value(table_pvap,'bar')';
  propsVLE.table_pvap = table_pvap';
  
  % speichere im Matlab Workspace 
  if(~isempty(gcs))
    assignin('base','propsVLE',propsVLE);
  end
end
