function [dx,dy] = UpdateFlow_pipeline1(data_in_1,data_in_2,data_in_3,data_in_4,data_in_5)
%--------------------------------------------
g11 = data_in_1;
g12 = data_in_2;
g22 = data_in_3;
h1  = data_in_4;
h2  = data_in_5;
idet = 1/(g11*g22 - g12*g12 + 0.001);
dx = (g11*h2-g12*h1)*idet;
dy = (g22*h1-g12*h2)*idet;
end
