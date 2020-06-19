function [data_out_0, data_out_1, data_out_2] = PolyExp_pipeline2( indata_0 ,indata_1 ,indata_2 ,indata_3,...
																   indata_4 ,indata_5 ,indata_6 ,indata_7,...
																   indata_8 ,indata_9 ,indata_10,indata_11,...
																   indata_12,indata_13,indata_14,indata_15,...
																   int0,int1,int2)
%--------------------------------------------								
n = 8;
%--------------------------------------------
g    = zeros(1,17);
xg   = zeros(1,17);
xxg  = zeros(1,17);
%--------------------------------------------
g(1, 1) = 7.425750567660737e-11;  xg(1, 1) = -5.940600454128590e-10; xxg(1, 1) = 4.752480363302872e-09;
g(1, 2) = 1.357346656654903e-08;  xg(1, 2) = -9.501426596584319e-08; xxg(1, 2) = 6.650998617609023e-07;
g(1, 3) = 1.238932971502896e-06;  xg(1, 3) = -7.433597829017376e-06; xxg(1, 3) = 4.460158697410425e-05;
g(1, 4) = 5.646917756715771e-05;  xg(1, 4) = -2.823458878357885e-04; xxg(1, 4) = 0.001411729439179;
g(1, 5) = 0.001285225836022;      xg(1, 5) = -0.005140903344087;     xxg(1, 5) = 0.020563613376348;
g(1, 6) = 0.014606906292119;      xg(1, 6) = -0.043820718876357;     xxg(1, 6) = 0.131462156629071;
g(1, 7) = 0.082897614969052;      xg(1, 7) = -0.165795229938103;     xxg(1, 7) = 0.331590459876207;
g(1, 8) = 0.234926576512800;      xg(1, 8) = -0.234926576512800;     xxg(1, 8) = 0.234926576512800;
g(1, 9) = 0.332451909263490;      xg(1, 9) = 0.0;                    xxg(1, 9) = 0.0;
g(1,10) = 0.234926576512800;      xg(1,10) = 0.234926576512800;      xxg(1,10) = 0.234926576512800;
g(1,11) = 0.082897614969052;      xg(1,11) = 0.165795229938103;      xxg(1,11) = 0.331590459876207;
g(1,12) = 0.014606906292119;      xg(1,12) = 0.043820718876357;      xxg(1,12) = 0.131462156629071;
g(1,13) = 0.001285225836022;      xg(1,13) = 0.005140903344087;      xxg(1,13) = 0.020563613376348;
g(1,14) = 5.646917756715771e-05;  xg(1,14) = 2.823458878357885e-04;  xxg(1,14) = 0.001411729439179;
g(1,15) = 1.238932971502896e-06;  xg(1,15) = 7.433597829017376e-06;  xxg(1,15) = 4.460158697410425e-05;
g(1,16) = 1.357346656654903e-08;  xg(1,16) = 9.501426596584319e-08;  xxg(1,16) = 6.650998617609023e-07;
g(1,17) = 7.425750567660737e-11;  xg(1,17) = 5.940600454128590e-10;  xxg(1,17) = 4.752480363302872e-09;		 
%--------------------------------------------
data_0_buf = indata_0;
data_1_buf = indata_1;
data_2_buf = indata_2;
data_3_buf = indata_3;
data_4_buf = indata_4;
data_5_buf = indata_5;
data_6_buf = indata_6;
data_7_buf = indata_7;
data_8_buf = indata_8;
data_9_buf = indata_9;
data_10_buf = indata_10;
data_11_buf = indata_11;
data_12_buf = indata_12;
data_13_buf = indata_13;
data_14_buf = indata_14;
data_15_buf = indata_15;
int0_buf = int0;
int1_buf = int1;
int2_buf = int2;

for k = 1: n
	g0 = g(1,k+9);
	g1 = xg(1,k+9);
	g2 = xxg(1,k+9);
	if k == 1
		srow_0 = data_0_buf;
		srow_1 = data_8_buf;
	elseif k == 2
		srow_0 = data_1_buf;
		srow_1 = data_9_buf;
	elseif k == 3
		srow_0 = data_2_buf;
		srow_1 = data_10_buf;
	elseif k == 4
		srow_0 = data_3_buf;
		srow_1 = data_11_buf;
	elseif k == 5
		srow_0 = data_4_buf;
		srow_1 = data_12_buf;
	elseif k == 6
		srow_0 = data_5_buf;
		srow_1 = data_13_buf;
	elseif k == 7
		srow_0 = data_6_buf;
		srow_1 = data_14_buf;
	elseif k == 8
		srow_0 = data_7_buf;
		srow_1 = data_15_buf;
	else
		srow_0 = 0.0;
		srow_1 = 0.0;
	end
			
	p = srow_1 + srow_0;
	q = srow_1 - srow_0;

	outt0 = int0_buf + g0 * p;
	outt1 = int1_buf + g1 * q;
	outt2 = int2_buf + g2 * p;
	%----------------------
	int0_buf = outt0;
	int1_buf = outt1;
	int2_buf = outt2;
	%----------------------
end
data_out_0 = int0_buf;
data_out_1 = int1_buf;
data_out_2 = int2_buf;
end
