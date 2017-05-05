clc
close all

%1. txt-Datei einlesen
thermogram = load('Patient 1.txt');     

%2. Display image with scaled colors
figure(1); 
imagesc(thermogram)

[IDX,sep] = otsu(thermogram,3)
maxOtsu = max(IDX(:));
IDX(IDX<maxOtsu)=NaN;

keyboard;

% %In Integer-Bild umwandeln
% thermo_i=im2uint8(thermogram);
% figure(2)
% %imshow(thermo_i)

%3. Segmentierung

% histogram=imhist(thermo_bw)
level=24
level2 = graythresh(thermogram)
     
%Schwarz-Weiß
BW = imbinarize(thermogram, level);
%thermogram = thermogram.*meshgrid(BW,:);

BW_front = thermogram.*BW;

%BW_front = bsxfun(@times, BW, thermogram);

figure(2)
subplot(2,2,1)
imagesc(thermogram)
axis square
axis off
colormap(gray)
title('Originalbild')
subplot(2,2,2)
imshow(BW)
axis square
axis off
colormap(gray)
title('Binärbild')
subplot(2,2,3)
imagesc(BW_front)
axis square
axis off
title('Ohne Hintergrund')

% wound detection

%mask=boundarymask(thermogram);
mask = edge(BW, 'prewitt');
subplot(2,2,4)
imagesc(mask)
axis square
axis off
title('mask')
