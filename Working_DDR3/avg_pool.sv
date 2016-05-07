module avg_pool(pixels_in, pixels_out);

parameter WIDTH_IN = 8;
parameter WIDTH_OUT = WIDTH_IN/2;

input[(WIDTH_IN*WIDTH_IN - 1):0][31:0] pixels_in;
output[(WIDTH_OUT*WIDTH_OUT - 1):0][31:0] pixels_out;

genvar i,j;
generate for (i = 0; i < WIDTH_OUT; i++) begin: for_i
	for (j = 0; j < WIDTH_OUT; j++) begin: for_j
		assign pixels_out[(i + j*WIDTH_OUT)] = pixels_in[(i*2 + j*2*WIDTH_IN)] / 4
														 + pixels_in[(i*2 + j*2*WIDTH_IN + 1)] / 4
														 + pixels_in[(i*2 + j*2*WIDTH_IN + WIDTH_IN)] / 4
														 + pixels_in[(i*2 + j*2*WIDTH_IN + WIDTH_IN + 1)] / 4;
	end
end
endgenerate

endmodule 
