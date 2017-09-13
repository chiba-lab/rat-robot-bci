%% LDA function

% example data
load fisheriris
Nfeatures = 2;
feature_matrix = meas(:,1:Nfeatures);
labels = species;

% split data into test and train datasets
test_train_split = .80;
Nsample = size(feature_matrix,1);
Ntrain = round(test_train_split*Nsample);
rand_ind = randperm(Nsample);

train_ind = rand_ind(1:Ntrain);
test_ind = rand_ind(Ntrain+1:end);

test_set = feature_matrix(test_ind,:);
train_set = feature_matrix(train_ind,:);

train_labels = labels(train_ind);

% LDA classification
[ldaClass,ldaErr,ldaPosterior,ldaLogp,ldaCoeff] = classify(test_set,train_set,train_labels,'linear');

% intercepts
K13 = ldaCoeff(1,3).const; %boundary between class 1 and class 3
K23 = ldaCoeff(2,3).const; %boundary between class 2 and class 3
% coefficients
L13 = ldaCoeff(1,3).linear;
L23 = ldaCoeff(2,3).linear;

% boundary function
bound13 = @(x1) (-1/L13(2))*(K13 + L13(1)*x1);
bound23 = @(x1) (-1/L23(2))*(K23 + L23(1)*x1);

% feature vectors
% boundary between class 1 and 3
x1_c13 = feature_matrix(ismember(labels,'setosa'),1);
x2_c13 = feature_matrix(ismember(labels,'setosa'),2);
% boundary between class 2 and 3
x1_c23 = feature_matrix(ismember(labels,'versicolor'),1);
x2_c23 = feature_matrix(ismember(labels,'versicolor'),2);

figure
hold on 
p1=plot(feature_matrix(ismember(labels,'setosa'),1),feature_matrix(ismember(labels,'setosa'),2),'b.','markersize',15);
p2=plot(feature_matrix(ismember(labels,'versicolor'),1),feature_matrix(ismember(labels,'versicolor'),2),'r.','markersize',15);
p3=plot(feature_matrix(ismember(labels,'virginica'),1),feature_matrix(ismember(labels,'virginica'),2),'g.','markersize',15);

legend([p1,p2,p3],'setosa','versicolor','virginica','Location','Best')
 
x_lim = xlim; y_lim = ylim;

delta_x = 0.5;
x = x_lim(1):delta_x:x_lim(2);

y_bound13 = bound13(x);
y_bound23 = bound23(x);

plot(x,y_bound13,'k')
plot(x,y_bound23,'r')

set(gca,'xlim',x_lim)
set(gca,'ylim',y_lim)