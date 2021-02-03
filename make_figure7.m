function  make_figure7()
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


figure(1)
patch = im(r-40:r+40, c-40:c+40);
imagesc( patch )
colormap gray


figure(1)
pST = stx(r-40:r+40, c-40:c+40);
imagesc( pST )
colormap gray

cim2 = imread('images/rgt0_00001.jpeg');
im2 = double(rgb2gray(cim2));
stx2 = ST(im2, 12, 4, 4);

[sad] = match_demo_SAD(stx, stx2, 434, 693, 60, 60, 4, 10);
[dog] = match_demo_NZMC(im, im2, 434, 693, 60, 60, 4, 11);

figure(6)
set(6, 'Units', 'normalized'); 
set(6, 'Position',[0.0 0.0 0.4 0.4] )
ax = axes('position', [0.05,0.05, 0.9, 0.9]);
surf(dog)

figure(5)
set(5, 'Units', 'normalized'); 
set(5, 'Position',[0.0 0.0 0.4 0.4] )
ax2 = axes('position', [0.05,0.05, 0.9, 0.9]);
surf(sad)


[sad] = match_demo_SAD(stx, stx2, 434, 693, 60, 60, 10, 20);
[dog] = match_demo_NZMC(im, im2, 434, 693, 60, 60, 10, 21);


figure(16)
set(16, 'Units', 'normalized'); 
set(16, 'Position',[0.0 0.0 0.5 0.5] )
ax = axes('position', [0.05,0.05, 0.9, 0.9]);
surf(dog)

figure(15)
set(15, 'Units', 'normalized'); 
set(15, 'Position',[0.0 0.0 0.5 0.5] )
ax2 = axes('position', [0.05,0.05, 0.9, 0.9]);
surf(sad)


[sad] = match_demo_SAD(stx, stx2, 434, 693, 60, 60, 20, 30);
[dog] = match_demo_NZMC(im, im2, 434, 693, 60, 60, 20, 31);


figure(26)
set(26, 'Units', 'normalized'); 
set(26, 'Position',[0.0 0.0 0.5 0.5] )
ax = axes('position', [0.05,0.05, 0.9, 0.9]);
surf(dog)

figure(25)
set(25, 'Units', 'normalized'); 
set(25, 'Position',[0.0 0.0 0.5 0.5] )
ax2 = axes('position', [0.05,0.05, 0.9, 0.9]);
surf(sad)



end

