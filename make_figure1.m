function  make_figure1()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/img001874.jpeg');


im = double(rgb2gray(cim));


stx_12 = ST(im, 12, 4, 4);

figure(12)

set(12, 'Units', 'normalized'); 
set(12, 'Position',[0.0 0.0 0.7 0.75] )
ax1 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( stx_12);
colormap(gray)


stx_6 = ST(im, 6, 4, 4);

figure(6)
set(6, 'Units', 'normalized'); 
set(6, 'Position',[0.0 0.0 0.7 0.75] )
ax2 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( stx_6);
colormap(gray)
axis off


end

