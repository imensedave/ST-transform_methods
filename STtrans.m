function stx = STtrans(im, d, thresh, pflag)
%
% Sinclair-Town transform to black grey white feature image.
%
% copyright Dr David Sinclair 2020
%  stx = STtrans(im, 12, 4, 0)

[nr,nc] = size(im);
s = cumsum(cumsum(im,2),1); %column sum first
D = d+1;
br = nr-D;
bc = nc-D;
stx = zeros(nr,nc);

nx = 25*25;

for r=D+1:br
    for c=D+1:bc
        % the sinclair-Town transform is the trinarised difference from the local mean.
        v= (s(r-D,c-D) -  s(r-D,c+d) -  s(r+d,c-D) +  s(r+d,c+d))/nx;
        k = im(r,c)-v;
        if k > thresh
            stx(r,c) = 1;
        elseif k < -4
            stx(r,c) = -1;
        end
        
    end
end

if( pflag > 0 )
    figure(pflag)
    imagesc( stx)
end

return
