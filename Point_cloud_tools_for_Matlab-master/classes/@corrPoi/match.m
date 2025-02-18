function obj = match(obj, pc1, pc2, varargin)

% Input parsing ----------------------------------------------------------------

validCorrPoi = {'nn'};

p = inputParser;
p.addRequired(  'pc1'               , @(x) isa(x, 'pointCloud'));
p.addRequired(  'pc2'               , @(x) isa(x, 'pointCloud'));
p.addParamValue('CorrPoi'    , 'nn' , @(x) any(strcmpi(x, validCorrPoi)));
p.addParamValue('SaveIdx'    , false, @islogical); 
p.addParamValue('Prm4normals', []); % options for pointCloud.normals if normals of corresponding points should be estimated
p.parse(pc1, pc2, varargin{:});
p = p.Results;
% Clear required inputs to avoid confusion
clear pc1 pc2

% Start ------------------------------------------------------------------------

procHierarchy = {'CORRPOI' 'MATCH'};
msg('S', procHierarchy);
msg('I', procHierarchy, sprintf('pc1id = ''%d'', pc2id = ''%d''', obj.pc1id, obj.pc2id));
msg('I', procHierarchy, sprintf('IN: CorrPoi = ''%s''', p.CorrPoi));

% Find corresponding points ----------------------------------------------------

if strcmpi(p.CorrPoi, 'nn')

    % Nearest neighbour search
    idxMatch = p.pc2.knnsearch(p.pc1.X(p.pc1.act,:));
    
end

% Estimate normals for corresponding points ? ----------------------------------

if ~isempty(p.Prm4normals)
   
    % Normals for pc1
    p.pc1 = p.pc1.normals(p.Prm4normals{:});
    
    % Normals for pc2
    p.pc2.act(:) = false;
    p.pc2.act(idxMatch) = true;
    p.pc2 = p.pc2.normals(p.Prm4normals{:});
    
end

% Save results to object -------------------------------------------------------

% Save correspondences to object
obj.X1 = p.pc1.X(p.pc1.act,:);
obj.X2 = p.pc2.X(idxMatch ,:);

% Copy all attributes of corresponding points
if ~isempty(p.pc1.A), att1 = fields(p.pc1.A); else att1 = []; end
if ~isempty(p.pc2.A), att2 = fields(p.pc2.A); else att2 = []; end
for a = 1:numel(att1), obj.A1.(att1{a}) = p.pc1.A.(att1{a})(p.pc1.act); end
for a = 1:numel(att2), obj.A2.(att2{a}) = p.pc2.A.(att2{a})(idxMatch);  end

% Weights (initialization with 1)
obj.A.w = ones(numel(idxMatch),1);

% Indices of corresponding points refering to the input point clouds
if p.SaveIdx
    obj.idxPC1 = uint32(find(p.pc1.act));
    obj.idxPC2 = uint32(idxMatch);
end

% End --------------------------------------------------------------------------

msg('E', procHierarchy);
obj.info

end