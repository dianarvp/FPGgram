module difference(
	in1,
	in2,
	out);

parameter SIZE = 64;

input [(SIZE-1):0][31:0] in1;
input [(SIZE-1):0][31:0] in2;
output [(SIZE-1):0][31:0] out;

genvar i;
generate for (i = 0; i < SIZE; i++) begin : for_i
	assign out[i] = in1[i] - in2[i];
end
endgenerate

endmodule
