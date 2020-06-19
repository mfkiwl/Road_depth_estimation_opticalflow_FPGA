%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                          %
%           Generated by MATLAB 9.7 and Fixed-Point Designer 6.4           %
%                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%#codegen
function [data_out_0,data_out_1,data_out_2] = PolyExp_pipeline1_fixpt(indata_src)

fm = get_fimath();

data_out_0 = fi(indata_src*fi(0.332451909263490, 0, 14, 15, fm), 0, 14, 7, fm);
data_out_1 = fi(0.0, 0, 14, 0, fm);
data_out_2 = fi(0.0, 0, 14, 0, fm);

end


function fm = get_fimath()
	fm = fimath('RoundingMethod', 'Floor',...
	     'OverflowAction', 'Wrap',...
	     'ProductMode','FullPrecision',...
	     'MaxProductWordLength', 128,...
	     'SumMode','FullPrecision',...
	     'MaxSumWordLength', 128);
end