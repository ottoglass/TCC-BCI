clear all
biosig_installer
Trialset=BCISTD.TrialCollection('B0801T.gdf');
SampleDB=BCISTD.Database(0,1000,Trialset);
SampleDB=SampleDB.generateDatasetIndex(min(SampleDB.getSampleCountPerLabel()));
Trialset=BCISTD.TrialCollection('B0802T.gdf');
SampleDB2=BCISTD.Database(0,1000,Trialset);
SampleDB2=SampleDB2.generateDatasetIndex(min(SampleDB2.getSampleCountPerLabel()));
Trialset=BCISTD.TrialCollection('B0803T.gdf');
SampleDB3=BCISTD.Database(0,1000,Trialset);
SampleDB3=SampleDB3.generateDatasetIndex(min(SampleDB3.getSampleCountPerLabel()));
SampleDB.FeatureExtractionFcn=BCISTD.PWelch;
SampleDB2.FeatureExtractionFcn=BCISTD.PWelch;
SampleDB3.FeatureExtractionFcn=BCISTD.PWelch;
% NNClassifier=BCISTD.NN();
% NNClassifier.TrainingDataset=SampleDB.generateDataset();
% NNClassifier=NNClassifier.train();

data=cat(1,SampleDB.generateDataset(),SampleDB2.generateDataset(),SampleDB3.generateDataset());
indexes=find(data(:,end)~=3);
data2=data(indexes,:);
%  net=BCISTD.NN();
%  net.TrainingDataset=data;
%  net=net.train();