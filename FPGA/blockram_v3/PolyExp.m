function drow = PolyExp( linebuf_0 ,linebuf_1 ,linebuf_2 ,linebuf_3 , ...
						 linebuf_4 ,linebuf_5 ,linebuf_6 ,linebuf_7 , ...
						 linebuf_8 ,linebuf_9 ,linebuf_10,linebuf_11, ...
						 linebuf_12,linebuf_13,linebuf_14,linebuf_15,linebuf_src)
%--------------------------------------------
width  = 200;
n = 8;
%--------------------------------------------
row = zeros(1,(width + n*2)*3+24+ n*3);
drow = zeros(1,width*5);
%--------------------------------------------
for h_cnt = 0:width-1
	%-------------------------------------------- linebuf
	indata_src = linebuf_src(1,h_cnt+1);
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
	%-------------------------------------------- pipe1
	[out1,out2,out3] = PolyExp_pipeline1(indata_src);
	%-------------------------------------------- pipe2								  
	[outt1, outt2, outt3] = PolyExp_pipeline2(indata0 ,indata1 ,indata2 ,indata3,...
											  indata4 ,indata5 ,indata6 ,indata7,...
											  indata8 ,indata9 ,indata10,indata11,...
											  indata12,indata13,indata14,indata15,...
											  out1,out2,out3);	
	%-------------------------------------------- pipe3
	% for h_cnt = 0: n*3-1
		% row(h_cnt+25) = row(2-h_cnt+25);
		% row(width*3+h_cnt+25) = row(width*3+h_cnt-3+25);
	% end
	%-------------------------------------------- pipe4
	[outttt1,outttt2,outttt3,outttt4,outttt5] = PolyExp_pipeline4(outt1,outt2,outt3);
	
	drow(1,h_cnt*5+2) = outttt1;
	drow(1,h_cnt*5+1) = outttt2;
	drow(1,h_cnt*5+4) = outttt3;
	drow(1,h_cnt*5+3) = outttt4;
	drow(1,h_cnt*5+5) = outttt5;
end
%--------------------------------------------
end
