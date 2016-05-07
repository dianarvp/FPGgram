module read_buffer (
	//Signals for all
	iCLK,
	ready,
	reset,

	//Mem control interface for top level
	load_ddr,
	pad,
	start_address,
	stride,
	rows,

	//ALU interface
	block_num,
	block,
	
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
parameter BLOCK_WIDTH = 10;
parameter BLOCK_SIZE = BLOCK_WIDTH*BLOCK_WIDTH;
parameter BLOCKS_ROW = BUFFER_WIDTH/(BLOCK_WIDTH-2);
reg [BUFFER_SIZE-1:0][31:0] buffer;

//Wires connecting buffer to output blocks
wire [BUFFER_SIZE/BLOCK_SIZE:0][BLOCK_SIZE-1:0][31:0] blocks;
genvar j, k;
generate
	for (j=0; j < BUFFER_WIDTH/(BLOCK_WIDTH-2); j++) begin : for_j
		for (k=0; k < BUFFER_SIZE; k++) begin : for_k
			assign blocks[j*BLOCKS_ROW + k][9:0] = buffer[(0+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][19:10] = buffer[(1+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][29:20] = buffer[(2+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][39:30] = buffer[(3+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][49:40] = buffer[(4+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][59:50] = buffer[(5+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][69:60] = buffer[(6+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][79:70] = buffer[(7+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][89:80] = buffer[(8+j*8)*BUFFER_WIDTH + k*8 +: 10];
			assign blocks[j*BLOCKS_ROW + k][99:90] = buffer[(9+j*8)*BUFFER_WIDTH + k*8 +: 10];

		end
	end
endgenerate

//Signals for all
input iCLK;
input reset;
output ready;

//ALU read interface
input block_num;
output [BLOCK_SIZE-1:0][31:0] block;

//Mem control interface for top level
input load_ddr;
input pad;
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

logic [3:0] state;
logic [15:0] row;
logic [15:0] index;
logic [4:0] write_count;
logic i;

assign block = blocks[block_num];

// 0: idle
// 1: load from ddr
always@(posedge iCLK)
begin
	if (reset) begin
		for (i = 0; i < BUFFER_SIZE; i++) buffer[i] <= 31'b0;
		write_count <= 0;
		index <= 16'b0;
		row <= 16'b0;
		state <= 0;
		ready <= 1;
		avl_address <= {26{1'b0}};		
	end
	else begin
	case (state)
	 0 : begin
		if (ready && load_ddr) begin
				avl_address <= start_address;
				state <= 1;
				ready <= 0;
		end
	 end		
	//Reading from DDR3 to local registers
	 1 : begin	
			avl_read <= 1;

			if (!write_count[3])
				write_count <= write_count + 1'b1;

			if (avl_wait_request_n) //Ready to read
				state <= 2;
		end
	 2 : begin
			avl_read <= 0;

			if (!write_count[3])
				write_count <= write_count + 1'b1;

			if (avl_readdatavalid)
			begin 
				if (pad) buffer[4*(index + 1) + BUFFER_WIDTH*(row+1) +: 4] <= avl_readdata;
				else buffer[4*index + BUFFER_WIDTH*row +:4] <= avl_readdata;
				state <= 3;
			end
		end
	 3 : begin
			if (write_count[3])
			begin
				write_count <= 5'b0;

				if ((index > stride - 1) && (row > rows - 1)) //Done reading 
				begin
					state <= 4;
				end
				else // Read next
				begin
					avl_address <= avl_address + 1;
					state <= 1;
					if (index > stride - 2)
					begin
						index <= 0;
						row <= row + 1;
					end else index <= index + 1;
				end
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
