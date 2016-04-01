module avg_pool(
	input logic clk,
	input reg[32:0][54:0] pixels_in,
	input logic size,
	output logic[32:0][16:0] pixel_out);

logic [32:0][9:0] pix_buff;
logic[32:0][16:0] pix_out;

reg[8:0][9:0] mask1 = {{8'b1},{8'b1},{8'b1},{8'b1},{8'b1},{8'b1},{8'b1},{8'b1},{8'b1}};
reg[8:0][9:0] mask2 = {{8'b0},{8'b0},{8'b0},{8'b0},{8'b1},{8'b1},{8'b0},{8'b1},{8'b1}};
logic[8:0][9:0] mask_in;
genvar i;

generate begin
  for (i = 1; i < 17; i++) begin: for_i
		assign mask_in = size ? mask1 : mask2;
		conv con (.clk (clk),
				.in  ({pixels_in[(i+2):(i-1)], pixels_in[(i+20):(i+17)],pixels_in[(i+38):(i+35)]}),
				.kernel (mask_in),
				.out (pix_out[i-1]));
		assign pixel_out[i-1] = size ? pix_out[i-1]/9 : pix_out[i-1]/4;
  end
  end
endgenerate

endmodule 
