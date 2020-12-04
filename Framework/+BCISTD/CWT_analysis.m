clear all
biosig_installer
Trialset=BCISTD.TrialCollection('B0901T.gdf');
TrialNum=9;
Trialset.EventLabel(TrialNum)
window=[750:1063];
subplot(1,3,1)
cwt(Trialset.C3(window,TrialNum),250);
title('C3');
subplot(1,3,2)
cwt(Trialset.Cz(window,TrialNum),250);
title('Cz');
subplot(1,3,3)
cwt(Trialset.C4(window,TrialNum),250);
title('C4');
% % subplot(2,3,4)
% data2(:,:,1)=abs(cwt(Trialset.C3(:,TrialNum)-Trialset.C4(:,1),250));
% % title('C3-C4');
% % subplot(2,3,5)
% data2(:,:,2)=abs(cwt(Trialset.C3(:,TrialNum)-Trialset.Cz(:,1),250));
% % title('C3-Cz');
% % subplot(2,3,6)
% data2(:,:,3)=abs(cwt(Trialset.C4(:,TrialNum)-Trialset.Cz(:,1),250));
% % title('C4-Cz');

