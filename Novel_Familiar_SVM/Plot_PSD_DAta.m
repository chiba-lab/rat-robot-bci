
% Plot Baseline, Grooming, Sniffing

for i = 1:length(baseline_train)
    figure(1);
    plot(baseline_train(i,1:7));
    hold on
    title('Baseline Data 1-7 Hz');
end

for i = 1:length(grooming_train)
    figure(2);
    plot(grooming_train(i,1:7));
    hold on
    title('Grooming Data 1-7 Hz');
end

for i = 1:length(sniffing_train)
    figure(3);
    plot(sniffing_train(i,1:7));
    hold on
    title('Sniffing Data 1-7 Hz');
end

for i = 1:length(baseline_train_gamma)
    figure(4);
    plot(baseline_train_gamma(i,1:21));
    hold on
    title('Baseline Data 68-89 Hz');
end

for i = 1:length(sniffing_train_gamma)
    figure(5);
    plot(sniffing_train_gamma(i,1:21));
    hold on
    title('Sniffing Data 68-89 Hz');
end

for i = 1:length(grooming_train_gamma)
    figure(6);
    plot(grooming_train_gamma(i,1:21));
    hold on
    title('Grooming Data 68-89 Hz');
end