function [angle_x, idx_of_result] = knee_pt_angle(y)

y = y(:);

x = (1:length(y))';


idx = 1:length(x);

%the code below "unwraps" the repeated regress(y,x) calls.  It's
%significantly faster than the former for longer y's
%
%figure out the m and b (in the y=mx+b sense) for the "left-of-knee"
sigma_xy = cumsum(x.*y);
sigma_x  = cumsum(x);
sigma_y  = cumsum(y);
sigma_xx = cumsum(x.*x);
n        = (1:length(y))';
det = n.*sigma_xx-sigma_x.*sigma_x;
mfwd = (n.*sigma_xy-sigma_x.*sigma_y)./det;
bfwd = -(sigma_x.*sigma_xy-sigma_xx.*sigma_y) ./det;

%figure out the m and b (in the y=mx+b sense) for the "right-of-knee"
sigma_xy = cumsum(x(end:-1:1).*y(end:-1:1));
sigma_x  = cumsum(x(end:-1:1));
sigma_y  = cumsum(y(end:-1:1));
sigma_xx = cumsum(x(end:-1:1).*x(end:-1:1));
n        = (1:length(y))';
det = n.*sigma_xx-sigma_x.*sigma_x;
mbck = flipud((n.*sigma_xy-sigma_x.*sigma_y)./det);
bbck = flipud(-(sigma_x.*sigma_xy-sigma_xx.*sigma_y) ./det);

%figure out the sum of per-point errors for left- and right- of-knee fits

angle_threshold=nan(size(y));
error_curve=nan(size(y));
for breakpt = 2:length(y-1)
    delsfwd = (mfwd(breakpt).*x(1:breakpt)+bfwd(breakpt))-y(1:breakpt);
    delsbck = (mbck(breakpt).*x(breakpt:end)+bbck(breakpt))-y(breakpt:end);
    error_curve(breakpt) = sum(abs(delsfwd))+ sum(abs(delsbck));

    theta=(mfwd(breakpt)-mbck(breakpt))/(1+(mfwd(breakpt)*mbck(breakpt)));
    angle=atan(theta);
    angle_threshold(breakpt)= abs(angle) *180/pi;
end

%find location of the min of the error curve
[~,loc] = min(error_curve);

angle_x =angle_threshold(loc);% x(loc);
%idx=find(angle_threshold==res_x);
idx_of_result =idx(loc);
end





