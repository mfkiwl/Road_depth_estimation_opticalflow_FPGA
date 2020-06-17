function [outdx,outdy] = UpdateFlow_pipeline1(data0,data1,data2,data3,data4)
	g11 = data0;
	g12 = data1;
	g22 = data2;
	h1  = data3;
	h2  = data4;
	idet = 1/(g11*g22 - g12*g12 + 0.001);
	outdx = (g11*h2-g12*h1)*idet;
	outdy = (g22*h1-g12*h2)*idet;
end
