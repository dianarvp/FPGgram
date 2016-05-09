module backprop_pool(
	derivative_in,
	derivative_out,
	sub_block);

parameter WIDTH_IN = 4;
parameter WIDTH_OUT = WIDTH_IN * 2;

input[(WIDTH_IN*WIDTH_IN - 1):0][31:0] derivative_in;
input [1:0] sub_block;
output[(WIDTH_OUT*WIDTH_OUT - 1):0][31:0] derivative_out;

integer i, j;
always_comb begin
	for (i = 0; i < WIDTH_OUT*WIDTH_OUT; i++) derivative_out[i] = 0;
	case (sub_block)
		0 : begin
			for (i = 0; i < WIDTH_IN; i++) begin: for_i
				for (j = 0; j < WIDTH_IN; j++) begin: for_j
					derivative_out[i*2 + j*2*WIDTH_OUT] = derivative_in[(i + j*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + 1] = derivative_in[(i + j*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT] = derivative_in[(i + j*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT + 1] = derivative_in[(i + j*WIDTH_OUT)] / 4;
				end
			end
		end
		1 : begin
			for (i = 0; i < WIDTH_IN; i++) begin: for_i
				for (j = 0; j < WIDTH_IN; j++) begin: for_j
					derivative_out[i*2 + j*2*WIDTH_OUT] = derivative_in[(i+WIDTH_IN + j*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + 1] = derivative_in[(i+WIDTH_IN + j*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT] = derivative_in[(i+WIDTH_IN + j*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT + 1] = derivative_in[(i+WIDTH_IN+ j*WIDTH_OUT)] / 4;
				end
			end
		end
		2 : begin
			for (i = 0; i < WIDTH_IN; i++) begin: for_i
				for (j = 0; j < WIDTH_IN; j++) begin: for_j
					derivative_out[i*2 + j*2*WIDTH_OUT] = derivative_in[(i + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + 1] = derivative_in[(i + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT] = derivative_in[(i + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT + 1] = derivative_in[(i + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
				end
			end
		end
		3 : begin
			for (i = 0; i < WIDTH_IN; i++) begin: for_i
				for (j = 0; j < WIDTH_IN; j++) begin: for_j
					derivative_out[i*2 + j*2*WIDTH_OUT] = derivative_in[(i + WIDTH_IN + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + 1] = derivative_in[(i + WIDTH_IN + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT] = derivative_in[(i + WIDTH_IN + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
					derivative_out[i*2 + j*2*WIDTH_OUT + WIDTH_OUT + 1] = derivative_in[(i + WIDTH_IN + (j+WIDTH_IN)*WIDTH_OUT)] / 4;
				end
			end
		end
	endcase
end
endmodule
