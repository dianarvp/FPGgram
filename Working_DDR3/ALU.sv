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
	.pixels_out (ap_out),
	.sub_block (ALU_i.sub_block)
);

reg [63:0][31:0] bcl_content_pixels;
reg [63:0][31:0] bcl_generated_pixels;
reg [63:0][31:0] bcl_derivative_out;
backprop_content_loss bcl (
	.content_pixels (bcl_content_pixels),
	.generated_pixels (bcl_generated_pixels),
	.derivative_out (bcl_derivative_out));

reg [63:0][31:0] bp_in;
reg [63:0][31:0] bp_out;
backprop_pool bp (
	.derivative_in (bp_in),
	.derivative_out (bp_out),
	.sub_block (ALU_i.sub_block)
);

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
reg [63:0][31:0] convo_out;
assign convo_mask = rev_mask ? rm_reversed : mask.mask; 
convolution convo( 
	.pixels_in (in_block1.block),
	.mask (convo_masvo_out));

reg [63:0][31:0] r_pixels_in;
reg [63:0][31:0] r_pixels_out;
relu r (
	.pixels_in (r_pixels_in),
	.pixels_out (rk),
	.pixels_out (con_pixels_out));

reg [8:0][31:0] rm_reversed;
reverse_mask rm (
	.kernel (mask.mask),
	.reversed (rm_reversed));

/********* OPERATION DESCRIPTIONS AND ENCODING **********
*	Three bits give the operation ID for the ALU to execute.
* 		000: convolution 				FLAGS: rev_mask high
*		001: forward pool				FLAGS: sub_block
*		010: backward pool			FLAGS: sub_block
*		011: reLU
*		100: difference
*		101: dot product				FLAGS: sub_index
* 	
* 	Summary of ALU usage:
*
*	FORWARD PASS
*		- convolution
*		- reLU
*		- forward pool with the sub_block flag
*
*  LOSS FUNCTIONS
*		Content loss:
*			- difference
*			- dot product
*
*		Artistic loss:
*			- Gram matrix: dot product with the sub_index flag
*	
*		 	- Total loss:
*				- difference 
*				- dot product
*
*	DERIVATIVES:
*		Content loss:
*			- difference
*
*		Artistic loss:
*			- matrix Multiplication: Dot product
*			- difference
*
* 		Backwards pass:
*			- backward pool				FLAGS: sub_block
*			- dot product
*			- convolution					FLAGS: rev_mask low
*/

reg state;
// 0: Ready for instructions / Executing instruction
// 1: Write/Accumulate
always @(posedge iCLK)
begin
	case (state)
	 0 : begin
			if (execute): begin
				case (operation)
				// Convolution
					000 : begin
				
end
endmodule
