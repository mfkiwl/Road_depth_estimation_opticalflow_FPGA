% blockram version

function [dx dy] = FarnebackUpdateFlow (M)
%--------------------------------------------
width  = 200;
height = 200;
%--------------------------------------------
dx  = single(zeros(height,width));
dy  = single(zeros(height,width));
%-------------------------------------------- pipe1
for y = 0: height-1
    for x = 0: width-1
        g11 = M(y+1,x*5+1);
        g12 = M(y+1,x*5+2);
        g22 = M(y+1,x*5+3);
        h1  = M(y+1,x*5+4);
        h2  = M(y+1,x*5+5);
        idet = 1/(g11*g22 - g12*g12 + 0.001);
		% idet = idet + idet/3;
        dx(y+1,x+1) = (g11*h2-g12*h1)*idet;
        dy(y+1,x+1) = (g22*h1-g12*h2)*idet;
    end 
end 