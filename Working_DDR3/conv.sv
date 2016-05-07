module conv(
	input logic[8:0][15:0] in,
	input logic[8:0][15:0] kernel,
	input wire back,
	output int out);

				
assign out = in[0] * kernel[0] << 16 + in[1] * kernel[1] << 16 + in[2] * kernel[2] << 16
			  + in[3] * kernel[3] << 16 + in[4] * kernel[4] << 16 + in[5] * kernel[5] << 16
			  + in[6] * kernel[6] + in[7] << 16 * kernel[7] << 16 + in[8] * kernel[8] << 16;

endmodule
