function generate_signal(Ntrace, Nsample, Nclass, maxFreq, minFreq, maxAmp, minAmp, sampleFreq)

% generate_signal() - produce sinusoidal data generated from a simple linear 
%  model with noise sampled from a normal distribution (mean = 0, variance = 1)
%  and distinct frequency and amplitude sampled from a uniform distribution 

% Inputs
%   Ntrace      :  number of traces per class
%   Nsample     :  number of samples per trace
%   Nclass      :  number of classes
%   maxFreq     :  maximum frequency
%   minFreq     :  minimum frequency
%   maxAmp      :  maximum amplitude
%   minAmpn     :  minimum amplitude
%   sampleFreq  :  sample frequency
%
%
% Output
%   'Nclass' number of individual .mat files saved as 'sample_data_[frequency 
%   of signal]_[amplitude of signal]' in the current directory
%
%
% Example
%   >> Ntrace = 50;
%   >> Nsample = 1000;
%   >> Nclass = 3;
%   >> maxFreq = 20;
%   >> minFreq = 5;
%   >> maxAmp = 5;
%   >> minAmp = 1;
%   >> sampleFreq = 500;
%   >> generate_signal(Ntrace, Nsample, Nclass, maxFreq, minFreq, maxAmp, minAmp, sampleFreq)
%   

% Author  : Fernando Contreras (Chiba Lab) 2017
% Contact : f2contre@gmail.com

% Parameters
Nt = Ntrace;          
Ns = Nsample;         
Nc = Nclass;          
Ntotal = Nt*Nc;       

max_freq = maxFreq;   
min_freq = minFreq;   

max_amp = minAmp;     
min_amp = maxAmp;     

Fs = sampleFreq;      

% Signal Construction
t = 0:1/Fs:(Ns/Fs - 1/Fs);         %time array
signal_data = zeros(Nt,length(t)); %temporary logging variables for sample data

freqz = round((max_freq - min_freq)*rand(1,Nc) + min_freq); %randomly drawn Nc number of frequencies
ampz = round((max_amp - min_amp)*rand(1,Nc) + min_amp);     %randomly drawn Nc number of amplitudes

counter = 1;           %index variable for 'freqz' and 'ampz' array
freq = freqz(counter);
amp = ampz(counter);
for ii = 1:Ntotal
    
    %signal
    Signal = amp*sin(2*pi*freq*t);

    %sample noise
    mu = 0;
    sigma = 1;
    Noise = normrnd(mu,sigma,[1 length(t)]); %normal distribution
    
    Yt = Signal + Noise;  %signal generator model
    
    signal_data(ii - (counter - 1)*Nt, :) = Yt; %store signal in temporary matrix    
    if ~(mod(ii,Nt))
        save(strcat('sample_data_',num2str(freq),'_',num2str(amp),'.mat'),'signal_data'); %save sample data as .mat file
        
        %if the last class was saved end the loop
        if isequal(ii,Ntotal)
            break
        end
        
       signal_data = zeros(Nt,length(t));   %clear matrix
       counter = counter + 1;    %increment counter
       freq = freqz(counter);    %switch frequency
       amp = ampz(counter);      %switch amplitude
    end
    
end