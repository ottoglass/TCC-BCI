classdef Database
    %Database is used to hold and organize
    %extracted features from a TrialCollection object
    %
    
    properties (Access = private)
        C3
        Cz
        C4
        Index
        Labels
        classes=2
    end
    properties
        FeatureExtractionFcn
    end
    
    methods
        
        %%
        function obj=Database(overlap,windowLength,TrialCollection_obj)
            if overlap==0
                OverlapLength=windowLength;
            else
                OverlapLength=(floor(windowLength*overlap));
            end
            L=1;
            for I=1:numel(TrialCollection_obj.EventLabel)
                TrialC3=TrialCollection_obj.C3(:,I);
                TrialC4=TrialCollection_obj.C4(:,I);
                TrialCz=TrialCollection_obj.Cz(:,I);
                for J=1:OverlapLength:(numel(TrialC3)-windowLength)
                    tmpC3=TrialC3(J:(windowLength+J-1));
                    tmpC4=TrialC4(J:(windowLength+J-1));
                    tmpCz=TrialCz(J:(windowLength+J-1));
                    tmpC3=fillmissing(tmpC3,'linear');
                    tmpC4=fillmissing(tmpC4,'linear');
                    tmpCz=fillmissing(tmpCz,'linear');
                    try
                        validateattributes(tmpC3,{'double'},{'vector','finite','nonempty','real'});
                        validateattributes(tmpC4,{'double'},{'vector','finite','nonempty','real'});
                        validateattributes(tmpCz,{'double'},{'vector','finite','nonempty','real'});
                        
                        obj.C3(:,L)=tmpC3;
                        obj.C4(:,L)=tmpC4;
                        obj.Cz(:,L)=tmpCz;
                        if TrialCollection_obj.EventStartSample(I)<=J&&TrialCollection_obj.EventEndSample(I)>=J
                            obj.Labels(L)=TrialCollection_obj.EventLabel(I);
                        else
                            obj.Labels(L)=3;
                        end
                        L=L+1;
                    catch
                    end
                    
                end
            end
            obj.FeatureExtractionFcn.ExtractFeature=@(c3,cz,c4) [c3;cz;c4];
        end
        
        %%
        function [LeftMI,RightMI,NoMI]=getSampleCountPerLabel(obj)
            %Returns the number of samples per label
            %
            LeftMI=numel(find(obj.Labels==1));
            RightMI=numel(find(obj.Labels==2));
            NoMI=numel(find(obj.Labels==3));
        end
        
        %%
        function obj=generateDatasetIndex(obj,numSamples)
            TargetIndexes=find(obj.Labels==1);
            TargetIndexesSize=numel(TargetIndexes);
            if numSamples>TargetIndexesSize
                Indexes1=TargetIndexes(randperm(TargetIndexesSize));
            else
                Indexes1=TargetIndexes(randperm(TargetIndexesSize,numSamples));
            end
            TargetIndexes=find(obj.Labels==2);
            TargetIndexesSize=numel(TargetIndexes);
            if numSamples>TargetIndexesSize
                Indexes2=TargetIndexes(randperm(TargetIndexesSize));
            else
                Indexes2=TargetIndexes(randperm(TargetIndexesSize,numSamples));
            end
            if obj.classes==3
                TargetIndexes=find(obj.Labels==3);
                TargetIndexesSize=numel(TargetIndexes);
                if numSamples>TargetIndexesSize
                    Indexes3=TargetIndexes(randperm(TargetIndexesSize));
                else
                    Indexes3=TargetIndexes(randperm(TargetIndexesSize,numSamples));
                end
                obj.Index=[Indexes1,Indexes2,Indexes3];
            else
                obj.Index=[Indexes1,Indexes2];
            end
        end
        
        %%
        function [dataset]=getDataset(obj)
            for I=1:numel(obj.Index)
                predictor(I,:)=obj.FeatureExtractionFcn.ExtractFeature(...
                    obj.C3(:,obj.Index(I)),...
                    obj.Cz(:,obj.Index(I)),...
                    obj.C4(:,obj.Index(I)))';
            end
            response(:)=obj.Labels(obj.Index);
            dataset=cat(2,predictor,response');
        end
        
        %%
        function [C3,Cz,C4,Label]=getSample(obj,Range)
            C3=obj.C3(:,Range);
            Cz=obj.Cz(:,Range);
            C4=obj.C4(:,Range);
            Label=obj.Labels(:,Range);
        end
        
        %%
        function [SampleCount]=getSampleCount(obj)
            SampleCount=numel(obj.Labels);
        end
        function obj=setFeatureExtractionFcn(obj,FEFunction)
            obj.FeatureExtractionFcn=FEFunction;
        end
        function [Labels]=getLabels(obj)
            Labels=obj.Labels;
        end
        
        function [obj]=setDatasetIndex(obj,Index)
            obj.Index=Index;
        end
    end
end

