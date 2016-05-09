module avg_pool(pixels_in, pixels_out, sub_block);

parameter WIDTH_IN = 8;
parameter WIDTH_OUT = 4;

input[(WIDTH_IN*WIDTH_IN - 1):0][31:0] pixels_in;
input [1:0] sub_block;
output[(WIDTH_IN*WIDTH_IN - 1):0][31:0] pixels_out;

logic [WIDTH_OUT*WIDTH_OUT-1:0][31:0] pooled_pix;
genvar i,j;
generate for (i = 0; i < WIDTH_OUT; i++) begin: for_i
	for (j = 0; j < WIDTH_OUT; j++) begin: for_j
		assign pooled_pix[(i + j*WIDTH_OUT)] = pixels_in[(i*2 + j*2*WIDTH_IN)] / 4
														 + pixels_in[(i*2 + j*2*WIDTH_IN + 1)] / 4
														 + pixels_in[(i*2 + j*2*WIDTH_IN + WIDTH_IN)] / 4
														 + pixels_in[(i*2 + j*2*WIDTH_IN + WIDTH_IN + 1)] / 4;
	end
end
endgenerate

always_comb begin
	for (int i = 0; i < WIDTH_OUT*WIDTH_OUT; i++) pixels_out[i] = 0;
	if (sub_block == 0) begin
		pixels_out[0*WIDTH_IN + WIDTH_OUT-1:0*WIDTH_IN] = pooled_pix[3:0];
		pixels_out[1*WIDTH_IN + WIDTH_OUT-1:1*WIDTH_IN] = pooled_pix[7:4];
		pixels_out[2*WIDTH_IN + WIDTH_OUT-1:2*WIDTH_IN] = pooled_pix[11:8];
		pixels_out[3*WIDTH_IN + WIDTH_OUT-1:3*WIDTH_IN] = pooled_pix[15:12];
	end if (sub_block == 1) begin
		pixels_out[0*WIDTH_IN + WIDTH_OUT + 3:0*WIDTH_IN + 4] = pooled_pix[3:0];
		pixels_out[1*WIDTH_IN + WIDTH_OUT + 3:1*WIDTH_IN + 4] = pooled_pix[7:4];
		pixels_out[2*WIDTH_IN + WIDTH_OUT + 3:2*WIDTH_IN + 4] = pooled_pix[11:8];
		pixels_out[3*WIDTH_IN + WIDTH_OUT + 3:3*WIDTH_IN + 4] = pooled_pix[15:12];
	end if (sub_block == 2) begin
		pixels_out[4*WIDTH_IN + WIDTH_OUT-1:0*WIDTH_IN] = pooled_pix[3:0];
		pixels_out[5*WIDTH_IN + WIDTH_OUT-1:1*WIDTH_IN] = pooled_pix[7:4];
		pixels_out[6*WIDTH_IN + WIDTH_OUT-1:2*WIDTH_IN] = pooled_pix[11:8];
		pixels_out[7*WIDTH_IN + WIDTH_OUT-1:3*WIDTH_IN] = pooled_pix[15:12];
	end if (sub_block == 3) begin
		pixels_out[4*WIDTH_IN + WIDTH_OUT + 3:0*WIDTH_IN + 4] = pooled_pix[3:0];
		pixels_out[5*WIDTH_IN + WIDTH_OUT + 3:1*WIDTH_IN + 4] = pooled_pix[7:4];
		pixels_out[6*WIDTH_IN + WIDTH_OUT + 3:2*WIDTH_IN + 4] = pooled_pix[11:8];
		pixels_out[7*WIDTH_IN + WIDTH_OUT + 3:3*WIDTH_IN + 4] = pooled_pix[15:12];
	end
end


endmodule
