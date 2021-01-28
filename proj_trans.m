function tmp = proj_trans(im, proj)
%
%
% transform image 
%
%

% mapping  (R,C) = P*(r,c); 

[nr,nc] = size(im);
tmp = zeros(nr,nc);
f = 1000;

for r=1:nr
    for c=1:nc
        v= [r;c;f];
        V = proj*v;
        R = floor(f*V(1)/V(3)+0.5);   % location of point from im2 in im1
        C = floor(f*V(2)/V(3)+0.5);
        if R>0 && R<=nr && C>0 && C < nc
            tmp(R,C) = im(r,c);
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
                tmp(r,c) = im(R,C);
            end
        end
    end
end



return