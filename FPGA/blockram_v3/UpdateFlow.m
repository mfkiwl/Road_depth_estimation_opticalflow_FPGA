function [dx,dy] = UpdateFlow(M)
%--------------------------------------------
width  = 200;
%--------------------------------------------
dx = zeros(1,width);
dy = zeros(1,width);
%-------------------------------------------- pipe1
for h_cnt = 0: width-1
	data_in_1 = M(1,h_cnt*5+1);
	data_in_2 = M(1,h_cnt*5+2);
	data_in_3 = M(1,h_cnt*5+3);
	data_in_4 = M(1,h_cnt*5+4);
	data_in_5 = M(1,h_cnt*5+5);
	[outdx,outdy] = UpdateFlow_pipeline1(data_in_1,data_in_2,data_in_3,data_in_4,data_in_5);
	dx(1,h_cnt+1) = outdx;
	dy(1,h_cnt+1) = outdy;
end
end
