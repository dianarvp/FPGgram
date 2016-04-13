module content_loss(input clk,
            input reg[63:0][15:0] content_pixels,
            input reg[63:0][15:0] generated_pixels,
	    output logic[15:0] loss_out);

    logic[63:0][15:0] distance_squared;
    genvar i;
    generate for (i = 0; i < 64; i++) begin : for_i
	distance_squared[i] = (content_pixels[i] - generated_pixels[i])*(content_pixels[i] - generated_pixels[i]));
    end
    endgenerate

    assign loss_out = sum(distance_squared)/2;
endmodule
