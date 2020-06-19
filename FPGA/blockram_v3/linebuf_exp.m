function [linebuf0,linebuf1,linebuf2,linebuf3, ...
		  linebuf4,linebuf5,linebuf6,linebuf7, ...
		  linebuf8,linebuf9,linebuf10,linebuf11, ...
		  linebuf12,linebuf13,linebuf14,linebuf15,linebuf_src] = linebuf_exp(src,v_cnt)
%-------------------------------------------- Parameter Setting
width  = 200;
height = 200;	  
%------------------------------------ Initial
linebuf_src = zeros(1,width); 
linebuf0    = zeros(1,width);   
linebuf1    = zeros(1,width);   
linebuf2    = zeros(1,width);   
linebuf3    = zeros(1,width);   
linebuf4    = zeros(1,width);   
linebuf5    = zeros(1,width);   
linebuf6    = zeros(1,width);   
linebuf7    = zeros(1,width);  
linebuf8    = zeros(1,width);   
linebuf9    = zeros(1,width);   
linebuf10   = zeros(1,width);   
linebuf11   = zeros(1,width);  
linebuf12   = zeros(1,width);   
linebuf13   = zeros(1,width);   
linebuf14   = zeros(1,width);   
linebuf15   = zeros(1,width);  
%------------------------------------ linebuf access
for h_cnt = 0: width-1
	linebuf0 (h_cnt+1) 		= src(max(v_cnt-1,0)+1,h_cnt+1); % k =1
	linebuf1 (h_cnt+1) 		= src(max(v_cnt-2,0)+1,h_cnt+1); % k =2
	linebuf2 (h_cnt+1) 		= src(max(v_cnt-3,0)+1,h_cnt+1); % k =3
	linebuf3 (h_cnt+1) 		= src(max(v_cnt-4,0)+1,h_cnt+1); % k =4
	linebuf4 (h_cnt+1) 		= src(max(v_cnt-5,0)+1,h_cnt+1); % k =5
	linebuf5 (h_cnt+1) 		= src(max(v_cnt-6,0)+1,h_cnt+1); % k =6
	linebuf6 (h_cnt+1) 		= src(max(v_cnt-7,0)+1,h_cnt+1); % k =7
	linebuf7 (h_cnt+1) 		= src(max(v_cnt-8,0)+1,h_cnt+1); % k =8
	linebuf_src (h_cnt+1) 	= src(v_cnt+1,h_cnt+1);
	linebuf8 (h_cnt+1) 		= src(min(v_cnt+1,height-1)+1,h_cnt+1); % k =1
	linebuf9 (h_cnt+1) 		= src(min(v_cnt+2,height-1)+1,h_cnt+1); % k =2
	linebuf10(h_cnt+1) 		= src(min(v_cnt+3,height-1)+1,h_cnt+1); % k =3
	linebuf11(h_cnt+1) 		= src(min(v_cnt+4,height-1)+1,h_cnt+1); % k =4
	linebuf12(h_cnt+1) 		= src(min(v_cnt+5,height-1)+1,h_cnt+1); % k =5
	linebuf13(h_cnt+1) 		= src(min(v_cnt+6,height-1)+1,h_cnt+1); % k =6
	linebuf14(h_cnt+1) 		= src(min(v_cnt+7,height-1)+1,h_cnt+1); % k =7
	linebuf15(h_cnt+1) 		= src(min(v_cnt+8,height-1)+1,h_cnt+1); % k =8
end