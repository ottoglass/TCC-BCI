function SampleDB2imgDB(SampleDB,PATH,varargin)
numIteration=0;
for M=1:numel(SampleDB)
    numIteration=numIteration+SampleDB{M}.getSampleCount();
end
% mkdir([PATH '\1']);
% mkdir([PATH '\2']);
% mkdir([PATH '\3']);
L=1;
h=waitbar(0,['creating image 0 out of ',num2str(numIteration),' images...']);
if nargin==1
    for M=1:numel(SampleDB)
        tmpSampleDB=SampleDB{M};
        for I=1:tmpSampleDB.getSampleCount()
            
            h=waitbar(L/numIteration,h,['creating image ',num2str(L),' out of ',num2str(numIteration),' images...']);
            
            [C3,Cz,C4,Label]=tmpSampleDB.getSample(I);
            C3=fillmissing(C3,'linear');
            Cz=fillmissing(Cz,'linear');
            C4=fillmissing(C4,'linear');
            data(:,:,1)=abs(cwt(C3,250));
            data(:,:,2)=abs(cwt(Cz,250));
            data(:,:,3)=abs(cwt(C4,250));
            min_data=min(data(:));
            max_data=max(data(:));
            data_norm = (data - min_data)/(max_data - min_data);
            imwrite(data_norm,strcat(PATH,'\',num2str(Label),'\',num2str(L),'.png'));
            L=L+1;
            clear data data_norm
        end
        clear tmpSampleDB
    end
else
    for M=1:numel(SampleDB)
        tmpSampleDB=SampleDB{M};
        for I=1:tmpSampleDB.getSampleCount()
            
            h=waitbar(L/numIteration,h,['creating image ',num2str(L),' out of ',num2str(numIteration),' images...']);
            
            [C3,Cz,C4,Label]=tmpSampleDB.getSample(I);
            C3=fillmissing(C3,'linear');
            Cz=fillmissing(Cz,'linear');
            C4=fillmissing(C4,'linear');
            C3=filter(varargin{1},C3);
            Cz=filter(varargin{1},Cz);
            C4=filter(varargin{1},C4);
            C3=fillmissing(C3,'linear');
            Cz=fillmissing(Cz,'linear');
            C4=fillmissing(C4,'linear');
            data(:,:,1)=abs(cwt(C3,250));
            data(:,:,2)=abs(cwt(Cz,250));
            data(:,:,3)=abs(cwt(C4,250));
            min_data=min(data(:));
            max_data=max(data(:));
            data_norm = (data - min_data)/(max_data - min_data);
            imwrite(data_norm,strcat(PATH,'\',num2str(Label),'\',num2str(L),'.png'));
            L=L+1;
            clear data data_norm
        end
        clear tmpSampleDB
    end
end
close(h)
end