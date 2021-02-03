function  make_figure6()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/lft0_00001.jpeg');
im = double(rgb2gray(cim));
stx = ST(im, 12, 4, 4);

 r = 434;
 c = 693;
pat_im = im(r-20:r+20, c-20:c+20);
pat_st = stx(r-20:r+20, c-20:c+20);

figure(6)
set(6, 'Units', 'normalized'); 
set(6, 'Position',[0.0 0.0 0.2 0.2*1920/1280] )
ax2 = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( pat_im);
colormap(gray)
axis off



figure(7)
set(7, 'Units', 'normalized'); 
set(7, 'Position',[0.0 0.0 0.2 0.2*1920/1280] )
ax = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( pat_st);
colormap(gray)
axis off




[pts, pts2] = block_match(stx, stx2, 50, 60, 25);

[proj, rcs1, rcs2] = regress_proj_fast(pts, pts2, 40);

[tmp, cim4] = proj_trans_demo(im, im2, proj, 50);


figure(8)
set(8, 'Units', 'normalized'); 
set(8, 'Position',[0.0 0.0 0.7 0.75] )
ax = axes('position', [0.0,0.0, 1.0, 1.0]);
axis off

imagesc( cim4);
axis off






end

