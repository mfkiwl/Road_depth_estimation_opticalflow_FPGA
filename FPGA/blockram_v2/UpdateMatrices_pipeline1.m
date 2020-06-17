function [dx,dy,x1,y1,fx,fy] = UpdateMatrices_pipeline1(v_cnt,h_cnt)
	dx = 0;
	dy = 0;
    fx = h_cnt + dx;
    fy = v_cnt + dy;
    x1 = floor(fx);
    y1 = floor(fy);
	fx = fx-x1;
	fy = fy-y1;
end
