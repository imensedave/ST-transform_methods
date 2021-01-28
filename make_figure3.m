function  make_figure3()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/img001874.jpeg');
im = double(rgb2gray(cim));

stx_12 = ST(im, 12, 4, 4);

[lbd_12, max_id] = find_regs4(stx_12, 12, 10);

figure(12)

set(12, 'Units', 'normalized'); 
set(12, 'Position',[0.0 0.0 0.7 0.75] )
ax1 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( lbd_12);
colormap(colorcube)

cim = imread('images/UAE_0006.jpg');
im = double(rgb2gray(cim));

stx_6 = ST(im, 12, 4, 4);

[lbd_12, max_id] = find_regs4(stx_6, 12, 10);

figure(6)
set(6, 'Units', 'normalized'); 
set(6, 'Position',[0.0 0.0 0.7 0.55] )
ax2 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( lbd_12);
colormap(colorcube)
axis off


end

