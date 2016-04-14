module backprop_pool(
	derivative_in,
	derivative_out);

parameter WIDTH_IN = 4;
parameter WIDTH_OUT = WIDTH_IN * 2;

input[(WIDTH_IN*WIDTH_IN - 1):0][15:0] derivative_in;
output[(WIDTH_OUT*WIDTH_OUT - 1):0][15:0] derivative_out;

genvar i,j;
generate for (i = 0; i < WIDTH_IN; i++) begin: for_i
	for (j = 0; j < WIDTH_IN; j++) begin: for_j
		assign derivative_out[i*2 + j*2*WIDTH_OUT] = derivative_in[(i + j*WIDTH_IN)] / 4;
		assign derivative_out[i*2 + j*2*WIDTH_OUT + 1] = derivative_in[(i + j*WIDTH_IN)] / 4;
		assign derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT] = derivative_in[(i + j*WIDTH_IN)] / 4;
		assign derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT + 1] = derivative_in[(i + j*WIDTH_IN)] / 4;
	end
end
endgenerate

endmodule 
