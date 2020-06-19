function [data_R0_1,data_R0_2,data_R0_3,data_R0_4,data_R0_5,...
		  data_R1_1,data_R1_2,data_R1_3,data_R1_4,data_R1_5] ...
		  = pingpongbuffer(data_in_1,data_in_2,data_in_3,data_in_4,data_in_5)
%--------------------------------------------
width = 200;
%--------------------------------------------
persistent ctr;
persistent flag;
persistent R0_Ram1 R0_Ram2 R0_Ram3 R0_Ram4 R0_Ram5;
persistent R1_Ram1 R1_Ram2 R1_Ram3 R1_Ram4 R1_Ram5;

if isempty(ctr)
	ctr = uint8(1);
end
if isempty(flag)
	flag = uint8(1);
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
BRAM_in_1 = data_in_1;
BRAM_in_2 = data_in_2;
BRAM_in_3 = data_in_3;
BRAM_in_4 = data_in_4;
BRAM_in_5 = data_in_5;
%---------------------- write BRAM
if flag == 1
	if ctr == 200
		flag = 0;
	else
		writeData_R0_1 = BRAM_in_1;
		writeData_R0_2 = BRAM_in_2;
		writeData_R0_3 = BRAM_in_3;
		writeData_R0_4 = BRAM_in_4;
		writeData_R0_5 = BRAM_in_5;
		
		R0_Ram1(ctr) = writeData_R0_1;
		R0_Ram2(ctr) = writeData_R0_2;
		R0_Ram3(ctr) = writeData_R0_3;
		R0_Ram4(ctr) = writeData_R0_4;
		R0_Ram5(ctr) = writeData_R0_5;
	end
else
	if ctr == 200
		flag = 1;
	else
		writeData_R1_1 = BRAM_in_1;
		writeData_R1_2 = BRAM_in_2;
		writeData_R1_3 = BRAM_in_3;
		writeData_R1_4 = BRAM_in_4;
		writeData_R1_5 = BRAM_in_5;
		
		R1_Ram1(ctr) = writeData_R1_1;
		R1_Ram2(ctr) = writeData_R1_2;
		R1_Ram3(ctr) = writeData_R1_3;
		R1_Ram4(ctr) = writeData_R1_4;
		R1_Ram5(ctr) = writeData_R1_5;
	end
end
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

data_R0_1 = readData_R0_1;
data_R0_2 = readData_R0_2;
data_R0_3 = readData_R0_3;
data_R0_4 = readData_R0_4;
data_R0_5 = readData_R0_5;
data_R1_1 = readData_R1_1;
data_R1_2 = readData_R1_2;
data_R1_3 = readData_R1_3;
data_R1_4 = readData_R1_4;
data_R1_5 = readData_R1_5;
%---------------------- ctr counter
if ctr == uint8(200)
	ctr = uint8(1);
else
	ctr = ctr + 1;
end
%--------------------------------------------
end 