// Module to write from registers onto memory
module write_data(
	iCLK,
	store,
	buffer,
	avl_waitrequest_n,
	avl_address,
	avl_burstbegin,
	avl_writedata,
	avl_write,
	avl_read,
	write_done
	);

parameter BUFFER_SIZE = 512;

input iCLK;
input store;
input avl_waitrequest_n;
output [BUFFER_SIZE-1:0][15:0] buffer;
output [25:0] avl_address;
output [127:0] avl_writedata;
output avl_burstbegin;
output avl_write;
input avl_read;
output write_done;

assign avl_burstbegin = avl_write || avl_read;

reg [1:0] state;
reg [15:0] index;
reg [4:0] write_count;
always@(posedge iCLK)
begin
	if (!store)
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
			avl_writedata <= buffer[128*avl_address +:128];
			if (!write_count[3])
			begin
				avl_write <= 1'b1;
				state <=1;
			end
			else write_count <= write_count + 1'b1;
		end
	 1 : begin
			if (avl_waitrequest_n)
			begin
	  			avl_write <= 1'b0;
	  			state <= 2;
	  		end
		end
	 2 : begin
			if ((index + 8'd128) > (BUFFER_SIZE - 1)) //Finished copying data
			begin
				avl_address <= {26{1'b0}};
				state <= 3;
			end
			else
			begin
				avl_address <= avl_address + 1'b1;
				index <= index + 8'd128;
				state <= 0;
			end
		end
	 3 : write_done <= 1'b1;
	 default : state <= 0;
	 endcase
	end
end
endmodule