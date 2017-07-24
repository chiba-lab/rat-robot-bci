
%% Expands The Vectors Into Nx1000 Matrices

load('ProjectData.mat')

L = 1000; %1250, 1500

lfp = {'mob', 'ca2', 'amyg'};
condition = {'Rat', 'Groom', 'Baseline'};

for c = 1:3 % Baseline, Groom. Rat
    for l = 1:3    
    ConditionLfpIndex = sprintf('Project.%s.%s', condition{c}, lfp{l})
    NewLfpIndex = sprintf('Project.New%s.%s', condition{c}, lfp{l})
    RRSD17count = 1;
    RRSD18count = 1;
    
    %for mob, ca2, amyg
    eval(['CurrentData = ' ConditionLfpIndex]);
        for i = 2:size(CurrentData, 1)

            Vector = CurrentData{i, 1}; 
            N = floor(size(Vector, 2)/L)
            clear DataMat
            DataMat = [];
                for j = 1:N
                    DataVec = Vector((((j-1)*L)+1):j*L);
                    DataMat(j,:) = DataVec;
                end
                
           condLfpRatString = sprintf('char(%s{i, 2}{1,2});', ConditionLfpIndex);   
           compareString = eval(condLfpRatString);
           
            if compareString == 'RRSD17' 
                string = sprintf('%s.RRSD17{RRSD17count,1} = DataMat;', NewLfpIndex)
                eval(string);  
                RRSD17count = RRSD17count+1;
            elseif compareString == 'RRSD18' 
                string = sprintf('%s.RRSD18{RRSD18count,1} = DataMat;', NewLfpIndex)
                eval(string);  
                RRSD18count = RRSD18count+1;
            end
        %     Project.NewGroom.mob{i,1} = DataMat;
        %     Project.NewGroom.mob{i,2} = Project.Groom.mob{i, 2};

        end
    end
end


%% 
sizeEvent = size(NewProject.NewGroom.mob.RRSD17,1)
NewMat = [];

for i = 2:sizeEvent
    NewMat = [NewMat; NewProject.NewGroom.mob.RRSD17{i,1}];
end

%% 
sizeEvent = size(NewProject.NewGroom.mob.RRSD18,1)
NewMat = [];

for i = 2:sizeEvent
    NewMat = [NewMat; NewProject.NewGroom.mob.RRSD18{i,1}];
end

%% 
sizeEvent = size(NewProject.NewBaseline.mob.RRSD17,1)
NewMat = [];

for i = 2:sizeEvent
    NewMat = [NewMat; NewProject.NewBaseline.mob.RRSD17{i,1}];
end

%% 
sizeEvent = size(NewProject.NewBaseline.mob.RRSD18,1)
NewMat = [];

for i = 2:sizeEvent
    NewMat = [NewMat; NewProject.NewBaseline.mob.RRSD18{i,1}];
end

%% 
sizeEvent = size(NewProject.NewRat.mob.RRSD18,1)
NewMat = [];

for i = 2:sizeEvent
    NewMat = [NewMat; NewProject.NewRat.mob.RRSD18{i,1}];
end


