module backprop_relu(input clk,
	    input reg[1023:0][15:0] derivative_in,
            input reg[1023:0][15:0] pixels,
	    output logic[1023:0][15:0] derivate_out);

    genvar i;
    generate for (i = 0; i < 1024; i++) begin : for_i
	assign derivative_out[i] = (pixels[i] < 0)? 0 : derivative_in[i];
    end
    endgenerate

endmodule
