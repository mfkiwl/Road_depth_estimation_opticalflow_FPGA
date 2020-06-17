function outdata = blockram(indata)
width  = 200;
%---------------------- Initial blockram 
persistent row ctr;
if isempty(row)
	% p = fi([],1,24,0);
	% row = zeros(1,width,'like',p);
	row = zeros(1,width);
	ctr = uint8(1);
end
%---------------------- write BRAM
row(ctr) = indata;
%---------------------- read
outdata = row(ctr);
%---------------------- ctr counter
if ctr == uint8(200)
	ctr = uint8(1);
else
	ctr = ctr + 1;
end

end