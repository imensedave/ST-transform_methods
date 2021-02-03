function [dog] = match_demo_NZMC(bx1, bx2, r,c, dR, dC, dim, pflag)
% matching demo for normalised zero mean corrolation metrics. 
% copyright David Sinclair 2020
%

[nr,nc] = size(bx1);
%dim = 20;
br = nr-dim;
bc = nc-dim;

dog = zeros(dR*2+1, dC*2+1);  % zero mean convolution.

m = bx1(r-dim:r+dim, c-dim:c+dim);
mbar = mean(m(:));
mn = m-mbar;
ndim = (2*dim+1)^2;
mag = sqrt(sum( mn(:)'*mn(:)));
mn = mn/mag;

sad(:) = 1000;

for R = r-dR:r+dR
    i=R-r+dR+1;
    for C = c-dC:c+dC
         if( R>dim && C> dim && R<br && C<bc)
              j=C-c+dC+1;
              m2 = bx2(R-dim:R+dim,C-dim:C+dim);
              
              m2bar = mean(m2(:));
              m2n = m2-m2bar;
              mag2 = sqrt(sum( m2n(:)'*m2n(:)));
              
              dog(i,j) = sum( mn(:)'*m2n(:) )/mag2;
         end
    end
end

if (pflag > 0 )
        
    figure(pflag + 1)
    imagesc( m );
    
    figure(pflag)
    surf(dog)
    
end

return