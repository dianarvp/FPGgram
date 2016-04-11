module NET_Controller(input logic clk,
							 input logic reset,
							input logic [15:0] pixel,
							input logic [31:0] address,
							input logic [15:0] instruction,
							output logic ready);



always_ff @(posedge clk) begin
	if (reset) begin
	end 
	else 
		