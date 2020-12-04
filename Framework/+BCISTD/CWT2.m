classdef CWT2 < BCISTD.FeatureExtractionFnc
    properties
        Name='CWT2';
        numMeans;
    end
    methods
        function obj=CWT2(numMeans)
            obj.numMeans=numMeans;
            obj.Name=['CWT2-',num2str(numMeans)];
        end
        function [Samples]=ExtractFeature(obj,C3,Cz,C4)
            try
                validateattributes(C3,{'double'},{'vector','finite','nonempty','real'});
                validateattributes(C4,{'double'},{'vector','finite','nonempty','real'});
                validateattributes(Cz,{'double'},{'vector','finite','nonempty','real'});
                cwtC3=abs(cwt(C3));
                cwtCz=abs(cwt(Cz));
                cwtC4=abs(cwt(C4));
                numElements=floor(size(cwtC3,2)/obj.numMeans);
                SampleC3=mean(cwtC3(:,1:(numElements)),2);
                SampleCz=mean(cwtCz(:,1:(numElements)),2);
                SampleC4=mean(cwtC4(:,1:(numElements)),2);
                
                for I=numElements:numElements:(size(cwtC3,2)-numElements)
                    SampleC3=cat(1,SampleC3,mean(cwtC3(:,I:(numElements+I)),2));
                    SampleCz=cat(1,SampleCz,mean(cwtCz(:,I:(numElements+I)),2));
                    SampleC4=cat(1,SampleC4,mean(cwtC4(:,I:(numElements+I)),2));
                end
                Samples=[SampleC3;SampleCz;SampleC4];
            catch
                try
                C3=fillmissing(C3,'nearest');
                Cz=fillmissing(Cz,'nearest');
                C4=fillmissing(C4,'nearest');
                cwtC3=abs(cwt(C3));
                cwtCz=abs(cwt(Cz));
                cwtC4=abs(cwt(C4));
                numElements=floor(size(cwtC3,2)/obj.numMeans);
                SampleC3=mean(cwtC3(:,1:(numElements)),2);
                SampleCz=mean(cwtCz(:,1:(numElements)),2);
                SampleC4=mean(cwtC4(:,1:(numElements)),2);
                
                for I=numElements:numElements:(size(cwtC3,2)-numElements)
                    SampleC3=cat(1,SampleC3,mean(cwtC3(:,I:(numElements+I)),2));
                    SampleCz=cat(1,SampleCz,mean(cwtCz(:,I:(numElements+I)),2));
                    SampleC4=cat(1,SampleC4,mean(cwtC4(:,I:(numElements+I)),2));
                end
                Samples=[SampleC3;SampleCz;SampleC4];
                catch
                    error('Argunment is not finite')
                end
            end
        end
    end
end