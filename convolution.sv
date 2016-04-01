module convolution( 
input logic clk,
input reg[54:0][32:0] pixels_in,
input reg[9:0][8:0] mask,
input logic[32:0] bias,
output logic[16:0][32:0] pixels_out);
 
logic [16:0][32:0] pix_out;

genvar i;

generate for (i = 1; i < 17; i++) begin: for_i
		conv con(.clk (clk),
				.in  ({pixels_in[(i+2):(i-1)], pixels_in[(i+20):(i+17)],pixels_in[(i+38):(i+35)]}),
				.kernel (mask),
				.out (pix_out[i-1]));
		assign pixels_out[i-1] = ((pix_out[i-1] - bias) < 0 )? 0 : (pix_out[i-1] - bias);
  end
endgenerate


endmodule 