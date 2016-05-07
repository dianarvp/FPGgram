module accumulator (
	//Signals for all
	iCLK,
	ready,
	reset,

	//ALU interface
	accumulate,
	block_num,
	block,

	//Mem control interface for top level
	load_ddr,
	store_ddr,
	start_address,
	stride,
	rows,

	//AVL signals
	avl_readdatavalid,
	avl_burstbegin,
	avl_wait_request_n,
	avl_address,
	avl_readdata,
	avl_writedata,
	avl_write,
	avl_read
);


parameter BUFFER_WIDTH = 512;
parameter BUFFER_SIZE = BUFFER_WIDTH*BUFFER_WIDTH;
parameter BLOCK_WIDTH = 8;
parameter BLOCK_SIZE = BLOCK_WIDTH*BLOCK_WIDTH;
parameter BLOCKS_ROW = BUFFER_WIDTH/BLOCK_WIDTH;
reg [BUFFER_SIZE-1:0][31:0] buffer;

//Wires connecting buffer to input blocks
wire [BUFFER_SIZE/BLOCK_SIZE:0][BLOCK_SIZE-1:0][31:0] blocks;

genvar j, k;
generate
	for (j=0; j < BUFFER_WIDTH; j++) begin : for_j
		for (k = 0; k < BUFFER_WIDTH; k++) begin : for_k
			assign buffer[1+j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][7:0];
			assign buffer[2*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][15:8];
			assign buffer[3*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][23:16];
			assign buffer[4*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][31:24];
			assign buffer[5*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][39:32];
			assign buffer[6*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][47:40];
			assign buffer[7*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][55:48];
			assign buffer[8*j*8*BUFFER_WIDTH + k*8 +: 8] = blocks[j*BLOCKS_ROW + k][63:56];
		end
	end
endgenerate

//Signals for all
input iCLK;
input reset;
output ready;

//ALU write interface
input accumulate;
input block_num;
input [BLOCK_SIZE-1:0][31:0] block;

//Mem control interface for top level
input load_ddr;
input store_ddr;
input [25:0] start_address;
input [9:0] stride;
input [9:0] rows;

//AVL signals
input avl_readdatavalid;
output avl_burstbegin;
input avl_wait_request_n;
output [25:0] avl_address;
input [127:0] avl_readdata;
output [127:0] avl_writedata;
output avl_write;
output avl_read;
assign avl_burstbegin = avl_write || avl_read;

logic i;

reg [3:0] state;
reg [15:0] index;
reg [15:0] row;
reg [4:0] write_count;
// 0 : idle
// 1 : write to ddr
always@(posedge iCLK)
begin
	if (reset) begin
		//Reset memory
		for ( i = 0; i < BUFFER_SIZE; i++) buffer[i] <= 31'b0;
		
		//Reset signals
		state <= 0;
		write_count <= 0;
		index <= 0;
		row <= 0;
		ready <= 1;
		avl_address <= {26{1'b0}};		
	end
	else if (accumulate)
		for ( i = 0; i < BLOCK_SIZE; i++) blocks[block_num][i] <= blocks[block_num][i] + block[i];
	else begin
	case (state)
	 0 : begin
			if (ready && store_ddr) begin
				avl_address <= start_address;
				state <= 2;
				ready <= 0;
			end
		end

	// Writing data back to DDR3
	 1: begin
			avl_writedata <= buffer[4*index + BUFFER_WIDTH*row +:128];
			if (write_count[3])
			begin
				write_count <= 5'b0;
				avl_write <= 1'b1;
				state <= 2;
			end
			else write_count <= write_count + 1'b1;
		end
	 2 : begin
			if (avl_wait_request_n)
			begin
	  			avl_write <= 1'b0;
	  			state <= 3;
	  		end
		end
	 3 : begin
			if ((index > stride - 1) && (row > rows - 1)) // Loaded all memory
			begin
				avl_address <= {26{1'b0}};
				state <= 4;
			end
			else
			begin
				avl_address <= avl_address + 1'b1;
				state <= 2;
				if (index > stride - 2)
				begin
					index <= 0;
					row <= row + 1;
				end else index <= index + 1;
			end
		end
	 4 : begin
		ready <= 1'b1;
		state <= 0;
	 end
	 default : state <= 0;
	 endcase
	end
end

endmodule
