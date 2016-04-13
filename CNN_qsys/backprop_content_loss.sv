module backprop_content_loss(input clk,
            input reg[1023:0][15:0] content_pixels,
            input reg[1023:0][15:0] generated_pixels,
	    output logic[1023:0][15:0] derivative_out);

    genvar i;
    generate for (i = 0; i < 1024; i++) begin : for_i
	derivative_out[i] = content_pixels[i] - generated_pixels[i];
    end
    endgenerate

endmodule
