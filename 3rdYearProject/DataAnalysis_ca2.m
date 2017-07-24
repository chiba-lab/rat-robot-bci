
clear RatSniff_Pxx_Mat Groom_Pxx_Mat Baseline_Pxx_Mat RatSniff_Pxx_Mat3 Groom_Pxx_Mat3 Baseline_Pxx_Mat3

myXlims = [0, 40];
myYlims = [0, .0025];

%% Rat 1
Groom = [Groom_Rat1_ca2]; % Groom_Rat1_ca2_amyg
Baseline = [Baseline_Rat1_ca2];
RatSniff = [RatSniff_Rat1_ca2];
%Measure size of all
G_size = size(Groom_Rat1_ca2, 1);
B_size = size(Baseline_Rat1_ca2, 1);
RS_size = size(RatSniff_Rat1_ca2, 1);

Fs = 1010.10;
NFFT    = 800;
tw      = -NFFT/2+1:NFFT/2;
overlap = 300;
% sigma   = .1;%[sec]
% sigSamp = sigma.*Fs;
% w       = sqrt(sqrt(2)/sigSamp)*exp(-pi*tw.*tw/sigSamp/sigSamp);
w = 500;

for i = 1:RS_size
    LFP = RatSniff(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    RatSniff_Pxx_Mat(i,:,:) = Pxx;
    
    Fpass = [3 10]; % 3-13Hz
    Fs = 1000;
    [RatSniff_Respiration(i,:), RatSniff_Respiration_thephase(i,:), RatSniff_Respiration_amplitude(i,:), RatSniff_Respiration_instfreq(i,:)] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
  
    %% Gamma Filter
    Fpass = [70 100]; % 3-13Hz
    Fs = 1000;
    [RatSniff_gamma(i,:), RatSniff_gamma_thephase(i,:), RatSniff_gamma_amplitude(i,:), RatSniff_gamma_instfreq(i,:)] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);

    
end

for i = 1:G_size
    LFP = Groom(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    Groom_Pxx_Mat(i,:,:) = Pxx;
    
    Fpass = [3 10]; % 3-13Hz
    Fs = 1000;
    [Groom_Respiration(i,:), Groom_Respiration_thephase(i,:), Groom_Respiration_amplitude(i,:), Groom_Respiration_instfreq(i,:)] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
  
    %% Gamma Filter
    Fpass = [70 100]; % 3-13Hz
    Fs = 1000;
    [Groom_gamma(i,:), Groom_gamma_thephase(i,:), Groom_gamma_amplitude(i,:), Groom_gamma_instfreq(i,:)] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
    
    
end

for i = 1:B_size
    LFP = Baseline(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    Baseline_Pxx_Mat(i,:,:) = Pxx;
    
    Fpass = [3 10]; % 3-13Hz
    Fs = 1000;
    [Baseline_Respiration(i,:), Baseline_Respiration_thephase(i,:), Baseline_Respiration_amplitude(i,:), Baseline_Respiration_instfreq(i,:)] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
  
    %% Gamma Filter
    Fpass = [70 100]; % 3-13Hz
    Fs = 1000;
    [Baseline_gamma(i,:), Baseline_gamma_thephase(i,:), Baseline_gamma_amplitude(i,:), Baseline_gamma_instfreq(i,:)] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
    
    
    
end

figure(2)
subplot(311)
plot(F, mean(Baseline_Pxx_Mat, 1), 'k', 'LineWidth', 2)
hold on
plot(F, mean(Groom_Pxx_Mat, 1), 'g', 'LineWidth', 2)
plot(F, mean(RatSniff_Pxx_Mat, 1), 'r', 'LineWidth', 2)
% xlim([50 100])
% ylim([0 .0018])
xlim(myXlims)
ylim(myYlims)
title('Rat 1')


%% Rat 2
Groom = Groom_Rat2_ca2;
Baseline = Baseline_Rat2_ca2;
RatSniff = RatSniff_Rat2_ca2;
%Measure size of all
G_size = size(Groom_Rat2_ca2, 1);
B_size = size(Baseline_Rat2_ca2, 1);
RS_size = size(RatSniff_Rat2_ca2, 1);


for i = 1:RS_size
    LFP = RatSniff(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    RatSniff_Pxx_Mat(i,:,:) = Pxx;
end

for i = 1:G_size
    LFP = Groom(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    Groom_Pxx_Mat(i,:,:) = Pxx;
end

for i = 1:B_size
    LFP = Baseline(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    Baseline_Pxx_Mat(i,:,:) = Pxx;
end

subplot(312)
plot(F, mean(Baseline_Pxx_Mat, 1), 'k', 'LineWidth', 2)
hold on
plot(F, mean(Groom_Pxx_Mat, 1), 'g', 'LineWidth', 2)
plot(F, mean(RatSniff_Pxx_Mat, 1), 'r', 'LineWidth', 2)
xlim(myXlims)
ylim(myYlims)
title('Rat 2')
ylabel('Power')

%% Both
Groom = [Groom_Rat1_ca2; Groom_Rat2_ca2];
Baseline = [Baseline_Rat1_ca2; Baseline_Rat2_ca2];
RatSniff = [RatSniff_Rat1_ca2; RatSniff_Rat2_ca2];
%Measure size of all
G_size = size(Groom_Rat1_ca2, 1) + size(Groom_Rat2_ca2, 1);
B_size = size(Baseline_Rat1_ca2, 1) + size(Baseline_Rat2_ca2, 1);
RS_size = size(RatSniff_Rat1_ca2, 1) + size(RatSniff_Rat2_ca2, 1);

for i = 1:RS_size
    LFP = RatSniff(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    RatSniff_Pxx_Mat3(i,:,:) = Pxx;
end

for i = 1:G_size
    LFP = Groom(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    Groom_Pxx_Mat3(i,:,:) = Pxx;
end

for i = 1:B_size
    LFP = Baseline(i,:);
    [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs);
    Baseline_Pxx_Mat3(i,:,:) = Pxx;
end

figure(6)
plot(F, mean(Baseline_Pxx_Mat3, 1), 'k', 'LineWidth', 2)
hold on
plot(F, mean(Groom_Pxx_Mat3, 1), 'r', 'LineWidth', 2)
plot(F, mean(RatSniff_Pxx_Mat3, 1), 'b', 'LineWidth', 2)
xlim([0 40])
ylim(myYlims)
title('Hippocampus PSD For Behaviors Of Interest')
xlabel('Milliseconds (ms)')
ylabel('Power')
legend('Baseline', 'Groom', 'RatSniff')


% %% Plot Individual  Tract 
% LFP = RatSniff_Rat2_ca2(1,:);
% figure(2);
% subplot(411);
% plot(LFP)
% 
% % %% Gabor spectrograms For Actual Data
% Fs = 1000;
% fs = 1000;
% L       = size(LFP, 2);
% NFFT    = 500;
% tw      = -NFFT/2+1:NFFT/2;
% sigma   = .1;%[sec]
% sigSamp = sigma*fs;
% w       = sqrt(sqrt(2)/sigSamp)*exp(-pi*tw.*tw/sigSamp/sigSamp);
% overlap = NFFT-1;
% 
% %% Pwelch
% [Pxx,F] = pwelch(LFP,w,overlap,NFFT,Fs)
% %plot(F(1:100),Pxx(1:100))
% 
% %% FFT
% FFTxx = log(abs(fft(LFP)))
% %plot(FFTxx(1:200))
% 
% %% Respiratory Filter
% Fpass = [3 10]; % 3-13Hz
% Fs = 1000;
% [Respiration, Respiration_thephase, Respiration_amplitude, Respiration_instfreq] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
% 
% %% Gamma Filter
% Fpass = [70 100]; % 3-13Hz
% Fs = 1000;
% [gamma, gamma_thephase, gamma_amplitude, gamma_instfreq] = Butterworth_Hilbert_LR(LFP, Fs, Fpass);
% 
% %% Plot Raw
% subplot(511)
% plot(LFP)
% title('MOB LFP')
% subplot(512)
% plot(Respiration)
% 
% title('Respiratory Signal')
% subplot(513)
% plot(Respiration_thephase)
% title('Respiratory Phase')
% subplot(514)
% plot(Respiration_amplitude)
% title('Respiratory Amplitude')
% subplot(515)
% plot(gamma_amplitude)
% title('Gamma Amplitude')

%% Plot Raw
% LFP = xe;
% subplot(413);
% plot(tspan, LFP)

%% Gabor Spectrogram For Model Trace
% fs = 1000;
% L       = size(LFP, 2);
% NFFT    = 250;
% tw      = -NFFT/2+1:NFFT/2;
% sigma   = .1;%[sec]
% sigSamp = sigma*fs;
% w       = sqrt(sqrt(2)/sigSamp)*exp(-pi*tw.*tw/sigSamp/sigSamp);
% overlap = NFFT-1;
% 
% [SpecLFP F T P]=spectrogram(LFP,w,overlap,NFFT,fs); %deriv gaussian windowed spectrogram
% 
% subplot(414);
% imagesc(T,F,abs(SpecLFP));
% set(gca,'YDir','normal');
% ylim([0 150])
% set(gca,'YTick',[0:10:150])
% ylim([0 90])
% set(gca,'YTick',[0:10:90])
% grid on
% xlabel('time (sec)');ylabel('Hz')
