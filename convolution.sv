module convolution( 
input logic clk,
input reg[1023:0][15:0] pixels_in,
input reg[8:0][15:0] mask,
input logic[15:0] bias,
output logic[899:0][15:0] pixels_out);

logic [899:0][15:0] pix_out;

genvar i, j;
generate for (i = 1; i < 31; i++) begin: for_i
    generate for (j = 1; j < 31; j++) begin: for_j
        wire[15:0] index;
	assign index = i + j*32; 

	conv con(.clk (clk),
	    .in  ({pixels_in[(index-33):(index-31)],
		   pixels_in[(index-1):(index+1)],
		   pixels_in[(index+31):(index+33)]}),
	    .kernel (mask),
	    .out (pix_out[index]));
	assign pixels_out[index] = pix_out[index] + bias;

    end
    endgenerate
end
endgenerate


endmodule 
