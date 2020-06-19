function [drow_1,drow_2,drow_3,drow_4,drow_5] = PolyExp_pipeline4(data_in_0,data_in_1,data_in_2)
%--------------------------------------------								
n = 8;			
width  = 200;
%--------------------------------------------
g    = zeros(1,n*6 + 3 + n);
xg   = zeros(1,n*6 + 3 + n + n*2 + 1);
xxg  = zeros(1,n*6 + 3 + n + n*2 + 1 + n*2 + 1);
%--------------------------------------------
persistent rRam1 rRam2 rRam3 ctr;
if isempty(ctr)
	ctr = uint8(1);
end
if isempty(rRam1)
	rRam1 = zeros(1,width);
end		
if isempty(rRam2)
	rRam2 = zeros(1,width);
end	
if isempty(rRam3)
	rRam3 = zeros(1,width);
end		
%----------------------
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
ig11 = 0.6944; ig03 = -0.3472; ig33 = 0.2411; ig55 = 0.4823;
%----------------------
BRAM_in_1 = data_in_0;
BRAM_in_2 = data_in_1;
BRAM_in_3 = data_in_2;
%---------------------- write BRAM
writeData_1 = BRAM_in_1;
writeData_2 = BRAM_in_2;
writeData_3 = BRAM_in_3;
rRam1(ctr) = writeData_1;
rRam2(ctr) = writeData_2;
rRam3(ctr) = writeData_3;
%---------------------- read BRAM
readData_1 = rRam1(ctr);
readData_2 = rRam2(ctr);
readData_3 = rRam3(ctr);
BRAM_out_1 = readData_1;
BRAM_out_2 = readData_2;
BRAM_out_3 = readData_3;
%----------------------
inb1 = BRAM_out_1*g(1, 9);
inb2 = 0.0;
inb3 = BRAM_out_2*g(1, 9);
inb4 = 0.0;
inb5 = BRAM_out_3*g(1, 9);
inb6 = 0.0;
%----------------------
rRam1_P_1 = rRam1(min(ctr+1,200));
rRam1_P_2 = rRam1(min(ctr+2,200));
rRam1_P_3 = rRam1(min(ctr+3,200));
rRam1_P_4 = rRam1(min(ctr+4,200));
rRam1_P_5 = rRam1(min(ctr+5,200));
rRam1_P_6 = rRam1(min(ctr+6,200));
rRam1_P_7 = rRam1(min(ctr+7,200));
rRam1_P_8 = rRam1(min(ctr+8,200));
rRam1_N_1 = rRam1(max(ctr-1,1));
rRam1_N_2 = rRam1(max(ctr-2,1));
rRam1_N_3 = rRam1(max(ctr-3,1));
rRam1_N_4 = rRam1(max(ctr-4,1));
rRam1_N_5 = rRam1(max(ctr-5,1));
rRam1_N_6 = rRam1(max(ctr-6,1));
rRam1_N_7 = rRam1(max(ctr-7,1));
rRam1_N_8 = rRam1(max(ctr-8,1));
%----------------------
rRam2_P_1 = rRam2(min(ctr+1,200));
rRam2_P_2 = rRam2(min(ctr+2,200));
rRam2_P_3 = rRam2(min(ctr+3,200));
rRam2_P_4 = rRam2(min(ctr+4,200));
rRam2_P_5 = rRam2(min(ctr+5,200));
rRam2_P_6 = rRam2(min(ctr+6,200));
rRam2_P_7 = rRam2(min(ctr+7,200));
rRam2_P_8 = rRam2(min(ctr+8,200));
rRam2_N_1 = rRam2(max(ctr-1,1));
rRam2_N_2 = rRam2(max(ctr-2,1));
rRam2_N_3 = rRam2(max(ctr-3,1));
rRam2_N_4 = rRam2(max(ctr-4,1));
rRam2_N_5 = rRam2(max(ctr-5,1));
rRam2_N_6 = rRam2(max(ctr-6,1));
rRam2_N_7 = rRam2(max(ctr-7,1));
rRam2_N_8 = rRam2(max(ctr-8,1));
%----------------------
rRam3_P_1 = rRam3(min(ctr+1,200));
rRam3_P_2 = rRam3(min(ctr+2,200));
rRam3_P_3 = rRam3(min(ctr+3,200));
rRam3_P_4 = rRam3(min(ctr+4,200));
rRam3_P_5 = rRam3(min(ctr+5,200));
rRam3_P_6 = rRam3(min(ctr+6,200));
rRam3_P_7 = rRam3(min(ctr+7,200));
rRam3_P_8 = rRam3(min(ctr+8,200));
rRam3_N_1 = rRam3(max(ctr-1,1));
rRam3_N_2 = rRam3(max(ctr-2,1));
rRam3_N_3 = rRam3(max(ctr-3,1));
rRam3_N_4 = rRam3(max(ctr-4,1));
rRam3_N_5 = rRam3(max(ctr-5,1));
rRam3_N_6 = rRam3(max(ctr-6,1));
rRam3_N_7 = rRam3(max(ctr-7,1));
rRam3_N_8 = rRam3(max(ctr-8,1));
%----------------------
inb1_P = 0;
inb1_N = 0;
inb2_P = 0;
inb2_N = 0;
inb3_P = 0;
inb3_N = 0;
for k = 1: n
	if k == 1
		inb1_P = rRam1_P_1;
		inb1_N = rRam1_N_1;
		inb2_P = rRam2_P_1;
		inb2_N = rRam2_N_1;
		inb3_P = rRam3_P_1;
		inb3_N = rRam3_N_1;
	elseif k == 2
		inb1_P = rRam1_P_2;
		inb1_N = rRam1_N_2;
		inb2_P = rRam2_P_2;
		inb2_N = rRam2_N_2;
		inb3_P = rRam3_P_2;
		inb3_N = rRam3_N_2;
	elseif k == 3
		inb1_P = rRam1_P_3;
		inb1_N = rRam1_N_3;
		inb2_P = rRam2_P_3;
		inb2_N = rRam2_N_3;
		inb3_P = rRam3_P_3;
		inb3_N = rRam3_N_3;
	elseif k == 4
		inb1_P = rRam1_P_4;
		inb1_N = rRam1_N_4;
		inb2_P = rRam2_P_4;
		inb2_N = rRam2_N_4;
		inb3_P = rRam3_P_4;
		inb3_N = rRam3_N_4;
	elseif k == 5
		inb1_P = rRam1_P_5;
		inb1_N = rRam1_N_5;
		inb2_P = rRam2_P_5;
		inb2_N = rRam2_N_5;
		inb3_P = rRam3_P_5;
		inb3_N = rRam3_N_5;
	elseif k == 6
		inb1_P = rRam1_P_6;
		inb1_N = rRam1_N_6;
		inb2_P = rRam2_P_6;
		inb2_N = rRam2_N_6;
		inb3_P = rRam3_P_6;
		inb3_N = rRam3_N_6;
	elseif k == 7
		inb1_P = rRam1_P_7;
		inb1_N = rRam1_N_7;
		inb2_P = rRam2_P_7;
		inb2_N = rRam2_N_7;
		inb3_P = rRam3_P_7;
		inb3_N = rRam3_N_7;
	elseif k == 8
		inb1_P = rRam1_P_8;
		inb1_N = rRam1_N_8;
		inb2_P = rRam2_P_8;
		inb2_N = rRam2_N_8;
		inb3_P = rRam3_P_8;
		inb3_N = rRam3_N_8;
	end
	
	tg = inb1_P + inb1_N;
	g0 = g(1,k+9);
	outb1 = inb1 + tg * g0;
	outb4 = inb4 + tg * xxg(1,k+9);
	outb2 = inb2 + (inb1_P - inb1_N) * xg(1,k+9);
	outb3 = inb3 + (inb2_P + inb2_N) * g0;
	outb6 = inb6 + (inb2_P - inb2_N) * xg(1,k+9);
	outb5 = inb5 + (inb3_P + inb3_N) * g0;
	
	inb1 = outb1;
	inb2 = outb2;
	inb3 = outb3;
	inb4 = outb4;
	inb5 = outb5;
	inb6 = outb6;
end

outb1 = inb1;
outb2 = inb2;
outb3 = inb3;
outb4 = inb4;
outb5 = inb5;
outb6 = inb6;
%----------------------
drow_1 = outb2*ig11;
drow_2 = outb3*ig11;
drow_3 = outb1*ig03 + outb4*ig33;
drow_4 = outb1*ig03 + outb5*ig33;
drow_5 = outb6*ig55;
%---------------------- ctr counter
if ctr == uint8(200)
	ctr = uint8(1);
else
	ctr = ctr + 1;
end
%----------------------
end
