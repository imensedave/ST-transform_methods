function  make_figure4()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/img001874.jpeg');
im = double(rgb2gray(cim));

stx_12 = ST(im, 12, 4, 4);

[chains, bnd] = dark_bound( stx_12, 16, 30);

[chains2, edge_im] = filter_chains( stx_12, chains, 12, 60);

figure(12)

set(12, 'Units', 'normalized'); 
set(12, 'Position',[0.0 0.0 0.7 0.75] )
ax1 = axes('position', [0.0,0.0, 1.0, 1.0]);

imagesc( edge_im);
colormap(gray)
axis off


end

