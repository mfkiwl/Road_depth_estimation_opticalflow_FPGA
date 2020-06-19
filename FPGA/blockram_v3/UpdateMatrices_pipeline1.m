function [M_1,M_2,M_3,M_4,M_5] = UpdateMatrices_pipeline1( R0_data_1,R0_data_2,R0_data_3,R0_data_4,R0_data_5,...
													       R1_data_1,R1_data_2,R1_data_3,R1_data_4,R1_data_5,...
													       h_cnt,v_cnt)
%--------------------------------------------
width  = 200;
height = 200;
%--------------------------------------------
persistent ctr;
persistent R0_Ram1 R0_Ram2 R0_Ram3 R0_Ram4 R0_Ram5;
persistent R1_Ram1 R1_Ram2 R1_Ram3 R1_Ram4 R1_Ram5;

if isempty(ctr)
	ctr = uint8(1);
end
if isempty(R0_Ram1)
	R0_Ram1 = zeros(1,width);
end		
if isempty(R0_Ram2)
	R0_Ram2 = zeros(1,width);
end	
if isempty(R0_Ram3)
	R0_Ram3 = zeros(1,width);
end	
if isempty(R0_Ram4)
	R0_Ram4 = zeros(1,width);
end		
if isempty(R0_Ram5)
	R0_Ram5 = zeros(1,width);
end			

if isempty(R1_Ram1)
	R1_Ram1 = zeros(1,width);
end		
if isempty(R1_Ram2)
	R1_Ram2 = zeros(1,width);
end	
if isempty(R1_Ram3)
	R1_Ram3 = zeros(1,width);
end	
if isempty(R1_Ram4)
	R1_Ram4 = zeros(1,width);
end		
if isempty(R1_Ram5)
	R1_Ram5 = zeros(1,width);
end	
%--------------------------------------------
BRAM_in_R0_1 = R0_data_1;
BRAM_in_R0_2 = R0_data_2;
BRAM_in_R0_3 = R0_data_3;
BRAM_in_R0_4 = R0_data_4;
BRAM_in_R0_5 = R0_data_5;
BRAM_in_R1_1 = R1_data_1;
BRAM_in_R1_2 = R1_data_2;
BRAM_in_R1_3 = R1_data_3;
BRAM_in_R1_4 = R1_data_4;
BRAM_in_R1_5 = R1_data_5;
%---------------------- write BRAM
writeData_R0_1 = BRAM_in_R0_1;
writeData_R0_2 = BRAM_in_R0_2;
writeData_R0_3 = BRAM_in_R0_3;
writeData_R0_4 = BRAM_in_R0_4;
writeData_R0_5 = BRAM_in_R0_5;
writeData_R1_1 = BRAM_in_R1_1;
writeData_R1_2 = BRAM_in_R1_2;
writeData_R1_3 = BRAM_in_R1_3;
writeData_R1_4 = BRAM_in_R1_4;
writeData_R1_5 = BRAM_in_R1_5;

R0_Ram1(ctr) = writeData_R0_1;
R0_Ram2(ctr) = writeData_R0_2;
R0_Ram3(ctr) = writeData_R0_3;
R0_Ram4(ctr) = writeData_R0_4;
R0_Ram5(ctr) = writeData_R0_5;
R1_Ram1(ctr) = writeData_R1_1;
R1_Ram2(ctr) = writeData_R1_2;
R1_Ram3(ctr) = writeData_R1_3;
R1_Ram4(ctr) = writeData_R1_4;
R1_Ram5(ctr) = writeData_R1_5;
%---------------------- read BRAM
readData_R0_1 = R0_Ram1(ctr);
readData_R0_2 = R0_Ram2(ctr);
readData_R0_3 = R0_Ram3(ctr);
readData_R0_4 = R0_Ram4(ctr);
readData_R0_5 = R0_Ram5(ctr);
readData_R1_1 = R1_Ram1(ctr);
readData_R1_2 = R1_Ram2(ctr);
readData_R1_3 = R1_Ram3(ctr);
readData_R1_4 = R1_Ram4(ctr);
readData_R1_5 = R1_Ram5(ctr);

BRAM_out_R0_1 = readData_R0_1;
BRAM_out_R0_2 = readData_R0_2;
BRAM_out_R0_3 = readData_R0_3;
BRAM_out_R0_4 = readData_R0_4;
BRAM_out_R0_5 = readData_R0_5;
BRAM_out_R1_1 = readData_R1_1;
BRAM_out_R1_2 = readData_R1_2;
BRAM_out_R1_3 = readData_R1_3;
BRAM_out_R1_4 = readData_R1_4;
BRAM_out_R1_5 = readData_R1_5;
%--------------------------------------------	
% dx  = flow(y+1,x*2+1);
% dy  = flow(y+1,x*2+2);
dx = 0;
dy = 0;
fx = h_cnt + dx;
fy = v_cnt + dy;
x1 = floor(fx);
y1 = floor(fy);
fx = fx-x1;
fy = fy-y1;
%--------------------------------------------	
if h_cnt < width-1 && v_cnt < height-1
	a00 = (1.0 - fx)*(1.0 - fy);
	a01 = fx*(1.0-fy);
	a10 = (1.0-fx)*fy;
	a11 = fx*fy;
	
	ptr00 = BRAM_out_R1_1;
	ptr01 = BRAM_out_R1_2;
	ptr02 = BRAM_out_R1_3;
	ptr03 = BRAM_out_R1_4;
	ptr04 = BRAM_out_R1_5;

	r2 = a00*ptr00;
	r3 = a00*ptr01;
	r4 = a00*ptr02;
	r5 = a00*ptr03;
	r6 = a00*ptr04;

	r4 = (BRAM_out_R0_3 + r4)*0.5;
	r5 = (BRAM_out_R0_4 + r5)*0.5;
	r6 = (BRAM_out_R0_5 + r6)*0.25;
else
	r2 = 0.0;
	r3 = 0.0;
	r4 = BRAM_out_R0_3;
	r5 = BRAM_out_R0_4;
	r6 = BRAM_out_R0_5*0.5;
end
%--------------------------------------------	
r2 = (BRAM_out_R0_1 - r2)*0.5;
r3 = (BRAM_out_R0_2 - r3)*0.5;
r2 = r2 + r4*dy + r6*dx;
r3 = r3 + r6*dy + r5*dx;
%--------------------------------------------	
M_1 = r4*r4 + r6*r6;
M_2 = (r4 + r5) *r6; 
M_3 = r5*r5 + r6*r6;
M_4 = r4*r2 + r6*r3;
M_5 = r6*r2 + r5*r3;
%---------------------- ctr counter
if ctr == uint8(200)
	ctr = uint8(1);
else
	ctr = ctr + 1;
end
%--------------------------------------------
end
