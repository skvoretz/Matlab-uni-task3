function dxdt = ft5(~, x)
x1 = x(1);
x2 = x(2);
x3 = x(3);
y1 = x(4);
y2 = x(5);
y3 = x(6);
dx1_dt = x(7);
dx2_dt = x(8);
dx3_dt = x(9);
dy1_dt = x(10);
dy2_dt = x(11);
dy3_dt = x(12);

norm = sqrt((x1-y1)^2 + (x2-y2)^2 + (x3-y3)^2);

m1 = 3;
m2 = 2;
G = 9.8;

d2x1_dt =  G * m2 * (x1 - y1) / norm;
d2x2_dt =  G * m2 * (x2 - y2) / norm;
d2x3_dt =  G * m2 * (x3 - y3) / norm;

d2y1_dt = -G * m1 * (x1 - y1) / norm;
d2y2_dt = -G * m1 * (x2 - y2) / norm;
d2y3_dt = -G * m1 * (x3 - y3) / norm;
dxdt = [dx1_dt; dx2_dt; dx3_dt; dy1_dt; dy2_dt; dy3_dt; d2x1_dt; d2x2_dt; d2x3_dt; d2y1_dt; d2y2_dt; d2y3_dt];
end