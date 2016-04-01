module conv(input clk,
				input logic[9:0][32:0] in,
				input logic[9:0][8:0] kernel,
				output int out);

				
always_comb begin
	out <= in[0] * kernel[0] + in[1] * kernel[1]
			+ in[2] * kernel[2] + in[3] * kernel[3]
			+ in[4] * kernel[4] + in[5] * kernel[5]
			+ in[6] * kernel[6] + in[7] * kernel[7]
			+ in[8] * kernel[8];
end

endmodule
