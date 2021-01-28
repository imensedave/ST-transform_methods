function [chains, taken] = dark_bound( stx, min_leng, pflag)
%
% stx dark region boundary finder
%
%
%
% [chains] = dark_bound( stx, mag, 1);
%

[nr,nc] = size(stx);

stx(1,:) = 0;,stx(end,:) = 0;
stx(:,1) = 0;,stx(:,end) = 0;

if( pflag > 0 )
   figure(pflag)
   imagesc( stx );
   colormap gray
end
taken = zeros(nr,nc);

up = zeros(4*(nr+nc),1);, cats = zeros(4*(nr+nc),1);
nup = zeros(4*(nr+nc),1);, incs = zeros(4*(nr+nc),1);
chan = 0;

nhbd = [1; -nr; -1; nr];
bdx2 = [nr; 1; -nr; -1];
bxs  = [2; 3; 4; 1];
bxs2 = [4; 1; 2; 3];

chains     = [];
chains.up  = [];
chains.incs = [];

idx = find(stx == -1 );
numb = size(idx,1);

for q=1:numb
   id = idx(q);
   v = stx(id);
   
   if( taken(id) == 0 )
      nu = 0;
      if( stx(id+1) ~= v  )
         up(1) = id;
         nup(1) = 1;
         nu = 1;
      elseif( stx(id-nr) ~= v )
         up(1) = id;
         nup(1) = 2;
         nu = 1;
      elseif( stx(id-1) ~= v )
         up(1) = id;
         nup(1) = 3;
         nu = 1;
      elseif( stx(id+nr) ~= v )
         up(1) = id;
         nup(1) = 4;
         nu = 1;
      end
      if( nu > 0 ) % commence edge following.
         chan = chan+1;
         taken(id) = chan;
         bx = nup(1);

         id_start = id;, bx_start = bx;
         flag = 1;
         while flag;
            % look for next 8 connected boundary pixel.
            % case 1
            id2 = id + bdx2(bx);
            id3 = id2 + nhbd(bx);
            if( stx(id2) == v )
               if( stx(id3) ~= v ) % straight going edge
                  nu = nu+1;
                  up(nu) = id2;
                  id = id2;, taken(id) = chan;
                  nup(nu) = bx;
               else               % right turning edge
                  nu = nu+1;
                  up(nu) = id3;
                  id = id3;, taken(id) = chan;
                  bx = bxs(bx);
                  nup(nu) = bx;
               end
            else % case 2
               if( stx(id3) == v ) % again with the right turn
                  nu = nu+1;
                  up(nu) = id3;
                  id = id3;, taken(id) = chan;
                  bx = bxs(bx);
                  nup(nu) = bx;
               else               % left turn on the nose.
                  nu = nu+1;
                  up(nu) = id;
                  bx = bxs2(bx);
                  nup(nu) = bx;
               end
            end
            if( id == id_start & bx == bx_start)
               flag = 0;
            end
         end

         % concatinate chain here to remove duplicate consecutive poxels.
         cats(1:2) = up(1:2);
         incs(1:2) = nhbd(nup(1:2));
         cnt = 1;
         for q=2:nu
            if( cats(cnt) ~= up(q) )
               cnt = cnt + 1;
               incs(cnt) = nhbd(nup(q));
               cats(cnt) = up(q);
            else
               incs(cnt) = incs(cnt) + nhbd(nup(q));
            end
         end
         if( cnt > min_leng )
            chains(chan).up = cats(1:cnt);
            chains(chan).incs = incs(1:cnt);

         else
            chan = chan-1;
         end
      end
   end
end



if( pflag > 0 )
   disp(sprintf('of contour chains %d', chan));

   figure( pflag + 1)
   imagesc( taken)

end



return;