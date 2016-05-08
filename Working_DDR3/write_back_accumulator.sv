module write_back_accumulator (
	input iCLK,
	WRITE_BACK.BUFFER bif, 	//Interface for top level and ALU
	AVL.Master avl 			//DDR3 interface
);

parameter BUFFER_WIDTH = 512;
parameter BUFFER_SIZE = BUFFER_WIDTH*BUFFER_WIDTH;
parameter BLOCK_WIDTH = 8;
parameter BLOCK_SIZE = BLOCK_WIDTH*BLOCK_WIDTH;
parameter BLOCKS_ROW = BUFFER_WIDTH/BLOCK_WIDTH;
reg [BUFFER_SIZE-1:0][31:0] buffer;

assign avl.avl_burstbegin = avl.avl_write || avl.avl_read;

//Wires connecting buffer to input blocks
wire [BLOCKS_ROW*BLOCKS_ROW-1:0][BLOCK_SIZE-1:0][31:0] blocks;
genvar j, k;
generate
	for (j=0; j < BLOCKS_ROW; j++) begin : for_j
		for (k = 0; k < BLOCKS_ROW; k++) begin : for_k
			assign buffer[(0+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][7:0];
			assign buffer[(1+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][15:8];
			assign buffer[(2+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][23:16];
			assign buffer[(3*j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][31:24];
			assign buffer[(4+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][39:32];
			assign buffer[(5+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][47:40];
			assign buffer[(6+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][55:48];
			assign buffer[(7+j*8)*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][63:56];
		end
	end
endgenerate


logic i;
reg [3:0] state;
reg [15:0] index;
reg [15:0] row;
reg [4:0] write_count;
// 0 : idle
// 1 : write to ddr
always@(posedge iCLK)
begin
	if (bif.reset) begin
		//Reset memory
		for ( i = 0; i < BUFFER_SIZE; i++) buffer[i] <= 31'b0;
		
		//Reset signals
		state <= 0;
		write_count <= 0;
		index <= 0;
		row <= 0;
		bif.ready <= 1;
		avl.avl_address <= {26{1'b0}};		
	end
	else if (bif.accumulate)
		for ( i = 0; i < BLOCK_SIZE; i++) blocks[bif.block_num][i] <= blocks[bif.block_num][i] + bif.block[i];
	else begin
	case (state)
	 0 : begin
			if (avl.local_init_done && bif.store_ddr) begin
				avl.avl_address <= bif.start_address;
				state <= 1;
				bif.ready <= 0;
			end
		end

	// Writing data back to DDR3
	 1: begin
			avl.avl_writedata <= buffer[4*index + BUFFER_WIDTH*row +:128];
			if (write_count[3])
			begin
				write_count <= 5'b0;
				avl.avl_write <= 1'b1;
				state <= 2;
			end
			else write_count <= write_count + 1'b1;
		end
	 2 : begin
			if (avl.avl_wait_request_n)
			begin
	  			avl.avl_write <= 1'b0;
	  			state <= 3;
	  		end
		end
	 3 : begin
			if ((index >= bif.stride - 1) && (row >= bif.rows - 1)) // Loaded all memory
			begin
				avl.avl_address <= {26{1'b0}};
				state <= 4;
			end
			else
			begin
				avl.avl_address <= avl.avl_address + 1'b1;
				state <= 1;
				if (index >= bif.stride - 1)
				begin
					index <= 0;
					row <= row + 1;
				end else index <= index + 1;
			end
		end
	 4 : begin
		bif.ready <= 1'b1;
		state <= 0;
	 end
	 default : state <= 0;
	 endcase
	end
end

endmodule
