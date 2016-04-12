module NET_Controller(input logic clk,
			input logic reset,
			input logic [15:0] pixel,
			input logic [31:0] address,
			input logic [15:0] instruction,
			output logic ready);

reg[35:0][15:0] pixel_conv;
reg[1023:0][15:0] pixel_avg;

convolution conv_unit();
avg_pool pool_unit();


always_ff @(posedge clk) begin
	if (reset) begin
	end 
	else begin
		case (instruction[3:1])
			2'b001: begin //convolution
			end
			2'b010: begin //avg_pool
			end
			2'b100: begin //backprop
			end
	end
end
endmodule
