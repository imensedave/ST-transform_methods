function [pts, pts2] = block_match(bx1, bx2, maxR, maxC, pflag)
% block matching function sum of absolute difference. 
% copyright David Sinclair 2020
%

[nr,nc] = size(bx1);
dim = 40;
br = nr-dim-2;
bc = nc-dim-2;


dog = zeros(maxR*2+1, maxC*2+1);
pts = zeros(0,2);
pts2 = zeros(0,2);
np = 0;
MR = maxR*2+1;
MC = maxC*2+1;



for r = dim+2:100:br
    r
    for c = dim+2:50:bc
        m = bx1(r-dim:r+dim, c-dim:c+dim);
        df = sum( abs(m(:)));
        if df > 1050
            dog(:) = 7000;
            for R = r-maxR:r+maxR
                i=R-r+maxR+1;
                for C = c-maxC:c+maxC
                    if( R>dim && C> dim && R<br && C<bc)
                        j=C-c+maxC+1;
                        m2 = bx2(R-dim:R+dim,C-dim:C+dim);
                        % obviously you don't have to completely evaluate this if you
                        % are in a rush:)
                        dog(i,j) = sum(abs(m(:)-m2(:)));
                    end
                end
            end
            
            
            [v,idx ] = min(dog(:));
            if v < 6000
                [rr,cc] = ind2sub([MR,MC],idx);
                np = np+1;
                pts(np,:) = [r,c];
                pts2(np,:) = [(r+rr-maxR), (c+cc-maxC)];
            end
            
            if 0
                figure(pflag +6)
                surf(dog)
                df = 9;
            end
        end
        
    end
end

drcs = [pts,pts2];


if( pflag > 0 )
    cim = uint8(zeros(nr,nc,3));
    cim(:,:,1) = bx1(:,:)*60 + 38;
    cim(:,:,2) = bx2(:,:)*20 + 68;
    cim(:,:,3) = bx1(:,:)*60 + 38;
    
    figure( pflag + 10 );
    imagesc( cim )
    colormap gray
    hold on
    for i=1:np
        r = pts(i,1);
        c = pts(i,2);

        mr = pts2(i,1);
        mc = pts2(i,2);

        plot( [c;mc], [r;mr],'y' );
            
        plot( c, r,'mx' );
        plot( mc, mr,'g+' );
        
    end
    hold off 
end

return