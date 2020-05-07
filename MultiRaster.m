%Plot multiple graphs using rasterFromBehav
close all; clear all; clc

figure
subplot(3,2,1)
title('Discrimination-Early')
rasterFromBehav('9.0 DISC1.csv') %early Disc
subplot(3,2,3)
title('Discrimination-Mid')
rasterFromBehav('9.0 DISC9.csv') %mid Disc
subplot(3,2,5)
title('Discrimination-Late')
rasterFromBehav('9.0 DISC17.csv') %late Disc

subplot(3,2,2)
title('Reversal-Early')
rasterFromBehavREV('9.0 REV1.csv')

subplot(3,2,4)
title('Reversal-Mid')
rasterFromBehavREV('9.0 REV4.csv')

subplot(3,2,6)
title ('Reversal-Late')
rasterFromBehavREV('9.0 REV8.csv')
