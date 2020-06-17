function M = UpdateMatrices(R0,R1,v_cnt)

%--------------------------------------------
width  = 200;
%--------------------------------------------
M = zeros(1,width*5);
%--------------------------------------------
for h_cnt = 0: width-1
	R0_data_0 = R0(1,h_cnt*5+1);
	R0_data_1 = R0(1,h_cnt*5+2);
	R0_data_2 = R0(1,h_cnt*5+3);
	R0_data_3 = R0(1,h_cnt*5+4);
	R0_data_4 = R0(1,h_cnt*5+5);
	R1_data_0 = R1(1,h_cnt*5+1);
	R1_data_1 = R1(1,h_cnt*5+2);
	R1_data_2 = R1(1,h_cnt*5+3);
	R1_data_3 = R1(1,h_cnt*5+4);
	R1_data_4 = R1(1,h_cnt*5+5);
	%-------------------------------------------- pipe1
	[dx,dy,x1,y1,fx,fy] = UpdateMatrices_pipeline1( v_cnt,h_cnt);
	%-------------------------------------------- pipe2
	[r2,r3,r4,r5,r6] = UpdateMatrices_pipeline2( R0_data_2,R0_data_3,R0_data_4,...
												 R1_data_0,R1_data_1,R1_data_2,...
												 R1_data_3,R1_data_4,x1,y1,fx,fy);
	%-------------------------------------------- pipe3									 
	[r2,r3,r4,r5,r6] = UpdateMatrices_pipeline3(R0_data_0,R0_data_1,r2,r3,r4,r5,r6,dx,dy);
	%-------------------------------------------- pipe4
	[outdata0,outdata1,outdata2,outdata3,outdata4] = UpdateMatrices_pipeline4(r2,r3,r4,r5,r6);
	%--------------------------------------------
	M(1,h_cnt*5+1) = outdata0;
	M(1,h_cnt*5+2) = outdata1;
	M(1,h_cnt*5+3) = outdata2;
	M(1,h_cnt*5+4) = outdata3;
	M(1,h_cnt*5+5) = outdata4;
end

end
