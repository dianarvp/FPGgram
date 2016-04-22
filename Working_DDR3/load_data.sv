// Module to read from memory onto registers
module load_data(
	iCLK,
	load,
	avl_readdatavalid,
	avl_burstbegin,
	avl_wait_request_n,
	avl_address,
	avl_readdata,
	avl_write,
	avl_read,
	buffer,
	read_done
	);

parameter BUFFER_SIZE = 512;

input iCLK;
input load;
input avl_readdatavalid;
input avl_wait_request_n;
output avl_burstbegin;
output [25:0] avl_address;
input [127:0] avl_readdata;
output avl_write;
output avl_read;
output [BUFFER_SIZE-1:0][15:0] buffer;
output read_done;


assign avl_burstbegin = avl_write || avl_read;

reg [1:0] state;
reg [15:0] index;
reg [4:0] write_count;
always@(posedge iCLK)
begin
	if (!load)
	begin
		write_count <= 1'b0;
		state <= 0;
		index <= 1'b0;
		avl_address <= 0;
	end
	else
	begin
	case (state)
	 0 : begin
			avl_read <= 1;

			if (!write_count[3])
				write_count <= write_count + 1'b1;
			if (avl_wait_request_n) //Ready to read
				state <= 1;
			end
	 1 : begin
			avl_read <= 0;
			if (!write_count[3])
				write_count <= write_count + 1'b1;
			
			if (avl_readdatavalid) //Valid read
			begin
				buffer[128*avl_address +:128] <= avl_readdata;
				state <= 2;
			end
		end
	 2 : begin
			if (write_count[3])
			begin
				write_count <= 5'b0;

				if ((index + 128) > (BUFFER_SIZE - 1)) //Done reading 
				begin
					avl_address <=  {26{1'b0}};
					state <= 3;
				end
				else //Load next data
				begin
					avl_address <= avl_address + 1;
					index <= index + 8'd128;
					state <= 1;
				end
			end
		end
	 3 : read_done <= 1'b1;
	 default : state <= 0;
	 endcase
	end
end
endmodule
