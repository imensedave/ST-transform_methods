function [proj] = make_pseudo( rcs1, rcs2)
%R1,C1; R2,C2;  R3,C3;  R4,C4; r1,c1;  r2, c2;  r3,c3;  r4,c4)
%
% want the mapping  (R,C) = P*(r,c); 
%
%
%
%

nump = size(rcs1,1);
v = zeros(nump*2,1);
M = zeros(nump*2,8);
f = 1000; % helps with numerical stability.

for p=1:nump
    q = 2*p-1;
    R = rcs1(p,1);
    C = rcs1(p,2);

    r = rcs2(p,1);
    c = rcs2(p,2);

    v(q) = R;
    v(q+1) = C;
    
    M(q,1) = r; M(q,2) = c; M(q,3)=f; M(q,4) = 0; M(q,5) = 0; M(q,6) =0; M(q,7) =-r*R/f; M(q,8) =-c*R/f;
    q=q+1;
    M(q,1) = 0; M(q,2) = 0; M(q,3)=0; M(q,4) = r; M(q,5) = c; M(q,6) =f; M(q,7) =-r*C/f; M(q,8) =-c*C/f;
end

Z = M'*M;

Zi =inv(Z);

MiV = Zi*(M'*v);

%  /* proj(0,0) = MiV(1);   proj(0,1) = MiV(2);   proj(0,2) = MiV(3);
%     proj(1,0) = MiV(4);   proj(1,1) = MiV(5);   proj(1,2) = MiV(6);
%     proj(2,0) = MiV(7);   proj(2,1) = MiV(8);   proj(2,2) = 1;  */


proj = zeros(3,3);
proj(3,3) = 1;

proj(1,:) = MiV(1:3);
proj(2,:) = MiV(4:6);
proj(3,1:2) = MiV(7:8);


if 1
    figure(666)
    plot( rcs1(:,2), -rcs1(:,1), 'r.')
    hold on
    for p=1:nump
        Q = proj*[rcs2(p,1); rcs2(p,2); f];
        plot( f*Q(2)/Q(3), -f*Q(1)/Q(3), 'gx')
    end
    hold off
    
end

return;

