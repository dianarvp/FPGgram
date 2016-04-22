module convolution( 
input logic clk,
input reg[99:0][15:0] pixels_in,
input reg [8:0] [15:0] mask,
input logic[15:0] bias,
output logic[63:0][15:0] pixels_out);
 
logic [63:0][15:0] pix_out;

genvar i,j;

generate for (i = 1; i < 9; i++) begin: for_i
		for (j = 1; j < 9; j++) begin: for_j
		conv con(.clk (clk),
				.in  ({pixels_in[((i + (j*10))-9):((i + (j*10))-11)], 
							pixels_in[((i + (j*6))+1):((i + (j*6))-1)],
							pixels_in[((i + (j*6))+11):((i + (j*6))+9)]}),
				.kernel (mask),
				.out (pix_out[((i-1)*8) + (j-1)]));
		assign pixels_out[((i-1)*8) + (j-1)] = pix_out[((i-1)*8) + (j-1)] - bias;
		end
end
endgenerate


endmodule 
