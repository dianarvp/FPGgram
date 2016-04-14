module reverse_mask(input clk,
		    input logic[8:0][16:0] kernel,
		    output logic[8:0][16:0] reversed);

always_comb begin
    reversed[0] = kernel[8];
    reversed[1] = kernel[7];
    reversed[2] = kernel[6];
    reversed[3] = kernel[5];
    reversed[4] = kernel[4];
    reversed[5] = kernel[3];
    reversed[6] = kernel[2];
    reversed[7] = kernel[1];
    reversed[8] = kernel[0];
end
endmodule
