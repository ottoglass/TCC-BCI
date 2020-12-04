classdef PWelch < BCISTD.FeatureExtractionFnc
    properties
        Name='PWelch';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            PSDC3=pwelch(C3);
            PSDCz=pwelch(Cz);
            PSDC4=pwelch(C4);
            Samples=[PSDC3;PSDCz;PSDC4];
        end
    end
end