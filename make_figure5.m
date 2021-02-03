function  make_figure5()
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


[corners] = chains_corners( stx_12, chains, 14);

figure(12)

set(12, 'Units', 'normalized'); 
set(12, 'Position',[0.0 0.0 0.5 0.55] )
ax1 = axes('position', [0.0,0.0, 1.0, 1.0]);

imagesc( cim);
axis off
hold on
plot( corners(:,2), corners(:,1), 'rx');
hold off


end

