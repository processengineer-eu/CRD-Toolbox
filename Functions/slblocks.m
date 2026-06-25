function blkStruct = slblocks
% This function specifies that the library 'ChemReactorDesign_lib'
% should appear in the Library Browser with the 
% name 'Chemical Reactor Design Toolbox'

    Browser(1).Library = 'ChemReactorDesign_lib';
    Browser(1).Name = 'Chemical Reactor Design ToolBox';
    
    Browser(2).Library = 'ExtendedLibrary';
    Browser(2).Name = 'Chemical Reactor Design Extended Library';
    
    Browser(3).Library = 'PDELibrary_lib';
    Browser(3).Name = 'Chemical Reactor Design PDE Library';
   
    Browser(4).Library = 'CompositeLibrary_lib';
    Browser(4).Name = 'Composite Library';

    blkStruct.Browser = Browser;

