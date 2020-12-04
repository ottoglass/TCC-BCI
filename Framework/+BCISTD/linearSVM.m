classdef linearSVM < BCISTD.Classifier
    %Gaussian kernel ECOC SVM  Summary of this class goes here
    %   Detailed explanation goes here     
    properties
       TrainingDataset;
       Model;
       KernelScale;
       Name;
    end
    
    methods
        function obj=linearSVM(varargin)
            if nargin==1
                obj.Name=varargin{1};
            else
                obj.Name='Linear SVM';
            end
        end
        function obj=train(obj)
            predictors=obj.TrainingDataset(:,1:(size(obj.TrainingDataset,2)-1));
            response=obj.TrainingDataset(:,size(obj.TrainingDataset,2));
            template=templateSVM(...
                'KernelFunction','linear',...
                'PolynomialOrder', [], ...
                'KernelScale', 'auto', ...
                'BoxConstraint', 1, ...
                'Standardize', true);
            obj.Model = fitcecoc(...
                predictors, ...
                response, ...
                'Learners', template, ...
                'Coding', 'onevsone' ...
                );
        end
        function [result]=predict(obj,Sample)
            result=predict(obj.Model,Sample);
        end
    end
    
end