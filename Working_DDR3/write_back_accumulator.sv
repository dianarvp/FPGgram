//accumulator
module accumulator (
	iCLK,
	load_block,
	start_reg,
	stride,
	buffer_data,	
	load_ddr,
	store,
	start_address,
	avl_readdatavalid,
	avl_burstbegin,
	avl_wait_request_n,
	avl_address,
	avl_readdata,
	avl_writedata,
	avl_write,
	avl_read,
	buffer,
	done
	);

parameter BUFFER_SIZE = 57344;
parameter BLOCK_WIDTH = 8;
parameter BLOCK_SIZE = 64;
output [BUFFER_SIZE-1:0] buffer;

//Interface for DDR3
input iCLK;
input load_ddr;
input store;
input [25:0] start_address;
output done;

//Local register interface
input load_block;
input [BLOCK_SIZE-1:0][31:0] buffer_data;
input [7:0] stride;
input [15:0] start_reg;

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

reg [3:0] state;
reg [15:0] index;
reg [4:0] write_count;
always@(posedge iCLK)
begin
	if (!load_ddr &!load_block && !store)
	begin
		write_count <= 1'b0;
		index <= 1'b0;
		state <= 0;
		done <= 1;
		avl_address <= {26{1'b0}};
		end
	else
	begin
	case (state)
	 0 : begin
			if (done && load_ddr) begin
				avl_address <= start_address;
				state <= 1;
				done <= 0;
			end else if (done && store) begin
				avl_address <= start_address;
				state <= 4;
				done <= 0;
			end else if (done && load_block) begin
				state <= 7;
				done <= 0;
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
				buffer[128*32*avl_address +:128*32] <= avl_readdata;
				state <= 3;
			end
		end
	 3 : begin
			if (write_count[3])
			begin
				write_count <= 5'b0;

				if ((index + 128) > (BUFFER_SIZE - 1)) //Done reading 
				begin
					avl_address <=  {26{1'b0}};
					state <= 8;
				end
				else // Read next
				begin
					avl_address <= avl_address + 1;
					index <= index + 8'd128;
					state <= 1;
				end
			end
		end
		
		// Writing from local registers to DDR3
	 4: begin
			//avl_writedata <= buffer[128*avl_address +:128];
			if (!write_count[3])
			begin
				avl_write <= 1'b1;
				state <= 5;
			end
			else write_count <= write_count + 1'b1;
		end
	 5 : begin
			if (avl_wait_request_n)
			begin
	  			avl_write <= 1'b0;
	  			state <= 6;
	  		end
		end
	 6 : begin
			if ((index + 8'd128) > (BUFFER_SIZE - 1)) // Loaded all memory
			begin
				avl_address <= {26{1'b0}};
				state <= 8;
			end
			else
			begin
				avl_address <= avl_address + 1'b1;
				index <= index + 8'd128;
				state <= 4;
			end
		end
		
		// Loading block of memory from computations to local registers
	 7 : begin
			//buffer[start_reg +: BLOCK_WIDTH] <= buffer_data[BLOCK_WIDTH-1:0];
			/*buffer[start_reg*stride +: BLOCK_WIDTH] <= buffer_data[2 * BLOCK_WIDTH-1:BLOCK_WIDTH];
			buffer[start_reg*2*stride +: BLOCK_WIDTH] <= buffer_data[3 * BLOCK_WIDTH-1:2 * BLOCK_WIDTH];
			buffer[start_reg*3*stride +: BLOCK_WIDTH] <= buffer_data[4 * BLOCK_WIDTH-1:3 * BLOCK_WIDTH];
			buffer[start_reg*4*stride +: BLOCK_WIDTH] <= buffer_data[5 * BLOCK_WIDTH-1:4 * BLOCK_WIDTH];
			buffer[start_reg*5*stride +: BLOCK_WIDTH] <= buffer_data[6 * BLOCK_WIDTH-1:5 * BLOCK_WIDTH];
			buffer[start_reg*6*stride +: BLOCK_WIDTH] <= buffer_data[7 * BLOCK_WIDTH-1:6 * BLOCK_WIDTH];
			buffer[start_reg*7*stride +: BLOCK_WIDTH] <= buffer_data[8 * BLOCK_WIDTH-1:7 * BLOCK_WIDTH];*/
		   state <= 8;
		  end
	 8 : done <= 1'b1;
	 default : state <= 0;
	 endcase
	end
end

endmodule
