module avg_pool(
	input logic clk,
	input reg[1023:0][15:0] pixels_in,
	output logic[255:0][15:0] pixels_out);

genvar i,j;

generate for (i = 0; i < 16; i++) begin: for_i
    generate for (j = 0; j < 16; j++) begin: for_j
        wire[15:0] index_in, index_out;
        assign index_in = i*2 + j*2*32;
	assign index_out = i + j*16;
	assign pixel_out[index_out] = pixels_in[(index_in)] / 4 + pixels_in[index_in + 1] / 4
				    + pixels_in[index_in + 32] / 4 + pixels_in[index_in + 33] / 4;
    end
    endgenerate
end
endgenerate

endmodule 
