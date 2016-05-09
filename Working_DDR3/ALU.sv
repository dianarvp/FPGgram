// ALU (mux between stuff)
module ALU (
	input iCLK,
	READ_BUFFER.ALU in_block1,
	READ_BUFFER.ALU in_block2,
	MASK_BUFFER.ALU mask,
	WRITE_BACK.ALU out_block,
	ALU_i.ALU from_top
);
parameter PADDED_SIZE = 10;
parameter NOT_PADDED_SIZE = 8;

// 8x8 inputs
reg [63:0][31:0] no_pad1;
reg [63:0][31:0] no_pad2;
genvar i,j;
generate for (i = 0; i < NOT_PADDED_SIZE; i++) begin: for_i
	for (j = 0; j < NOT_PADDED_SIZE; j++) begin: for_j
		assign no_pad1[i+j*NOT_PADDED_SIZE] = in_block1.block[i+j*PADDED_SIZE];
		assign no_pad2[i+j*NOT_PADDED_SIZE] = in_block2.block[i+j*PADDED_SIZE];
	end
end
endgenerate



//Instantiate arithmetic modules
reg [63:0][31:0] ap_out;
avg_pool av (
	.pixels_in (no_pad1),
	.pixels_out (ap_out),
	.sub_block (ALU_i.sub_block)
);

reg [63:0][31:0] diff_out;
difference d (
	.in1 (no_pad1),
	.in2 (no_pad2),
	.out (diff_out)
);

reg [63:0][31:0] bp_out;
backprop_pool bp (
	.derivative_in (no_pad1),
	.derivative_out (bp_out),
	.sub_block (ALU_i.sub_block)
);

reg [63:0][31:0] br_out;
backprop_relu br (
	.derivative_in (no_pad1),
	.pixels (no_pad2),
	.derivative_out (br_out)
);

reg [63:0][31:0] dp_out;
dot_product dp (
	.out_index (ALU_i.sub_index),
	.in1 (no_pad1),
	.in2 (no_pad2),
	.out (dp_out)
);

reg [8:0][31:0] rm_reversed;
reverse_mask rm (
	.kernel (mask.mask),
	.reversed (rm_reversed)
);

reg [8:0][31:0] convo_mask;
reg [63:0][31:0] convo_out;
assign convo_mask = mask.rev_mask ? rm_reversed : mask.mask; 
convolution convo( 
	.pixels_in (in_block1.block),
	.mask (convo_mask),
	.pixels_out (convo_out)
);

reg [63:0][31:0] r_pixels_out;
relu r (
	.pixels_in (no_pad1),
	.pixels_out (r_pixels_out)
);


/********* OPERATION DESCRIPTIONS AND ENCODING **********
*	Three bits give the operation ID for the ALU to execute.
* 		000: convolution 				FLAGS: rev_mask high
*		001: forward pool				FLAGS: sub_block
*		010: backward pool			FLAGS: sub_block
*		011: reLU
*		100: difference
*		101: dot product				FLAGS: sub_index
*		110: backprop reLu
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
*			- backprop reLu
*			- dot product
*			- convolution					FLAGS: rev_mask low
*/

reg state;
initial begin state <= 0;
	from_top.ready <= 1;
end

// 0: Ready for instructions / Executing instruction
// 1: Write/Accumulate
always @(posedge iCLK)
begin
	case (state)
	 0 : begin
			if (from_top.execute) begin
				from_top.ready <= 0;
				out_block.accumulate <= 1;
				state <= 1;

				case (from_top.operation)
					3'b000 : out_block.block <= convo_out;
					3'b001 : out_block.block <= ap_out;
					3'b010 : out_block.block <= bp_out;
					3'b011 : out_block.block <= r_pixels_out;
					3'b100 : out_block.block <= diff_out;
					3'b101 :	out_block.block <= dp_out;
					3'b110 : out_block.block <= br_out;
				endcase
			end
		end
	 1 : begin
			out_block.accumulate <= 0;
			state <= 0;
			from_top.ready <= 1;
		end
	endcase
end
endmodule
