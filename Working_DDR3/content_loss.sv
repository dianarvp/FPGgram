module content_loss(
	content_pixels,
	generated_pixels,
	loss_out);

parameter SIZE = 64;

input [(SIZE-1):0][15:0] content_pixels;
input [(SIZE-1):0][15:0] generated_pixels;
output [15:0] loss_out;

logic[63:0][15:0] distance_squared;
genvar i;
generate for (i = 0; i < SIZE; i++) begin : for_i
	assign distance_squared[i] = (content_pixels[i] - generated_pixels[i])*(content_pixels[i] - generated_pixels[i]) << 16;
end
endgenerate

integer s;
reg [15:0] sum;
always
	begin
	for (s = 0; s< SIZE; s++) begin : for_s
		sum += distance_squared[s];
	end
	end
	
assign loss_out = sum;
endmodule
