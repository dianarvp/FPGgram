module convolution( 
	pixels_in,
	mask,
	bias,
	pixels_out);


parameter WIDTH_IN = 10;
parameter WIDTH_OUT = WIDTH_IN - 2;


input [(WIDTH_IN * WIDTH_IN - 1):0] pixels_in;
input [8:0][15:0] mask;
input [15:0] bias;
output [(WIDTH_OUT * WIDTH_OUT - 1):0] pixels_out;


logic [(WIDTH_OUT * WIDTH_OUT - 1):0][15:0] pix_out;
genvar i,j;
generate for (i = 1; i < (WIDTH_IN - 1); i++) begin: for_i
	for (j = 1; j < (WIDTH_IN - 1); j++) begin: for_j
		conv con(
			.in  ({pixels_in[((i + (j*WIDTH_IN))-(WIDTH_IN - 1)):((i + (j*WIDTH_IN))-(WIDTH_IN + 1))], 
					 pixels_in[((i + (j*WIDTH_IN))+ 1):((i + (j*WIDTH_IN))-1)],
					 pixels_in[((i + (j*WIDTH_IN))+(WIDTH_IN + 1)):((i + (j*WIDTH_IN))+(WIDTH_IN - 1))]}),
			.kernel (mask),
			.out (pix_out[(i-1)+(j-1)*WIDTH_OUT]));
		assign pixels_out[(i-1)+(j-1)*WIDTH_OUT] = pix_out[(i-1)+(j-1)*WIDTH_OUT] - bias;
	end
end
endgenerate


endmodule