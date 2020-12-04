classdef Subject
    properties
        TrainingDataPath
        EvaluationDataPath
        EvaluationLabelPath
    end
    
    methods
        function obj=Subject(Training_Data_Path,Evaluation_Data_Path,Evaluation_Label_Path)
            obj.TrainingDataPath=Training_Data_Path;
            obj.EvaluationDataPath=Evaluation_Data_Path;
            obj.EvaluationLabelPath=Evaluation_Label_Path;
        end
    end
    
end

