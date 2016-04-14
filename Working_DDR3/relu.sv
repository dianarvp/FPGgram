module relu(pixels_in, pixels_out);

parameter SIZE = 64;

input[(SIZE - 1):0] pixels_in;
output[(SIZE - 1):0] pixels_out;

genvar i;
generate for (i = 0; i < SIZE; i++) begin : for_i
	assign pixels_out[i] = (pixels_in[i] < 0)? 0 : pixels_in[i];
end
endgenerate

endmodule
