function [proj, rcs1, rcs2] = regress_proj(rcs1, rcs2, pflag)
%
%
% regression fit for a plane projectivity
%
% map rcs2 coordintes onto rcs1
%

proj = zeros(3,3);
f = 1000;

mudy = 1;
while mudy
    
    proj = make_pseudo( rcs1, rcs2);
    nump = size(rcs1,1);
    if( nump > 8 )
        Prcs2 = (proj* ([rcs2,f*ones(nump,1)]'))';
        
        Xrcs2 = f*Prcs2(:,1:2)./[Prcs2(:,3), Prcs2(:,3)];
        
        dx = rcs1-Xrcs2;
        mags = sum(dx.*dx,2);
        
        [vals, ids] = sort(mags,'descend');
        if vals(1) > 10
            rcs1 = rcs1(ids(2:end),:);
            rcs2 = rcs2(ids(2:end),:);
        else
            mudy = 0;
        end
        
        if( pflag > 0 )
            figure(pflag+20)
            plot( vals)
        end
    else
        mudy = 0;
    end
end