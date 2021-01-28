function [chains2, edge_im] = filter_chains( stx, chains, min_leng, pflag)
%
% filter dark region boundaries to get strong edges.
%
%
%
% [chains2, edge] = filter_chains( stx, chains, 12, 60);
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

for x=1:numc
 
%x = 102
    ups = chains(x).up;
    nu = size(ups,1);
    edg = zeros(nu,1);

    ix = chains(x).incs;
    for u=1:nu
        if( stx(ups(u)+ix(u) ) > 0 )
            edge_im(ups(u)) = -1;
            edg(u) = 1;
        else
            if( stx(ups(u)+ix(u) ) == 0 )
                if( stx(ups(u)+ix(u)*2 ) >  0 )
                    edg(u) = 1;
                    edge_im(ups(u)) = -1;
                end
            end
        end
   end
end

if pflag > 0 
    figure(pflag + 1 )
    imagesc( edge_im )
    colormap gray
end


return;