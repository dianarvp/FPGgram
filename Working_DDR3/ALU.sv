// ALU (mux between stuff)
module ALU (
	input iCLK,
	READ_BUFFER.ALU in_block1,
	READ_BUFFER.ALU in_block2,
	MASK_BUFFER.ALU mask,
	WRITE_BACK.ALU out_block,
	ALU_i.ALU from_top
);

//Instantiate arithmetic modules
reg [63:0][31:0] ap_in;
reg [15:0][31:0] ap_out;
avg_pool av (
	.pixels_in (ap_in),
	.pixels_out (ap_out));

reg [63:0][31:0] bcl_content_pixels;
reg [63:0][31:0] bcl_generated_pixels;
reg [63:0][31:0] bcl_derivative_out;
backprop_content_loss bcl (
	.content_pixels (bcl_content_pixels),
	.generated_pixels (bcl_generated_pixels),
	.derivative_out (bcl_derivative_out));

reg [15:0][31:0] bp_in;
reg [63:0][31:0] bp_out;
backprop_pool bp (
	.derivative_in (bp_in),
	.derivative_out (bp_out));

reg [63:0][31:0] br_derivative_in;
reg [63:0][31:0] br_pixels;
reg [63:0][31:0] br_derivative_out;
backprop_relu br (
	.derivative_in (br_derivative_in),
	.pixels (br_pixels),
	.derivative_out (br_derivative_out));
	
reg [63:0][31:0] cl_content_pixels;
reg [63:0][31:0] cl_generated_pixels;
reg [63:0][31:0] cl_loss_out;
content_loss cl (
	.content_pixels (cl_content_pixels),
	.generated_pixels (cl_generated_pixels),
	.loss_out (cl_loss_out));

reg [99:0][31:0] convo_in;
reg [8:0][31:0] convo_mask;
reg [31:0] convo_bias;
reg [63:0][31:0] convo_out;
convolution convo( 
	.pixels_in (convo_in),
	.mask (convo_mask),
	.bias (convo_bias),
	.pixels_out (convo_out));

reg [63:0][31:0] r_pixels_in;
reg [63:0][31:0] r_pixels_out;
relu r (
	.pixels_in (r_pixels_in),
	.pixels_out (r_pixels_out));

reg [8:0][31:0] rm_kernel;
reg [8:0][31:0] rm_reversed;
reverse_mask rm (
	.kernel (rm_kernel),
	.reversed (rm_reversed));

reg[3:0] state <= ;
// 0: idle
// 1: convolution
// 2: pool
// 3: rev pool
// 4: subtraction
// 5: dot product
always @(posedge iCLK)
begin
	case (state)
	 0 : begin
			if 
end
endmodule
