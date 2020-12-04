classdef BipolarCWT < BCISTD.FeatureExtractionFnc
    properties
        Name='BipolarCWT';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            C3C4=C3-C4;
            C3Cz=C3-Cz;
            C4Cz=C4-Cz;
            cwtC3C4=cwt(C3C4);
            win=gausswin(size(cwtC3C4,2));
            cwtC3Cz=cwt(C3Cz);
            cwtC4Cz=cwt(C4Cz);
            SampleC3C4=abs(cwtC3C4)*win;
            SampleC3Cz=abs(cwtC3Cz)*win;
            SampleC4Cz=abs(cwtC4Cz)*win;
            Samples=[SampleC3C4;SampleC3Cz;SampleC4Cz];
        end
    end
end