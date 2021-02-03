function [sad, dog] = match_demo(bx1, bx2, r,c, dR, dC, dim, pflag)
% matching demo for differnet corrolation metrics. 
% copyright David Sinclair 2020
%

[nr,nc] = size(bx1);
%dim = 20;
br = nr-dim;
bc = nc-dim;

dog = zeros(dR*2+1, dC*2+1);  % zero mean convolution.
sad = zeros(dR*2+1, dC*2+1);  % sum absolute difference.

m = bx1(r-dim:r+dim, c-dim:c+dim);
mbar = mean(m(:));
ndim = (2*dim+1)^2;

sad(:) = 1000;

for R = r-dR:r+dR
    i=R-r+dR+1;
    for C = c-dC:c+dC
         if( R>dim && C> dim && R<br && C<bc)
              j=C-c+dC+1;
              m2 = bx2(R-dim:R+dim,C-dim:C+dim);
              sad(i,j) = -sum(abs(m(:)-m2(:)))/ndim;
              
              m2bar = mean(m2(:));
              dog(i,j) = sum((m(:)-mbar)'*(m2(:)-m2bar))/ndim ;
         end
    end
end

if (pflag > 0 )
    
    figure(pflag + 1)
    surf(sad)
    
    figure(pflag + 2)
    surf(dog)
    
end

return