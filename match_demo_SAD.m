function [sad, dog] = match_demo_SAD(bx1, bx2, r,c, dR, dC, dim, pflag)
% matching demo for differnet corrolation metrics. 
% copyright David Sinclair 2020
%

[nr,nc] = size(bx1);
%dim = 20;
br = nr-dim;
bc = nc-dim;

sad = zeros(dR*2+1, dC*2+1);  % sum absolute difference.

m = bx1(r-dim:r+dim, c-dim:c+dim);
ndim = (2*dim+1)^2;

sad(:) = 1000;

for R = r-dR:r+dR
    i=R-r+dR+1;
    for C = c-dC:c+dC
         if( R>dim && C> dim && R<br && C<bc)
              j=C-c+dC+1;
              m2 = bx2(R-dim:R+dim,C-dim:C+dim);
              sad(i,j) = -sum(abs(m(:)-m2(:)))/ndim; % note -sign here for ease of comparison
              
         end
    end
end

if (pflag > 0 )
    
    figure(pflag )
    surf(sad)
        
end

return