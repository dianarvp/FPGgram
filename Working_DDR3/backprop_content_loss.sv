module backprop_content_loss(
	content_pixels,
	generated_pixels,
	derivative_out);

parameter SIZE = 64;

input [(SIZE-1):0][15:0] content_pixels;
input [(SIZE-1):0][15:0] generated_pixels;
output [(SIZE-1):0][15:0] derivative_out;

genvar i;
generate for (i = 0; i < SIZE; i++) begin : for_i
	assign derivative_out[i] = content_pixels[i] - generated_pixels[i];
end
endgenerate

endmodule
