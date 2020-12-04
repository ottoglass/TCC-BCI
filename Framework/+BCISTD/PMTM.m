classdef PMTM < BCISTD.FeatureExtractionFnc
    properties
        Name='PMTM';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            PSDC3C4=pmtm(C3);
            PSDC3Cz=pmtm(Cz);
            PSDC4Cz=pmtm(C4);
            Samples=[PSDC3C4;PSDC3Cz;PSDC4Cz];
        end
    end
end