function [ dpdy, dqdx ] = check_integrability( p, q )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   p : measured value of df / dx
%   q : measured value of df / dy
%   dpdy : second derivative dp / dy
%   dqdx : second derviative dq / dx

dpdy = zeros(size(p, 1), size(p, 2));
dqdx = zeros(size(q, 1), size(q, 2));

% TODO: Your code goes here
% approximate derivate by neighbor difference

dqdx = gradient(q);
dpdy = gradient(p);

% manual procedure using neighbor approximation method
% W = size(q, 1);
% H = size(q, 2);
%
% for img_w = 2:W-1
%     for img_h = 2:H-1
%         dqdx(img_h, img_w) = (q(img_h, img_w+1) - q(img_h, img_w-1)) / 2;
%         dpdy(img_h, img_w) = (p(img_h+1, img_w) - p(img_h-1, img_w)) /2;
%     end
% end
% 
% for img_h = 1:H
%     dqdx(img_h, 1) = 0;
%     dqdx(img_h, W) = 0;
%     %dqdx(img_h, 1) = q(img_h, 2) / 2;
%     %dqdx(img_h, W) = q(img_h, W-1) / 2;
%     if img_h == 1 || img_h == H
%         for img_w = 2:W-1
%             dqdx(img_h, img_w) = (q(img_h, img_w+1) - q(img_h, img_w-1)) / 2;
%         end
%     end
% end
% 
% for img_w = 1:W
%     dpdy(1, img_w) = 0;
%     dqdx(H, img_w) = 0;
%     %dqdx(img_h, 1) = q(img_h, 2) / 2;
%     %dqdx(img_h, W) = q(img_h, W-1) / 2;
%     if img_w == 1 || img_w == W
%         for img_h = 2:H-1
%             dpdy(img_h, img_w) = (p(img_h+1, img_w) - p(img_h-1, img_w)) / 2;
%         end
%     end
% end

end

