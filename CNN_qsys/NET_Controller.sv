module NET_Controller(input logic clk,
			input logic reset,
			input logic [15:0] pixel,
			input logic [31:0] address,
			input logic [15:0] instruction,
			output logic ready,
			output logic[63:0][15:0] pixels_out);

reg[50175:0][15:0] image_buff;

reg[8:0][15:0] mask = {16'd1, 16'd0, 16'd1,
			16'd1, 16'd0, 16'd1,
			16'd1, 16'd0, 16'd1};
logic [15:0] bias = 16'd1;
reg[99:0][15:0] pixel_conv;
reg[1023:0][15:0] pixel_avg;
logic i, j;

convolution conv_unit(.clk(clk),
			.pixels_in (pixel_conv),
			.mask (mask),
			.bias(bias),
			.pixels_out({pixels_out));

avg_pool pool_unit();


always_ff @(posedge clk) begin
	if (reset) begin
	end 
	else begin
		if (instruction[0]) begin 
			
		case (instruction[3:1])
			2'b001: begin //convolution
				initial begin
				for (i = 0; i < 8'd216; i = i + 8) begin
					for (j = 0; j < 8'd216; j = j+ 8) begin
						pixel_conv[9:0] <= {16'd0, 16'd0, 16'd0, 16'd0, 16'd0,
								16'd0, 16'd0, 16'd0, 16'd0, 16'd0};
						pixel_conv[19:10] <= {16'd0, image_buff[j+(i*224)],
								image_buff[(j+1)+(i*224)], image_buff[(j+2)+(i*224)],
								image_buff[(j+3)+(i*224)], image_buff[(j+4)+(i*224)],
								image_buff[(j+5)+(i*224)], image_buff[(j+6)+(i*224)],
								image_buff[(j+7)+(i*224)], 16'd0};
						pixel_conv[29:20] <= {16'd0, image_buff[j+((i+1)*224)],
								image_buff[(j+1)+((i+1)*224)], image_buff[(j+2)+((i+1)*224)],
								image_buff[(j+3)+((i+1)*224)], image_buff[(j+4)+((i+1)*224)],
								image_buff[(j+5)+((i+1)*224)], image_buff[(j+6)+((i+1)*224)],
								image_buff[(j+7)+((i+1)*224)], 16'd0};
						pixel_conv[39:30] <= {16'd0, image_buff[j+((i+2)*224)],
								image_buff[(j+1)+((i+2)*224)], image_buff[(j+2)+((i+2)*224)],
								image_buff[(j+3)+((i+2)*224)], image_buff[(j+4)+((i+2)*224)],
								image_buff[(j+5)+((i+2)*224)], image_buff[(j+6)+((i+2)*224)],
								image_buff[(j+7)+((i+2)*224)], 16'd0};
						pixel_conv[49:40] <= {16'd0, image_buff[j+((i+3)*224)],
								image_buff[(j+1)+((i+3)*224)], image_buff[(j+2)+((i+3)*224)],
								image_buff[(j+3)+((i+3)*224)], image_buff[(j+4)+((i+3)*224)],
								image_buff[(j+5)+((i+3)*224)], image_buff[(j+6)+((i+3)*224)],
								image_buff[(j+7)+((i+3)*224)], 16'd0};
						pixel_conv[59:50] <= {16'd0, image_buff[j+((i+4)*224)],
								image_buff[(j+1)+((i+4)*224)], image_buff[(j+2)+((i+4)*224)],
								image_buff[(j+3)+((i+4)*224)], image_buff[(j+4)+((i+4)*224)],
								image_buff[(j+5)+((i+4)*224)], image_buff[(j+6)+((i+4)*224)],
								image_buff[(j+7)+((i+4)*224)], 16'd0};
						pixel_conv[69:60] <= {16'd0, image_buff[j+((i+5)*224)],
								image_buff[(j+1)+((i+5)*224)], image_buff[(j+2)+((i+5)*224)],
								image_buff[(j+3)+((i+5)*224)], image_buff[(j+4)+((i+5)*224)],
								image_buff[(j+5)+((i+5)*224)], image_buff[(j+6)+((i+5)*224)],
								image_buff[(j+7)+((i+5)*224)], 16'd0};
						pixel_conv[79:70] <= {16'd0, image_buff[j+((i+6)*224)],
								image_buff[(j+1)+((i+6)*224)], image_buff[(j+2)+((i+6)*224)],
								image_buff[(j+3)+((i+6)*224)], image_buff[(j+4)+((i+6)*224)],
								image_buff[(j+5)+((i+6)*224)], image_buff[(j+6)+((i+6)*224)],
								image_buff[(j+7)+((i+6)*224)], 16'd0};
						pixel_conv[89:80] <= {16'd0, image_buff[j+((i+7)*224)],
								image_buff[(j+1)+((i+7)*224)], image_buff[(j+2)+((i+7)*224)],
								image_buff[(j+3)+((i+7)*224)], image_buff[(j+4)+((i+7)*224)],
								image_buff[(j+5)+((i+7)*224)], image_buff[(j+6)+((i+7)*224)],
								image_buff[(j+7)+((i+7)*224)], 16'd0};
						pixel_conv[99:90] <= {16'd0, 16'd0, 16'd0, 16'd0, 16'd0,
								16'd0, 16'd0, 16'd0, 16'd0, 16'd0};
					end
				end
			end
			2'b010: begin //avg_pool
			end
			2'b100: begin //backprop
			end
	end
end
endmodule
