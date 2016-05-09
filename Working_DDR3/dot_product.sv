module dot_product(
	out_index,
	in1,
	in2,
	out);

parameter SIZE = 64;

input [10:0] out_index;
input [(SIZE-1):0][31:0] in1;
input [(SIZE-1):0][31:0] in2;
output [31:0] out;

logic[63:0][31:0] prod;
genvar i;
generate for (i = 0; i < SIZE; i++) begin : for_i
	assign prod[i] = in1[i]*in2[i] << 16;
end
endgenerate

integer s;
reg [15:0] sum;
always
	begin
	for (s = 0; s< SIZE; s++) begin : for_s
		sum += prod[s];
	end
	end
	
assign out = sum;
endmodule
