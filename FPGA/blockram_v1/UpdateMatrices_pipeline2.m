function [r2,r3,r4,r5,r6] = UpdateMatrices_pipeline2( R0_data_2,R0_data_3,R0_data_4,...
													  R1_data_0,R1_data_1,R1_data_2,...
													  R1_data_3,R1_data_4,x1,y1,fx,fy)
%--------------------------------------------
width  = 200;
height = 200;
%--------------------------------------------
if x1 < width-1 && y1 < height-1
	a00 = (1.0 - fx)*(1.0 - fy);
	a01 = fx*(1.0-fy);
	a10 = (1.0-fx)*fy;
	a11 = fx*fy;
	
	ptr00 = R1_data_0; 
	ptr01 = R1_data_1; 
	ptr02 = R1_data_2; 
	ptr03 = R1_data_3; 
	ptr04 = R1_data_4; 
	
	r2 = a00*ptr00;
	r3 = a00*ptr01;
	r4 = a00*ptr02;
	r5 = a00*ptr03;
	r6 = a00*ptr04;

	r4 = (R0_data_2 + r4)*0.5;
	r5 = (R0_data_3 + r5)*0.5;
	r6 = (R0_data_4 + r6)*0.25;
else
	r2 = 0.0;
	r3 = 0.0;
	r4 = R0_data_2;
	r5 = R0_data_3;
	r6 = R0_data_4*0.5;
end

end
