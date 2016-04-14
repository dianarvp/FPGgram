module backprop_pool(
	input logic clk,
	input reg[255:0][15:0] derivative_in,
	output logic[1023:0][15:0] derivative_out);

genvar i,j;

generate for (i = 0; i < 16; i++) begin: for_i
    generate for (j = 0; j < 16; j++) begin: for_j
        wire[15:0] index_in, index_out;
        assign index_in = i + j*16;
	assign index_out = i*2 + j*2*32;
	assign derivative_out[index_out] = derivative_in[(index_in)] / 4;
	assign derivative_out[index_out + 1] = derivative_in[(index_in)] / 4;
	assign derivative_out[index_out + 32] = derivative_in[(index_in)] / 4;
	assign derivative_out[index_out + 33] = derivative_in[(index_in)] / 4;
    end
    endgenerate
end
endgenerate

endmodule 
