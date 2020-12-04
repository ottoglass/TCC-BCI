classdef PSD < BCISTD.FeatureExtractionFnc
    properties
        Name='PSD';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            PSDC3=abs(fft(C3)/numel(C3)).^2;
            PSDCz=abs(fft(Cz)/numel(Cz)).^2;
            PSDC4=abs(fft(C4)/numel(C4)).^2;
            Samples=[PSDC3;PSDCz;PSDC4];
        end
    end
end