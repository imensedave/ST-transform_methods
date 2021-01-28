function trx = ST2(im, d, d2, k1, k2)
% 2 scale Sinclair-Town transform
%
% trx = ST2(double(im), 18, 6, 4, 4);
%

q = d*2+1;
D = d+1;
[nr,nc] = size(im);
s = cumsum(cumsum(im,2),1); 
br = nr-d-1;
bc = nc-d-1;
b0 = D+1;
trx = zeros(nr,nc);
nx = q*q;
for r=b0:br
    for c=b0:bc
        % the Sinclair-Town transform is the trinarised difference from the local mean.
        v= (s(r-D,c-D)-s(r-D,c+d)-s(r+d,c-D)+s(r+d,c+d))/nx;
        k = im(r,c)-v;
        if k > k1
            trx(r,c) = 1;
        elseif k < -k2
            trx(r,c) = -1;
        end
    end
end


q2 = d2*2+1;
D2 = d2+1;
b2r = nr-d2-1;
b2c = nc-d2-1;
b20 = D2+1;

nx2 = q2*q2;
for r=b20:b2r
    for c=b20:b2c
        v= (s(r-D2,c-D2)-s(r-D2,c+d2)-s(r+d2,c-D2)+s(r+d2,c+d2))/nx2;
        k = im(r,c)-v;
        if k > k1
            trx(r,c) = 1;
        elseif k < -k2
           trx(r,c) = -1;
        end
     end
end