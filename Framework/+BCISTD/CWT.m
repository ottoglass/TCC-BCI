classdef CWT < BCISTD.FeatureExtractionFnc
    properties
        Name='CWT';
    end
    methods
        function [Samples]=ExtractFeature(~,C3,Cz,C4)
            cwtC3=cwt(C3);
            win=gausswin(size(cwtC3,2));
            cwtCz=cwt(Cz);
            cwtC4=cwt(C4);
            SampleC3=abs(cwtC3)*win;
            SampleCz=abs(cwtCz)*win;
            SampleC4=abs(cwtC4)*win;
            Samples=[SampleC3;SampleCz;SampleC4];
        end
    end
end