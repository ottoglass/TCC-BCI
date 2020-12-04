classdef kNN < BCISTD.Classifier
    %kNN Classifier Summary of this class goes here
    %   Detailed explanation goes here     
    properties
       TrainingDataset;
       Model;
       k;
       Name;
    end
    
    methods
        function obj=kNN(numNeighbors,varargin)
            if nargin==2
                obj.Name=varargin{1};
            else
                obj.Name=cat(2,num2str(numNeighbors),'-NN');
            end
            obj.k=numNeighbors;
        end
        function obj=train(obj)
            predictors=obj.TrainingDataset(:,1:(size(obj.TrainingDataset,2)-1));
            response=obj.TrainingDataset(:,size(obj.TrainingDataset,2));
            obj.Model = fitcknn(...
                predictors, ...
                response, ...
                'Distance', 'Euclidean', ...
                'Exponent', [], ...
                'BreakTies','nearest',...
                'NumNeighbors', obj.k, ...
                'DistanceWeight', 'Equal', ...
                'Standardize', true ...
                );
        end
        function [result]=predict(obj,Sample)
            result=predict(obj.Model,Sample);
        end
    end
    
end

