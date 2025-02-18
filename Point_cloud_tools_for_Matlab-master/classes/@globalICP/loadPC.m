function pc = loadPC(objICP, i)
% LOADPC Load point cloud to workspace.
% ------------------------------------------------------------------------------
% DESCRIPTION/NOTES
% With this method a point cloud which was previously added to the globalICP
% object, can be loaded to the workspace.
% ------------------------------------------------------------------------------
% INPUT
% [i]
% Index of point cloud to load.
% ------------------------------------------------------------------------------
% EXAMPLES
% Call 'help globalICP.globalICP' for a minimal working example, which also 
% includes this method.
% ------------------------------------------------------------------------------
% philipp.glira@geo.tuwien.ac.at
% ------------------------------------------------------------------------------
    
load(objICP.PC{i});
pc = obj;

end