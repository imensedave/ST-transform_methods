function  make_figure6a_b()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/lft0_00001.jpeg');



figure(8)
set(8, 'Units', 'normalized'); 
set(8, 'Position',[0.0 0.0 0.7 0.75] )
ax = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( cim);
axis off


cim2 = imread('images/rgt0_00001.jpeg');


figure(9)
set(9, 'Units', 'normalized'); 
set(9, 'Position',[0.0 0.0 0.7 0.75] )
ax = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( cim2);
axis off

end

