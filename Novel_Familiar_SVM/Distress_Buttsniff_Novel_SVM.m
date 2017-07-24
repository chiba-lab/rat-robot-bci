% Project: LFP Classification - SVM Classification of Olfactory LFPs During Social Interaction Task - UCSD
% Author: Eric Leonardis, Adapted from code written by Burcu Aysen Urgen
% Last modified: 3 February 2016

% We are classifying when the rat is sniffing the butt of a familiar rat
% or a novel rat. We are feeding in an 11x129 matrix of the power spectrums
% calculated by the pwelch() of the time course of the LFP.


%% ******************** DATA PREPARATION  *****************

% 1. First load the trials for each localizer

load('/Users/ericleonardis/Documents/Matlab/Data Analysis/Novel_Familiar_SVM/PWelch_Novel_Buttsniff.mat'); % load data files

FID = fopen('Classification_Accuracy_Distress_MOB_novel_buttsniff_pwelch.txt', 'w'); %opens an output file to print accuracy results
fprintf(FID, 'SVM Results\n Time: %s\n', datestr(now));
fprintf(FID, 'Condition 1\t Condition 2\t Repetition\t Classification Accuracy\t\n');



    
        
for z = 1:5
            MJ_Ref =  pxx_buttsniff;  %data for class 1, rows = observations, columns = variables
            MJ_Comp = pxx_novel;  %data for class 2, rows = observations, columns = variables
            
            
            %% 4. *************************  RUN CLASSIFICATIONS ******************
            
            % (a) Gather the datasets of each condition into one matrix and shuffle it
            
            twoway_accuracy_MJ_L1_L2 = [];
            
            MJ_L1 = 1; MJ_L2 = 2;
            labelMJ_L1 = repmat(MJ_L1, size(MJ_Ref,1), 1);
            labelMJ_L2 = repmat(MJ_L2, size(MJ_Comp,1), 1);
            
            disp([length(labelMJ_L1), length(labelMJ_L2)])
            
            
            % (b) Label vectors and Data matrices for the 4 type of classifications: R-A-H; R-H; R-A; A-H
            
            labels_MJ_L1_L2 = [labelMJ_L1; labelMJ_L2];
            data_MJ_L1_L2 = [MJ_Ref; MJ_Comp];
            data_MJ_L1_L2 = double(data_MJ_L1_L2);
            
            
            % (c) Shuffling procedure for each of the four classification types
            
            order1 = randperm(size(data_MJ_L1_L2,1));
            shuffdata_MJ_L1_L2 = data_MJ_L1_L2(order1,:); % shuffled data
            shufflabels_MJ_L1_L2 = labels_MJ_L1_L2(order1);
            
            
            % (d) Scale the data
            
            scaleddata_MJ_L1_L2 = (shuffdata_MJ_L1_L2 - repmat(min(shuffdata_MJ_L1_L2,[],1),size(shuffdata_MJ_L1_L2,1),1))*spdiags(1./(max(shuffdata_MJ_L1_L2,[],1)-min(shuffdata_MJ_L1_L2,[],1))',0,size(shuffdata_MJ_L1_L2,2),size(shuffdata_MJ_L1_L2,2));
            
            
            % (e) Classify with 5-fold cross-validation
            N = length(shufflabels_MJ_L1_L2);
            N1 = length(MJ_Ref(:,1))*2;
            N2 = length(MJ_Comp(:,1))*2;
            options = sprintf('-v 5 -t 0 -wi %f', N/N1); %specifies 5fold cross validation
            disp(N/N1)
            twoway_accuracy_MJ_L1_L2 = svmtrain(shufflabels_MJ_L1_L2, scaleddata_MJ_L1_L2, options);
            
            
            %keyboard
            eval(['Accuracy_novel_buttsniff' num2str(z) ' = twoway_accuracy_MJ_L1_L2'])
            %eval(['save Accuracy_Odor' Conditions{i} '_' Conditions{j} '_' num2str(z) ' ' 'Accuracy_Odor' Conditions{i} '_' Conditions{j} '_' num2str(z)])
            if (twoway_accuracy_MJ_L1_L2 >= 68.52)
            fprintf(FID, 'Control\t Puff1\t %s\t %6.4f *** \t\n', num2str(z), twoway_accuracy_MJ_L1_L2)
            else
            fprintf(FID, 'Control\t Puff1\t %s\t %6.4f\t\n', num2str(z), twoway_accuracy_MJ_L1_L2)
            end
end







