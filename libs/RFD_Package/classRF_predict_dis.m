%**************************************************************
%* mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
%* Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
%* License: GPLv2
%* Version: 0.02
%
% Calls Classification Random Forest
% A wrapper matlab file that calls the mex file
% This does prediction given the data and the model file
% Options depicted in predict function in http://cran.r-project.org/web/packages/randomForest/randomForest.pdf
%**************************************************************
%function [Y_hat votes] = classRF_predict(X,model, extra_options)
% requires 2 arguments
% X: data matrix
% model: generated via classRF_train function
% extra_options.predict_all = predict_all if set will send all the prediction. 
%
%
% Returns
% Y_hat - prediction for the data
% votes - unnormalized weights for the model
% prediction_per_tree - per tree prediction. the returned object .
%           If predict.all=TRUE, then the individual component of the returned object is a character
%           matrix where each column contains the predicted class by a tree in the forest.
% proximity_ts - proximity of training to the test set
% 
% Not yet implemented
% proximity

% function [Y_new, votes, prediction_per_tree,proximity_ts] = classRF_predict_dis(X,model, extra_options)
function [dists,Y_hat, votes, prediction_per_tree,proximity_ts] = classRF_predict_dis(X,model, extra_options)
    
    if nargin<2
		error('need atleast 2 parameters,X matrix and model');
    end
    
    if exist('extra_options','var')
        if isfield(extra_options,'predict_all') 
            predict_all = extra_options.predict_all;
        end
        if isfield(extra_options,'proximity') 
            proximity = extra_options.proximity;
        end
    end
    
    if ~exist('predict_all','var'); predict_all=0;end
            
    if ~exist('proximity','var'); proximity=0;end
        
    predict_all = 1; %[1,2]  ===  [-1,1]
	[Y_hat,prediction_per_tree,votes,proximity_ts] = mexClassRF_predict(X',model.nrnodes,model.ntree,model.xbestsplit,model.classwt,model.cutoff,model.treemap,model.nodestatus,model.nodeclass,model.bestvar,model.ndbigtree,model.nclass, predict_all, proximity);
	%keyboard
%     votes = votes';
%     
%     clear mexClassRF_predict
%     
%     Y_new = double(Y_hat);
%     new_labels = model.new_labels;
%     orig_labels = model.orig_labels;
%     
%     for i=1:length(orig_labels)
%         Y_new(find(Y_hat==new_labels(i)))=Inf;
%         Y_new(isinf(Y_new))=orig_labels(i);
%     end
    prediction_per_tree(prediction_per_tree==2)=0;%-1; % 0
    %prediction_per_tree = double(prediction_per_tree).*repmat((model.importance)', size(prediction_per_tree,1),1);
    dists = sum(prediction_per_tree,2);
    
    1;
    