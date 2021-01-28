function  make_figures()
%
% script to make figures for paper.
%
%
%
%
cim = imread('images/lft0_00001.jpeg');
cim2 = imread('images/rgt0_00001.jpeg');
p = [1,0,0;0,1,0;0,0,1];
[tmp, cim4] = proj_trans_demo(double(rgb2gray(cim)), double(rgb2gray(cim2)), p, 10);

imwrite(cim4, 'LR_overlay.jpg','Quality', 93);

im = double(rgb2gray(cim));
im2 = double(rgb2gray(cim2));

[stx, sharp, lmean] = STtransUS(im, 12, 4, 20);
stx2 = STtrans(im2, 12, 4, 14);

imwrite(uint8(stx*126+127), 'STxleft.jpg','Quality', 93);

[pts, pts2] = block_match(stx, stx2, 50, 60, 25);

[proj, rcs1, rcs2] = regress_proj_fast(pts, pts2, 40);

[tmp, cim4] = proj_trans_demo(im, im2, proj, 50);

end

