function [outdata0,outdata1,outdata2,outdata3,outdata4] = UpdateMatrices_pipeline4(r2,r3,r4,r5,r6)
													  
outdata0 = r4*r4 + r6*r6;
outdata1 = (r4 + r5) *r6; 
outdata2 = r5*r5 + r6*r6;
outdata3 = r4*r2 + r6*r3;
outdata4 = r6*r2 + r5*r3;

end
