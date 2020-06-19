%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                          %
%           Generated by MATLAB 9.7 and Fixed-Point Designer 6.4           %
%                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [M_1,M_2,M_3,M_4,M_5] = UpdateMatrices_pipeline1_wrapper_fixpt(R0_data_1,R0_data_2,R0_data_3,R0_data_4,R0_data_5,R1_data_1,R1_data_2,R1_data_3,R1_data_4,R1_data_5,h_cnt,v_cnt)
    fm = get_fimath();
    R0_data_1_in = fi( R0_data_1, 1, 14, 7, fm );
    R0_data_2_in = fi( R0_data_2, 1, 14, 6, fm );
    R0_data_3_in = fi( R0_data_3, 1, 14, 8, fm );
    R0_data_4_in = fi( R0_data_4, 1, 14, 8, fm );
    R0_data_5_in = fi( R0_data_5, 1, 14, 7, fm );
    R1_data_1_in = fi( R1_data_1, 1, 14, 7, fm );
    R1_data_2_in = fi( R1_data_2, 1, 14, 6, fm );
    R1_data_3_in = fi( R1_data_3, 1, 14, 8, fm );
    R1_data_4_in = fi( R1_data_4, 1, 14, 8, fm );
    R1_data_5_in = fi( R1_data_5, 1, 14, 7, fm );
    h_cnt_in = fi( h_cnt, 0, 8, 0, fm );
    v_cnt_in = fi( v_cnt, 0, 8, 0, fm );
    [M_1_out,M_2_out,M_3_out,M_4_out,M_5_out] = UpdateMatrices_pipeline1_fixpt( R0_data_1_in, R0_data_2_in, R0_data_3_in, R0_data_4_in, R0_data_5_in, R1_data_1_in, R1_data_2_in, R1_data_3_in, R1_data_4_in, R1_data_5_in, h_cnt_in, v_cnt_in );
    M_1 = double( M_1_out );
    M_2 = double( M_2_out );
    M_3 = double( M_3_out );
    M_4 = double( M_4_out );
    M_5 = double( M_5_out );
end

function fm = get_fimath()
	fm = fimath('RoundingMethod', 'Floor',...
	     'OverflowAction', 'Wrap',...
	     'ProductMode','FullPrecision',...
	     'MaxProductWordLength', 128,...
	     'SumMode','FullPrecision',...
	     'MaxSumWordLength', 128);
end