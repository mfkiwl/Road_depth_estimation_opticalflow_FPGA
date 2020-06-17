function [dx,dy] = UpdateFlow(M)
%--------------------------------------------
width  = 200;
%--------------------------------------------
dx = zeros(1,width);
dy = zeros(1,width);
%-------------------------------------------- pipe1
for h_cnt = 0: width-1
	data0 = M(1,h_cnt*5+1);
	data1 = M(1,h_cnt*5+2);
	data2 = M(1,h_cnt*5+3);
	data3 = M(1,h_cnt*5+4);
	data4 = M(1,h_cnt*5+5);
	[outdx,outdy] = UpdateFlow_pipeline1(data0,data1,data2,data3,data4);
	dx(1,h_cnt+1) = outdx;
	dy(1,h_cnt+1) = outdy;
end
end
