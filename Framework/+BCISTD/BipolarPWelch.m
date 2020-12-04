classdef BipolarPWelch < BCISTD.FeatureExtractionFnc
    properties
        Name='BipolarPWelch';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            C3C4=C3-C4;
            C3Cz=C3-Cz;
            C4Cz=C4-Cz;
            PSDC3C4=pwelch(C3C4);
            PSDC3Cz=pwelch(C3Cz);
            PSDC4Cz=pwelch(C4Cz);
            Samples=[PSDC3C4;PSDC3Cz;PSDC4Cz];
        end
    end
end