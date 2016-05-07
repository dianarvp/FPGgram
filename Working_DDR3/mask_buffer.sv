module mask_buffer (
	//Signals for all
	iCLK,
	ready,
	reset,

	//Mem control interface for top level
	load_ddr,
	start_address,

	//For ALU
	mask,
	
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

input iCLK;
input reset;
output ready;

//For ALU
output [8:0][31:0] mask;

//Mem control interface for top level
input load_ddr;
input [25:0] start_address;

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
logic [4:0] write_count;
logic [7:0] index;
logic i;

// 0: idle
// 1: load mask from ddr
always@(posedge iCLK)
begin
	if (reset) begin
		write_count <= 5'b0;
		state <= 0;
		ready <= 1;
		index <= 7'b0;
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
		//Reading from DDR3 to output
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
				mask[index*4 +: 4] <= avl_readdata;
				state <= 3;
			end
		end
	 3 : begin
			if (write_count[3])
			begin
				write_count <= 5'b0;

				//Done reading
				if (index + 1 > 8) state <= 4;
				else
				
				// Read next
				begin
					avl_address <= avl_address + 1;
					state <= 1;
					index <= index + 1;
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
