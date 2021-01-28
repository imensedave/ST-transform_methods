function trx = ST(im, d,k1,k2)
% Sinclair-Town transform
%
% trx = ST(double(im), 12, 4, 4);
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