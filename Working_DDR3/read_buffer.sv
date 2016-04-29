module read_buffer (
	//Signals for all
	iCLK,
	done,
	reset,

	//Mem control interface for top level
	load_ddr,
	pad,
	start_address,
	stride,
	rows,

	//Memory blocks
	blocks,
	
	//AVL signals
	avl_readdatavalid,
	avl_burstbegin,
	avl_wait_request_n,
	avl_address,
	avl_readdata,
	avl_writedata,
	avl_write,
	avl_read,
	);

parameter BUFFER_WIDTH = 512;
parameter BUFFER_SIZE = BUFFER_WIDTH*BUFFER_WIDTH;
parameter BLOCK_WIDTH = 10;
parameter BLOCK_SIZE = BLOCK_WIDTH*BLOCK_WIDTH;
reg [BUFFER_SIZE-1:0][31:0] buffer;
output [BUFFER_WIDTH*(BLOCK_WIDTH-2):0][BLOCK_SIZE-1:0][31:0] blocks;

/*
generate
	genvar i;
	for (i=0; i < BUFFER_SIZE; i++) begin
		blocks[i][10:0] = buffer[i*8+10:i*8];
		blocks[i][20:10] = buffer[i*8+20:i*8+10];
		blocks[i][30:20] = buffer[i*8+30:i*8+20];
		blocks[i][40:30] = buffer[i*8+40:i*8+30];
		blocks[i][50:40] = buffer[i*8+50:i*8+40];
		blocks[i][60:50] = buffer[i*8+60:i*8+50];
		blocks[i][70:60] = buffer[i*8+70:i*8+60];
		blocks[i][80:70] = buffer[i*8+80:i*8+70];
		blocks[i][90:80] = buffer[i*8+90:i*8+80];
		blocks[i][100:90] = buffer[i*8+100:i*8+90];
	end
endgenerate
*/
input iCLK;
input reset;
output done;

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

// 0: idle
// 1: reset
// 2: load from ddr
always@(posedge iCLK)
begin
	if (!reset && !load_ddr) begin
		write_count <= 5'b0;
		index <= 16'b0;
		row <= 16'b0;
		state <= 0;
		done <= 1;
		avl_address <= {26{1'b0}};
	end

	case (state)
	 0 : begin
			if (done && reset) begin
				state <= 1;
				done <= 0;
			end else if (done && load_ddr) begin
				avl_address <= start_address;
				state <= 2;
				done <= 0;
			end
		end
		
	// Reset
	 1 : begin
			for (i = 0; i < BUFFER_SIZE; i++) buffer[i] <= 31'b0;
			state <= 5;
		end
		
	//Reading from DDR3 to local registers
	 2 : begin	
			avl_read <= 1;

			if (!write_count[3])
				write_count <= write_count + 1'b1;

			if (avl_wait_request_n) //Ready to read
				state <= 3;
		end
	 3 : begin
			avl_read <= 0;

			if (!write_count[3])
				write_count <= write_count + 1'b1;

			if (avl_readdatavalid)
			begin 
				if (pad) buffer[4*(index + 1) + BUFFER_WIDTH*(row+1) +: 4] <= avl_readdata;
				else buffer[4*index + BUFFER_WIDTH*row +:4] <= avl_readdata;
				state <= 4;
			end
		end
	 4 : begin
			if (write_count[3])
			begin
				write_count <= 5'b0;

				if ((index > stride - 1) && (row > rows - 1)) //Done reading 
				begin
					state <= 5;
				end
				else // Read next
				begin
					avl_address <= avl_address + 1;
					state <= 1;
					if (index + 1 > stride - 1)
					begin
						index <= 0;
						row <= row + 1;
					end else index <= index + 1;
				end
			end
		end
	 5 : done <= 1'b1;
	 default : state <= 0;
	 endcase
end

endmodule
