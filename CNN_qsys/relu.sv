module relu(input clk,
	    input reg[1023:0][15:0] pixels_in,
	    output logic[1023:0][15:0] pixels_out);

    genvar i;
    generate for (i = 0; i < 1024; i++) begin : for_i
	assign pixels_out[i] = (pixels_in[i] < 0)? 0 : pixels_in[i];
    end
    endgenerate

endmodule
