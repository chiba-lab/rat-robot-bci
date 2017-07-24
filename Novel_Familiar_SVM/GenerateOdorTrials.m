

% Generates place controlled trials for the odor preference pairing task. 


Odors =    {'Rose Hip'
            'Geranium'
            'Citronella'
            'Cedarwood'
            'Pine'
            'Rosemary'
            'Lemongrass'
            'Bergamot'};

Odors_ab = {'R'
            'G'
            'C'
            'W'
            'P'
            'M'
            'L'
            'B'};
        

for i = 1:28
   for j = 1:2
     Trials(i,j) = Odors_ab(TrialOrder(i,j)) 
   end
end






        
