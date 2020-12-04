classdef (Abstract) Classifier
    %Classifier Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Abstract)
        TrainingDataset;
        Model;
        Name;
    end
    
    methods(Abstract)
        obj=train(obj)
        [result]=predict(obj,Sample)
    end
    methods(Access=protected)
        function [prediction]=trialPrediction(obj,data)
             predictions=obj.predict(data(:,(1:end-1)));
             prediction=mode(predictions);
        end
    end
    methods(Access=protected,Static)
        function [groups]=findGroups(labels)
            indexes=find((~(diff(labels)==0))==1);
            groups(1,:)=[1 indexes(1)];
            for I=2:numel(indexes)
                groups(I,:)=[(indexes(I-1)+1) indexes(I)];
            end
        end
    end
    methods
        function [Kappa, Accuracy]=calculatePerformance(obj,ValidationSet)
            predictors=ValidationSet(:,(1:end-1));
            trueresponse=ValidationSet(:,end);
            response=obj.predict(predictors);
            
            Accuracy=numel(find(trueresponse==response))/numel(response);
            Acc0=1/numel(unique(trueresponse));
            Kappa=(Accuracy-Acc0)/(1-Acc0);
        end
        function [Model]=exportModel(obj)
            Model=obj.Model;
        end
        function obj=loadModel(obj,Model)
            obj.Model=Model;
        end
        function obj=loadTrainingData(obj,TrainingDataset)
            obj.TrainingDataset=TrainingDataset;
        end
        
        function [Kappa,ACC]=fullTrialPerformance(obj,ValidationDB)
            Data=[];
            for I=1:numel(ValidationDB)
                label=ValidationDB{I}.getLabels();
                Index=find((label==1)|(label==2));
                DB=ValidationDB{I};
                DB=DB.setDatasetIndex(Index);
                Data=cat(1,Data,DB.getDataset());
            end
            groups=obj.findGroups(Data(:,end));
            for I=1:length(groups)
                groupIndex=[groups(I,1):groups(I,2)];
                predictions(I,1)=obj.trialPrediction(Data(groupIndex,:));
            end            
            labels=Data(groups(:,1),end);
            ACC=numel(find(predictions==labels))/numel(predictions);
            Acc0=1/numel(unique(labels));
            Kappa=(ACC-Acc0)/(1-Acc0);
        end
    end
end

