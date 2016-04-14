module convolution( 
input logic clk,
input reg[35:0][15:0] pixels_in,
input reg [8:0] [15:0] mask,
input logic[15:0] bias,
output logic[15:0][15:0] pixels_out);
 
logic [15:0][15:0] pix_out;

genvar i,j;

generate for (i = 1; i < 5; i++) begin: for_i
		for (j = 1; j < 5; j++) begin: for_j
		conv con(.clk (clk),
				.in  ({pixels_in[((i + (j*6))-5):((i + (j*6))-7)], 
							pixels_in[((i + (j*6))+1):((i + (j*6))-1)],
							pixels_in[((i + (j*6))+7):((i + (j*6))+5)]}),
				.kernel (mask),
				.out (pix_out[((i-1)*4) + (j-1)]));
		assign pixels_out[((i-1)*4) + (j-1)] = pix_out[((i-1)*4) + (j-1)] - bias;
		end
end
endgenerate


endmodule 
