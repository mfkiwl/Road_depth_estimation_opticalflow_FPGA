% blockram version

clc,clear;
%-------------------------------------------- Parameter Setting
width  = 200;
height = 200;
n = 8;
%-------------------------------------------- Video IN
filename='Edit_video_6.mp4';
v = VideoReader(filename);
%-------------------------------------------- Video Write
% f = VideoWriter('MATLAB_video_rgb.avi');
% open(f);
%--------------------------------------------
mag    = zeros(height,width);  
ang    = zeros(height,width);  
hsv    = zeros(height,width,3);
dx_all  = zeros(height,width); 
dy_all  = zeros(height,width);
linebuf0_0   = zeros(1,width); linebuf1_0   = zeros(1,width);
linebuf0_1   = zeros(1,width); linebuf1_1   = zeros(1,width);
linebuf0_2   = zeros(1,width); linebuf1_2   = zeros(1,width);
linebuf0_3   = zeros(1,width); linebuf1_3   = zeros(1,width);
linebuf0_4   = zeros(1,width); linebuf1_4   = zeros(1,width);
linebuf0_5   = zeros(1,width); linebuf1_5   = zeros(1,width);
linebuf0_6   = zeros(1,width); linebuf1_6   = zeros(1,width);
linebuf0_7   = zeros(1,width); linebuf1_7   = zeros(1,width);
linebuf0_8   = zeros(1,width); linebuf1_8   = zeros(1,width);
linebuf0_9   = zeros(1,width); linebuf1_9   = zeros(1,width);
linebuf0_10  = zeros(1,width); linebuf1_10  = zeros(1,width);
linebuf0_11  = zeros(1,width); linebuf1_11  = zeros(1,width);
linebuf0_12  = zeros(1,width); linebuf1_12  = zeros(1,width);
linebuf0_13  = zeros(1,width); linebuf1_13  = zeros(1,width);
linebuf0_14  = zeros(1,width); linebuf1_14  = zeros(1,width);
linebuf0_15  = zeros(1,width); linebuf1_15  = zeros(1,width);
linebuf0_src = zeros(1,width); linebuf1_src = zeros(1,width);
%-------------------------------------------- prev_gray
prev_frame = readFrame(v);
prev_gray = prev_frame(:,:,1)*0.2989+ prev_frame(:,:,2)*0.5870+ prev_frame(:,:,3)*0.1140;

while hasFrame(v)
	%------------------------------------ next_gray
    next_frame = readFrame(v);
    next_gray = next_frame(:,:,1)*0.2989+ next_frame(:,:,2)*0.5870+ next_frame(:,:,3)*0.1140;
	%------------------------------------ impyramid
    % next_gray_I = impyramid(next_gray, 'reduce');
	% next_gray_II = impyramid(next_gray_I, 'reduce');
	% next_gray_III = impyramid(next_gray_II, 'reduce');
	% prev_gray_I = impyramid(prev_gray, 'reduce');
	% prev_gray_II = impyramid(prev_gray_I, 'reduce');
	% prev_gray_III = impyramid(prev_gray_II, 'reduce');
	% next_gray = imresize(next_gray_III, [200, 200]); 
	% prev_gray = imresize(prev_gray_III, [200, 200]); 
    %------------------------------------ calcOpticalFlowFarneback
	for v_cnt = 0: height-1
		%-------------------------------------------- prev_linebuf
		[linebuf0_0 ,linebuf0_1 ,linebuf0_2 ,linebuf0_3 , ...
		 linebuf0_4 ,linebuf0_5 ,linebuf0_6 ,linebuf0_7 , ...
		 linebuf0_8 ,linebuf0_9 ,linebuf0_10,linebuf0_11, ...
		 linebuf0_12,linebuf0_13,linebuf0_14,linebuf0_15,linebuf0_src] = linebuf_exp(prev_gray,v_cnt);
		%-------------------------------------------- next_linebuf
		[linebuf1_0 ,linebuf1_1 ,linebuf1_2 ,linebuf1_3 , ...
		 linebuf1_4 ,linebuf1_5 ,linebuf1_6 ,linebuf1_7 , ...
		 linebuf1_8 ,linebuf1_9 ,linebuf1_10,linebuf1_11, ...
		 linebuf1_12,linebuf1_13,linebuf1_14,linebuf1_15,linebuf1_src] = linebuf_exp(next_gray,v_cnt);
		%-------------------------------------------- PoiyExp R0
		R0 = PolyExp( linebuf0_0 ,linebuf0_1 ,linebuf0_2 ,linebuf0_3 , ...
					  linebuf0_4 ,linebuf0_5 ,linebuf0_6 ,linebuf0_7 , ...
					  linebuf0_8 ,linebuf0_9 ,linebuf0_10,linebuf0_11, ...
					  linebuf0_12,linebuf0_13,linebuf0_14,linebuf0_15,linebuf0_src);
		%-------------------------------------------- PoiyExp R1
		R1 = PolyExp( linebuf1_0 ,linebuf1_1 ,linebuf1_2 ,linebuf1_3 , ...
					  linebuf1_4 ,linebuf1_5 ,linebuf1_6 ,linebuf1_7 , ...
					  linebuf1_8 ,linebuf1_9 ,linebuf1_10,linebuf1_11, ...
					  linebuf1_12,linebuf1_13,linebuf1_14,linebuf1_15,linebuf1_src);
		%-------------------------------------------- UpdateMatrices
		M = UpdateMatrices(R0,R1,v_cnt);
		%-------------------------------------------- UpdateFlow
		[dx,dy] = UpdateFlow(M);
		%--------------------------------------------
		dx_all(v_cnt+1,:) = dx(:);
		dy_all(v_cnt+1,:) = dy(:);
	end
	%------------------------------------ gausFilter
    % dx_all= imfilter(dx_all, gausFilter, 'replicate');
    % dy_all= imfilter(dy_all, gausFilter, 'replicate');
	%------------------------------------hsv
	for y = 0: height-1
		for x = 0: width-1
			dx_buf = dx_all(y+1,x+1);
			dy_buf = dy_all(y+1,x+1);
			% ------------------------------------ Strength
			strength = sqrt(dx_buf^2+dy_buf^2); 
			if strength > 0.5
				mag(y+1,x+1) = 1;
			else
				mag(y+1,x+1) = 0;
			end 
			% ------------------------------------ Angle
			angle = atan(dy_buf/dx_buf)*180/3.14;
			if abs(angle) < 0
				ang(y+1,x+1) = angle + 360;
			else
				ang(y+1,x+1) = abs(angle);
			end
		end 
	end
	mag = mapminmax(mag,0,1); %normalize(0~1)
	ang = mapminmax(ang,0,1); %normalize(0~1)
	hsv(:,:,1) = ang; % Hue 
	hsv(:,:,2) = 1;   % Saturation
	hsv(:,:,3) = mag; % Lightness
	RGB = hsv2rgb(hsv);
	% ------------------------------------ quiver
	[x,y] = meshgrid(1:1:200,1:1:200);
	% ------------------------------------ Show image
	w = waitforbuttonpress;
	Cha = get(gcf,'CurrentCharacter');
    if strcmpi(Cha,'c')
		figure(1);
		subplot(2,2,1),imshow(prev_gray),title('prev_g');
		subplot(2,2,2),imshow(next_gray),title('next_g');
		subplot(2,2,3),imshow(hsv),title('hsv');
		subplot(2,2,4),imshow(RGB),title('RGB');
		axis([1 200 1 200]);
		figure(2);
		subplot(1,1,1),quiver(x,y,dx_all,dy_all,10);title('arrow');
		axis([1 200 1 200]);
		set(gca,'YDir','reverse');
	elseif strcmpi(Cha,'b')
		break;
    end
	%------------------------------------ Write image
	% writeVideo(f,RGB);
	%------------------------------------
	% figure(1);
	% imshow(prev_gray);

	prev_gray = next_gray;
end 
close all;
% close(f);