function [r2,r3,r4,r5,r6] = UpdateMatrices_pipeline3(R0_data_0,R0_data_1,r2,r3,r4,r5,r6,dx,dy)

r2 = (R0_data_0 - r2)*0.5;
r3 = (R0_data_1 - r3)*0.5;
r2 = r2 + r4*dy + r6*dx;
r3 = r3 + r6*dy + r5*dx;

end
