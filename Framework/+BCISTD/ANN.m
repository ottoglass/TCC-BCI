classdef ANN < BCISTD.Classifier
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       TrainingDataset;
       Model;
       Name;
    end
    
    methods
        function obj=ANN(varargin)
            if nargin==0
                obj.Model=patternnet([20 20]);
                obj.Name='NeuralNetwork';
            else
                if ischar(varargin{1})
                    obj.Name=varargin{1};
                    if nargin==2
                        obj.Model=patternnet(varargin{2});
                    end
                else
                    obj.Model=patternnet(varargin{1});
                    obj.Name=strcat('NeuralNetwork',num2str(varargin{1}));
                end
            end
            obj.Model.trainParam.epochs=2000;
            obj.Model.trainParam.goal=0.1;
            obj.Model.trainParam.showWindow=false;
            obj.Model.trainParam.showCommandLine=true;
        end
        function obj=train(obj)
            SIZE=size(obj.TrainingDataset);
            Labels=(obj.TrainingDataset(:,SIZE(2)));
            Targets=zeros(SIZE(1),3);
            for I=1:SIZE(1)
                Targets(I,Labels(I))=1;
            end
            Targets=Targets';
            Samples=obj.TrainingDataset(:,1:(SIZE(2)-1))';
            obj.Model=configure(obj.Model,Samples,Targets);
            obj.Model=train(obj.Model,Samples,Targets);
        end
        function [result]=predict(obj,Sample) 
            response=obj.Model(Sample');
            
            [~,resultT]=max(response);
              result=resultT';
        end
    end
    
end

