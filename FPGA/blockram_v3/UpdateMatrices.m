function M = UpdateMatrices(R0,R1,v_cnt)

%--------------------------------------------
width  = 200;
%--------------------------------------------
M = zeros(1,width*5);
%--------------------------------------------
for h_cnt = 0: width-1
	R0_data_1 = R0(1,h_cnt*5+1);
	R0_data_2 = R0(1,h_cnt*5+2);
	R0_data_3 = R0(1,h_cnt*5+3);
	R0_data_4 = R0(1,h_cnt*5+4);
	R0_data_5 = R0(1,h_cnt*5+5);
	
	R1_data_1 = R1(1,h_cnt*5+1);
	R1_data_2 = R1(1,h_cnt*5+2);
	R1_data_3 = R1(1,h_cnt*5+3);
	R1_data_4 = R1(1,h_cnt*5+4);
	R1_data_5 = R1(1,h_cnt*5+5);
	%-------------------------------------------- pipe1
	[M_1,M_2,M_3,M_4,M_5] = UpdateMatrices_pipeline1( R0_data_1,R0_data_2,R0_data_3,R0_data_4,R0_data_5,...
													  R1_data_1,R1_data_2,R1_data_3,R1_data_4,R1_data_5,...
													  h_cnt,v_cnt);
	%--------------------------------------------
	M(1,h_cnt*5+1) = M_1;
	M(1,h_cnt*5+2) = M_2;
	M(1,h_cnt*5+3) = M_3;
	M(1,h_cnt*5+4) = M_4;
	M(1,h_cnt*5+5) = M_5;
end

end
