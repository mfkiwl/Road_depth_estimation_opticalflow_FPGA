%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                          %
%           Generated by MATLAB 9.7 and Fixed-Point Designer 6.4           %
%                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [data_out_0,data_out_1,data_out_2] = PolyExp_pipeline2_wrapper_fixpt(indata_0,indata_1,indata_2,indata_3,indata_4,indata_5,indata_6,indata_7,indata_8,indata_9,indata_10,indata_11,indata_12,indata_13,indata_14,indata_15,int0,int1,int2)
    fm = get_fimath();
    indata_0_in = fi( indata_0, 0, 8, 0, fm );
    indata_1_in = fi( indata_1, 0, 8, 0, fm );
    indata_2_in = fi( indata_2, 0, 8, 0, fm );
    indata_3_in = fi( indata_3, 0, 8, 0, fm );
    indata_4_in = fi( indata_4, 0, 8, 0, fm );
    indata_5_in = fi( indata_5, 0, 8, 0, fm );
    indata_6_in = fi( indata_6, 0, 8, 0, fm );
    indata_7_in = fi( indata_7, 0, 8, 0, fm );
    indata_8_in = fi( indata_8, 0, 8, 0, fm );
    indata_9_in = fi( indata_9, 0, 8, 0, fm );
    indata_10_in = fi( indata_10, 0, 8, 0, fm );
    indata_11_in = fi( indata_11, 0, 8, 0, fm );
    indata_12_in = fi( indata_12, 0, 8, 0, fm );
    indata_13_in = fi( indata_13, 0, 8, 0, fm );
    indata_14_in = fi( indata_14, 0, 8, 0, fm );
    indata_15_in = fi( indata_15, 0, 8, 0, fm );
    int0_in = fi( int0, 0, 14, 7, fm );
    int1_in = fi( int1, 0, 14, 0, fm );
    int2_in = fi( int2, 0, 14, 0, fm );
    [data_out_0_out,data_out_1_out,data_out_2_out] = PolyExp_pipeline2_fixpt( indata_0_in, indata_1_in, indata_2_in, indata_3_in, indata_4_in, indata_5_in, indata_6_in, indata_7_in, indata_8_in, indata_9_in, indata_10_in, indata_11_in, indata_12_in, indata_13_in, indata_14_in, indata_15_in, int0_in, int1_in, int2_in );
    data_out_0 = double( data_out_0_out );
    data_out_1 = double( data_out_1_out );
    data_out_2 = double( data_out_2_out );
end

function fm = get_fimath()
	fm = fimath('RoundingMethod', 'Floor',...
	     'OverflowAction', 'Wrap',...
	     'ProductMode','FullPrecision',...
	     'MaxProductWordLength', 128,...
	     'SumMode','FullPrecision',...
	     'MaxSumWordLength', 128);
end
