module mask_buffer (
	//Signals for all
	iCLK,
	done,

	//Mem control interface for top level
	load_ddr,
	start_address,

	//mask
	mask,
	
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

input iCLK;
output done;

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

//logic [11:0][31:0] internal_mem;
logic [3:0] state;
logic [4:0] write_count;
logic [1:0] index;
logic i;

// 0: idle
// 1: load mask from ddr
always@(posedge iCLK)
begin
	if (!load_ddr) begin
		write_count <= 5'b0;
		state <= 0;
		done <= 1;
		index <= 2'b0;
		avl_address <= {26{1'b0}};
	end

	case (state)
	 0 : begin
			if (done && load_ddr) begin
				avl_address <= start_address;
				state <= 1;
				done <= 0;
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

				if (index + 1 > 3) //Done reading 
				begin
					state <= 4;
				end
				else // Read next
				begin
					avl_address <= avl_address + 1;
					state <= 1;
					index <= index + 1;
				end
			end
		end
	 4 : done <= 1'b1;
	 default : state <= 0;
	 endcase
end

endmodule
