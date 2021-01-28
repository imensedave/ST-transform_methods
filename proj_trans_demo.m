function [tmp, cim] = proj_trans_demo(im1,im2, proj, pflag)
%
% transform image 2 and overlay on image 1
%
% copyright D. Sinclair 2020.
%
% mapping  (R,C) = P*(r,c); 
%
%
% [tmp, cim4] = proj_trans_demo(double(rgb2gray(cim)), double(rgb2gray(cim2)), proj, 10);
%
%


cim = [];
[nr,nc] = size(im1);
tmp = zeros(nr,nc);
f = 1000;

for r=1:nr
    for c=1:nc
        v= [r;c;f];
        V = proj*v;
        R = floor(f*V(1)/V(3)+0.5);   % location of point from im2 in im1
        C = floor(f*V(2)/V(3)+0.5);
        if R>0 && R<=nr && C>0 && C < nc
            tmp(R,C) = im2(r,c);
        end
    end
end

% fill in the aliasing gaps.
iproj = inv(proj);

for r=1:nr
    for c=1:nc
        if tmp(r,c) == 0
            v= [r;c;f];
            V = iproj*v;
            R = floor(f*V(1)/V(3)+0.5);   % location of point from im1 in im2
            C = floor(f*V(2)/V(3)+0.5);
            if R>0 && R<=nr && C>0 && C < nc
                tmp(r,c) = im2(R,C);
            end
        end
    end
end

if( pflag > 0 )
    figure(pflag)
    imagesc( tmp);
    colormap gray
    
    cim = uint8(zeros(nr,nc,3));
    cim(:,:,1) = im1(:,:);
    cim(:,:,2) = tmp(:,:);
    cim(:,:,3) = im1(:,:);
    
    figure( pflag + 1);
    imagesc( cim )
end

return