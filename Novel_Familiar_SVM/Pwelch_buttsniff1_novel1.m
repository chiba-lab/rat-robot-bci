

for i = 1:11
    pxx_novel(i,:) = pwelch(meA_novel_mat(i,:), 150)';
    pxx_buttsniff(i,:) = pwelch(meA_buttsniff_mat(i,:), 150)';
end