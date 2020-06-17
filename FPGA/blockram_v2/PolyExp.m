function drow = PolyExp( linebuf_0 ,linebuf_1 ,linebuf_2 ,linebuf_3 , ...
						 linebuf_4 ,linebuf_5 ,linebuf_6 ,linebuf_7 , ...
						 linebuf_8 ,linebuf_9 ,linebuf_10,linebuf_11, ...
						 linebuf_12,linebuf_13,linebuf_14,linebuf_15,linebuf_src);
%--------------------------------------------
width  = 200;
n = 8;
%--------------------------------------------
row = zeros(1,(width + n*2)*3+24+ n*3);
drow = zeros(1,width*5);
% -------------------------------------------- pipe1
for h_cnt = 0:width-1
	indata_src = linebuf_src(1,h_cnt+1);
	indata_0_0 = 0;
	indata_0_1 = 0;
	%==========================
	data_out = PolyExp_pipeline1(indata_src,indata_0_0,indata_0_1);
	%==========================
	y2_buf = bitsliceget(data_out,72,49); 
	y1_buf = bitsliceget(data_out,48,25); 
	y0_buf = bitsliceget(data_out,24,1); 
	y2 = double(fi(y2_buf,1,24,8));
	y1 = double(fi(y1_buf,1,24,8));
	y0 = double(fi(y0_buf,1,24,8));
	%==========================
	row(1,h_cnt*3+25) = y2;
	row(1,h_cnt*3+26) = y1;
	row(1,h_cnt*3+27) = y0;
end
%-------------------------------------------- pipe2								  
for k = 1: n
	for h_cnt = 0:width-1
		indata0   = linebuf_0  (1,h_cnt+1);
		indata1   = linebuf_1  (1,h_cnt+1);
		indata2   = linebuf_2  (1,h_cnt+1);
		indata3   = linebuf_3  (1,h_cnt+1);
		indata4   = linebuf_4  (1,h_cnt+1);
		indata5   = linebuf_5  (1,h_cnt+1);
		indata6   = linebuf_6  (1,h_cnt+1);
		indata7   = linebuf_7  (1,h_cnt+1);
		indata8   = linebuf_8  (1,h_cnt+1);
		indata9   = linebuf_9  (1,h_cnt+1);
		indata10  = linebuf_10 (1,h_cnt+1);
		indata11  = linebuf_11 (1,h_cnt+1);
		indata12  = linebuf_12 (1,h_cnt+1);
		indata13  = linebuf_13 (1,h_cnt+1);
		indata14  = linebuf_14 (1,h_cnt+1);
		indata15  = linebuf_15 (1,h_cnt+1);
		int0 = row(1,h_cnt*3+25);
		int1 = row(1,h_cnt*3+26);
		int2 = row(1,h_cnt*3+27);
		[outt0, outt1, outt2] = PolyExp_pipeline2( indata0 ,indata1 ,indata2 ,indata3,...
												   indata4 ,indata5 ,indata6 ,indata7,...
												   indata8 ,indata9 ,indata10,indata11,...
												   indata12,indata13,indata14,indata15,...
												   int0,int1,int2,k );
		row(1,h_cnt*3+25) = outt0;
		row(1,h_cnt*3+26) = outt1;
		row(1,h_cnt*3+27) = outt2;						 
	end 
end
%-------------------------------------------- pipe3
for h_cnt = 0: n*3-1
	row(h_cnt+25) = row(2-h_cnt+25);
	row(width*3+h_cnt+25) = row(width*3+h_cnt-3+25);
end
%-------------------------------------------- pipe4
ig11 = 0.6944; 
ig03 = -0.3472; 
ig33 = 0.2411; 
ig55 = 0.4823;
for h_cnt = 0:width-1
	g0 = 0.332451909263490;
	inb1 = row(h_cnt*3+25)*g0;
	inb2 = 0.0;
	inb3 = row(h_cnt*3+26)*g0;
	inb4 = 0.0;
	inb5 = row(h_cnt*3+27)*g0;
	inb6 = 0.0;
	for k = 1: n
		inb1_P = row((h_cnt+k)*3+25);
		inb2_P = row((h_cnt+k)*3+26);
		inb3_P = row((h_cnt+k)*3+27);
		inb1_N = row((h_cnt-k)*3+25);
		inb2_N = row((h_cnt-k)*3+26);
		inb3_N = row((h_cnt-k)*3+27);
		[outb1,outb2,outb3,outb4,outb5,outb6] = PolyExp_pipeline4( inb1,inb2,inb3,inb4,inb5,inb6, ...
																   inb1_P,inb2_P,inb3_P,inb1_N,inb2_N,inb3_N,k);
		inb1 = outb1;
		inb2 = outb2;
		inb3 = outb3;
		inb4 = outb4;
		inb5 = outb5;
		inb6 = outb6;
	end
	drow(1,h_cnt*5+2) = outb2*ig11;
	drow(1,h_cnt*5+1) = outb3*ig11;
	drow(1,h_cnt*5+4) = outb1*ig03 + outb4*ig33;
	drow(1,h_cnt*5+3) = outb1*ig03 + outb5*ig33;
	drow(1,h_cnt*5+5) = outb6*ig55;
end
%-------------------------------------------- 
end
