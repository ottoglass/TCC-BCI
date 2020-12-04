classdef BipolarPSD < BCISTD.FeatureExtractionFnc
    properties
        Name='BipolarPSD';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            C3C4=C3-C4;
            C3Cz=C3-Cz;
            C4Cz=C4-Cz;
            PSDC3C4=abs(fft(C3C4)/numel(C3C4)).^2;
            PSDC3Cz=abs(fft(C3Cz)/numel(C3Cz)).^2;
            PSDC4Cz=abs(fft(C4Cz)/numel(C4Cz)).^2;
            Samples=[PSDC3C4;PSDC3Cz;PSDC4Cz];
        end
    end
end
