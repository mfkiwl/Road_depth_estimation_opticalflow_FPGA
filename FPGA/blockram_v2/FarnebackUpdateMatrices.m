% blockram version

function M = FarnebackUpdateMatrices (R0, R1 , y0_buf, y1_buf)
%--------------------------------------------
width  = 200;
height = 200;
%--------------------------------------------
M = zeros(height,width*5);
%--------------------------------------------
for y = y0_buf: y1_buf-1
    for x = 0: width-1
		%-------------------------------------------- pipe1
        % dx  = flow(y+1,x*2+1);
        % dy  = flow(y+1,x*2+2);
		dx = 0;
		dy = 0;
        fx = x + dx;
        fy = y + dy;
        x1 = floor(fx);
        y1 = floor(fy);
		fx = fx-x1;
		fy = fy-y1;
		%-------------------------------------------- pipe2
		if x1 < width-1 && y1 < height-1
			a00 = (1.0 - fx)*(1.0 - fy);
			a01 = fx*(1.0-fy);
			a10 = (1.0-fx)*fy;
			a11 = fx*fy;
			
			ptr00 = R1(y1+1,x1*5+1); ptr10  = R1(y1+2,x1*5+1);
			ptr01 = R1(y1+1,x1*5+2); ptr11  = R1(y1+2,x1*5+2);
			ptr02 = R1(y1+1,x1*5+3); ptr12  = R1(y1+2,x1*5+3);
			ptr03 = R1(y1+1,x1*5+4); ptr13  = R1(y1+2,x1*5+4);
			ptr04 = R1(y1+1,x1*5+5); ptr14  = R1(y1+2,x1*5+5);
			ptr05 = R1(y1+1,x1*5+6); ptr15  = R1(y1+2,x1*5+6);
			ptr06 = R1(y1+1,x1*5+7); ptr16  = R1(y1+2,x1*5+7);
			ptr07 = R1(y1+1,x1*5+8); ptr17  = R1(y1+2,x1*5+8);
			ptr08 = R1(y1+1,x1*5+9); ptr18  = R1(y1+2,x1*5+9);
			ptr09 = R1(y1+1,x1*5+10); ptr19 = R1(y1+2,x1*5+10);
			% ptr00 = R1(x1*5+1);
			% ptr01 = R1(x1*5+2);
			% ptr02 = R1(x1*5+3);
			% ptr03 = R1(x1*5+4);
			% ptr04 = R1(x1*5+5);
			
			
			
			r2 = a00*ptr00 + a01*ptr05 + a10*ptr10 + a11*ptr15;
			r3 = a00*ptr01 + a01*ptr06 + a10*ptr11 + a11*ptr16;
			r4 = a00*ptr02 + a01*ptr07 + a10*ptr12 + a11*ptr17;
			r5 = a00*ptr03 + a01*ptr08 + a10*ptr13 + a11*ptr18;
			r6 = a00*ptr04 + a01*ptr09 + a10*ptr14 + a11*ptr19;
			
			% r2 = a00*ptr00;
			% r3 = a00*ptr01;
			% r4 = a00*ptr02;
			% r5 = a00*ptr03;
			% r6 = a00*ptr04;
			
			r4 = (R0(y+1,x*5+3) + r4)*0.5;
			r5 = (R0(y+1,x*5+4) + r5)*0.5;
			r6 = (R0(y+1,x*5+5) + r6)*0.25;
		else
			r2 = 0.0;
			r3 = 0.0;
			r4 = R0(y+1,x*5+3);
			r5 = R0(y+1,x*5+4);
			r6 = R0(y+1,x*5+5)*0.5;
		end
		%-------------------------------------------- pipe3
        r2 = (R0(y+1,x*5+1) - r2)*0.5;
        r3 = (R0(y+1,x*5+2) - r3)*0.5;
        r2 = r2 + r4*dy + r6*dx;
        r3 = r3 + r6*dy + r5*dx;
		%-------------------------------------------- pipe4
        M(y+1,x*5+1) = r4*r4 + r6*r6;
        M(y+1,x*5+2) = (r4 + r5) *r6; 
        M(y+1,x*5+3) = r5*r5 + r6*r6;
        M(y+1,x*5+4) = r4*r2 + r6*r3;
        M(y+1,x*5+5) = r6*r2 + r5*r3;
	
    end
end 