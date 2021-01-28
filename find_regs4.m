function [lim, max_id] = find_regs4(trx, nx, pflag)
%  label areas of constant quantisation
%  copyright D. Sinclair 2021
%
% 4 conencted regions of area > nx
%


[nr,nc] = size(trx);
lim = zeros(nr,nc);

lim(1:end,1:2) = -1;
lim(1:end,nc-1:nc) = -1;

lim(1:2, 1:end) = -1;
lim(nr-1:nr, 1:end) = -1;

br = nr-2;
bc = nc-2;

id = 0;

Rs = zeros(100000,1);
Cs = zeros(100000,1);

for r=3:br
    for c=3:nc
        if( lim(r,c) == 0 )
            id = id+1;
            v = trx(r,c);
            lim(r,c) = id;

            num = 1;
            Rs(1) = r;
            Cs(1) = c;
            i = 1;
            
            while i<= num
                R = Rs(i);
                C = Cs(i);
                
                if( lim(R+1,C) == 0 && trx(R+1,C) == v )
                   num =num+1;
                   lim(R+1,C) = id;
                   Rs(num) = R+1;
                   Cs(num) = C;
                end
                
                if( lim(R-1,C) == 0 && trx(R-1,C) == v )
                   num =num+1;
                   lim(R-1,C) = id;
                   Rs(num) = R-1;
                   Cs(num) = C;
                end

               if( lim(R,C+1) == 0 && trx(R,C+1) == v )
                   num =num+1;
                   lim(R,C+1) = id;
                   Rs(num) = R;
                   Cs(num) = C+1;
               end
                
               if( lim(R,C-1) == 0 && trx(R,C-1) == v )
                   num =num+1;
                   lim(R,C-1) = id;
                   Rs(num) = R;
                   Cs(num) = C-1;
               end
                i= i+1;
            end
            
            if( num < nx )
                for z=1:num
                     lim(Rs(z),Cs(z)) = -1;
                end
                id = id-1;
            end
        end
    end
end

max_id = id;


if( pflag > 0 )
    figure(pflag )
    imagesc( lim )
end
