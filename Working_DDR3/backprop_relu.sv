module backprop_relu(
	derivative_in,
	pixels,
	derivative_out);

parameter SIZE = 64;

input[(SIZE - 1):0][31:0] derivative_in;
input[(SIZE - 1):0][31:0] pixels;
output[(SIZE - 1):0][31:0] derivative_out;

genvar i;
generate for (i = 0; i < SIZE; i++) begin : for_i
	assign derivative_out[i] = (pixels[i] < 0)? 0 : derivative_in[i];
end
endgenerate

endmodule
