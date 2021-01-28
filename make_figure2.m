function  make_figure2()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/UAE_0006b.jpg');
im = double(rgb2gray(cim));

stx_18 = ST(im, 18, 4, 4);

figure(18)

set(18, 'Units', 'normalized'); 
set(18, 'Position',[0.0 0.0 0.7 0.55] )
ax1 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( stx_18);
colormap(gray)


stx_6_18 = ST2(im, 18, 6, 4, 4);

figure(6)
set(6, 'Units', 'normalized'); 
set(6, 'Position',[0.0 0.0 0.7 0.55] )
ax2 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( stx_6_18);
colormap(gray)
axis off


end

