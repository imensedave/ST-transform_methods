function [corners] = chains_corners( stx, chains, pflag)
%
% curvature max corners along edge chains.
%
%
% copyright D Sinclair 2021
%

[nr,nc] = size(stx);

stx(1:3,:) = -4;,stx(end-2:end,:) = -4;
stx(:,1:3) = -4;,stx(:,end-2:end) = -4;

if( pflag > 0 )
   figure(pflag)
   imagesc( stx );
   colormap gray
end

chains2 = [];
chains2.up = [];
chains2.incs = [];

edge_im = zeros(nr,nc);

numc = size(chains,2);
cnt = 0;

for x=1:numc
 
    
    ups = chains(x).up;
    incs = chains(x).incs;
    nu = size(ups,1);
    [rs,cs] = ind2sub([nr,nc],chains(x).up);

    if( nu > 16 )
    for q = nu+1:nu+16
        rs(q) = rs(q-nu);
        cs(q) = cs(q-nu);
    end
 
    cvtr = zeros(nu+10,1);
    for z=6:nu+8
        r0 = rs(z-5);
        r = rs(z);
        r1 = rs(z+5);

        c0 = cs(z-5);
        c = cs(z);
        c1 = cs(z+5);
        
        dr = r-(r0+r1)/2;
        dc = c-(c0+c1)/2;
        
        cvtr(z) = dr*dr + dc*dc;    
    end
    
    cvtr(1:5) = cvtr(nu:nu+4);
    
    for z=3:nu
        if cvtr(z) > 2 && cvtr(z) > cvtr(z-1) && cvtr(z) > cvtr(z-2) && cvtr(z) >= cvtr(z+1) && cvtr(z) > cvtr(z+2) 
            cnt = cnt+1;
            
            if ( stx(ups(z) + incs(z)) > 0) ||  ( stx(ups(z) + incs(z)*2) > 0) 
                corners(cnt,:) = [rs(z),cs(z)];
            end
        end
    end
    
    if cvtr(2) > 2 && cvtr(2) > cvtr(1) && cvtr(2) > cvtr(nu-1) && cvtr(2) >= cvtr(3) && cvtr(2) > cvtr(4)
        cnt = cnt+1;
        
        if stx(ups(2) + incs(2)) > 0 |   stx(ups(2) + incs(2)*2) > 0
            corners(cnt,:) = [rs(2),cs(2)];
        end
    end
    
    if cvtr(1) > 2 && cvtr(1) > cvtr(nu-2) && cvtr(1) > cvtr(nu-2) && cvtr(1) >= cvtr(2) && cvtr(1) > cvtr(2)
        cnt = cnt+1;
        if stx(ups(1) + incs(1)) > 0 |   stx(ups(1) + incs(1)*2) > 0
            corners(cnt,:) = [rs(1),cs(1)];
        end
    end
    
    end
end

if pflag > 0 
    figure(pflag )
    hold on
    plot( corners(:,2), corners(:,1), 'gx');
    hold off
end


return;