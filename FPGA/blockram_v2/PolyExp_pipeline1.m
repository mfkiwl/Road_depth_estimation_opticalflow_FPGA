function data_out = PolyExp_pipeline1(indata_src,indata_0_0,indata_0_1)
%----------------------
width = 200;
%----------------------
persistent rRam ctr;
if isempty(rRam)
	p = fi([],1,72,0);
	rRam = zeros(1,width,'like',p);
	% rRam = zeros(1,width);
	ctr = uint8(1);
end
%----------------------
% DataTypeMode: Fixed-point: binary point scaling
% Signedness: (1)Unsigned (0)signed
% WordLength: 8
% FractionLength: 0
data_src = indata_src;
data_0_0 = indata_0_0;
data_0_1 = indata_0_1;

data_src_buf = data_src*0.332451909263490;
data_0_0_buf = data_0_0;
data_0_1_buf = data_0_1;


bin_src_buf = fi(data_src_buf,1,24,8);
bin_0_0_buf = fi(data_0_0_buf,1,24,8);
bin_0_1_buf = fi(data_0_1_buf,1,24,8);


% bin_data_all = bitconcat(bin_src_buf,bin_0_0_buf,bin_0_1_buf);
BRAM_in = bitconcat(bin_src_buf,bin_0_0_buf,bin_0_1_buf);
%---------------------- write BRAM
writeData = BRAM_in;
rRam(ctr) = writeData;
%---------------------- read BRAM
readData = rRam(ctr);
BRAM_out = readData;
%---------------------- operator
data_out = fi(BRAM_out,1,72,0);
y2_buf = bitsliceget(data_out,72,49); 
y1_buf = bitsliceget(data_out,48,25); 
y0_buf = bitsliceget(data_out,24,1);
y2 = double(fi(y2_buf,1,24,8));
y1 = double(fi(y1_buf,1,24,8));
y0 = double(fi(y0_buf,1,24,8));
% outdata_src = y2*0.332451909263490;
% outdata_0_0 = y1;
% outdata_0_1 = y0;
%---------------------- ctr counter
if ctr == uint8(200)
	ctr = uint8(1);
else
	ctr = ctr + 1;
end
end
