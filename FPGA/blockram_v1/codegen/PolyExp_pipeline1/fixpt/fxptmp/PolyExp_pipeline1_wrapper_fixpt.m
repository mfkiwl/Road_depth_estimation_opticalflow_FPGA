%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                          %
%           Generated by MATLAB 9.7 and Fixed-Point Designer 6.4           %
%                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function outdata = PolyExp_pipeline1_wrapper_fixpt(indatasrc)
    fm = get_fimath();
    indatasrc_in = fi( indatasrc, 0, 8, 0, fm );
    [outdata_out] = PolyExp_pipeline1_fixpt( indatasrc_in );
    outdata = double( outdata_out );
end

function fm = get_fimath()
	fm = fimath('RoundingMethod', 'Floor',...
	     'OverflowAction', 'Wrap',...
	     'ProductMode','FullPrecision',...
	     'MaxProductWordLength', 128,...
	     'SumMode','FullPrecision',...
	     'MaxSumWordLength', 128);
end