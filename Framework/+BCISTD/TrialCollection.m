classdef TrialCollection
    %TrialCollection
    %   This class is meant hold trial data
    
    properties
        C3
        Cz
        C4
        EventStartSample
        EventEndSample
        EventLabel
    end
    
    methods
        function  obj=TrialCollection(path,varargin)
        %    obj=TrialCollection(path)
        %    obj=TrialCollection(path,labels)
            if(exist("sload","file")~=0)
                switch nargin
                    case 1
                    [S,H]=sload(path);
                    [eog_b]=regress_eog(S(1:7500,:),[1 2 3],[4 5 6]);
                    data=S*eog_b.r0;
                    clear S eog_b
                    Index=1;
                    for I=1:(numel(H.EVENT.TYP))
                        M=0;
                        if H.EVENT.TYP(I)==768
                        %---- Finding Trial Start Index
                            M=I;
                            Event=H.EVENT.TYP(M);
                            while (~((Event==770)||(Event==769)))&&(M<=numel(H.EVENT.POS))
                                M=1+M; 
                                Event=H.EVENT.TYP(M);
                            end
                            %---- Defining Event and Trial Interval

                            TrialStart=H.EVENT.POS(I);
                            TrialEnd=H.EVENT.POS(I)+H.EVENT.DUR(I);
                            EventStart=H.EVENT.POS(M);
                            EventEnd=H.EVENT.POS(M)+H.EVENT.DUR(M);
                            obj.C3(:,Index)=[data(TrialStart:TrialEnd,1)];
                            obj.Cz(:,Index)=[data(TrialStart:TrialEnd,2)];
                            obj.C4(:,Index)=[data(TrialStart:TrialEnd,3)];
                            obj.EventStartSample(Index)=EventStart-TrialStart;
                            obj.EventEndSample(Index)=EventEnd-TrialStart;
                            if H.EVENT.TYP(M)==769
                                obj.EventLabel(Index)=1;
                            end
                            if H.EVENT.TYP(M)==770  
                                obj.EventLabel(Index)=2;
                            end
                            Index=Index+1;
                        end
                    end
                    case 2
                        [S,H]=sload(path);
                        [eog_b]=regress_eog(S(1:7500,:),[1 2 3],[4 5 6]);
                        data=S*eog_b.r0;
                        clear S eog_b
                        Index=1;
                        for I=1:(numel(H.EVENT.TYP))
                            if H.EVENT.TYP(I)==768
                            TrialStart=H.EVENT.POS(I);
                            TrialEnd=H.EVENT.POS(I)+H.EVENT.DUR(I);
                            obj.C3(:,Index)=[data(TrialStart:TrialEnd,1)];
                            obj.Cz(:,Index)=[data(TrialStart:TrialEnd,2)];
                            obj.C4(:,Index)=[data(TrialStart:TrialEnd,3)];
                            obj.EventStartSample(Index)=750;
                            obj.EventEndSample(Index)=1063;
                            Index=Index+1;
                            end
                            
                        end
                        obj.EventLabel=[varargin{1}]';
                        %---- Finding Trial Start Index
                    otherwise
                        error('Incorect number of arguments');
                end
            else
                error('BIOSIG not loaded')
            end
            
        end
    end
    
end

