classdef gaussianSVM < BCISTD.Classifier
    %Gaussian kernel ECOC SVM  Summary of this class goes here
    %   Detailed explanation goes here     
    properties
       TrainingDataset;
       Model;
       KernelScaleProperty;
       Name;
    end
    
    methods
        function obj=gaussianSVM(KernelScale,varargin)
            if nargin==2
                obj.Name=varargin{1};
            else
                obj.Name='Gaussian SVM';
            end
            obj.KernelScaleProperty=KernelScale;
        end
        function obj=train(obj)
            numFeatures=size(obj.TrainingDataset,2)-1;
            if(isnumeric(obj.KernelScaleProperty))
                KernelScale=obj.KernelScale*sqrt(numFeatures);
            else
                switch obj.KernelScaleProperty
                    case 'fine'
                        KernelScale=floor(sqrt(numFeatures)/4);
                    case 'medium'
                        KernelScale=floor(sqrt(numFeatures));
                    case 'Coarse'
                        KernelScale=floor(sqrt(numFeatures)*4);
                    otherwise
                        KernelScale='auto';
                end
            end
            predictors=obj.TrainingDataset(:,1:(numFeatures));
            response=obj.TrainingDataset(:,numFeatures+1);
            template=templateSVM(...
                'KernelFunction','gaussian',...
                'PolynomialOrder', [], ...
                'KernelScale', KernelScale, ...
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

