module mask_buffer (
	input iCLK,
	MASK_BUFFER.BUFFER bif, // Interface for top level and ALU
	AVL.Master avl				// DDR3 interface
);

assign avl.avl_burstbegin = avl.avl_write || avl.avl_read;

logic [3:0] state;
logic [4:0] write_count;
logic [7:0] index;
logic i;
// 0: idle
// 1: load mask from ddr
always@(posedge iCLK)
begin
	if (bif.reset) begin
		write_count <= 5'b0;
		state <= 0;
		bif.ready <= 1;
		index <= 7'b0;
		avl.avl_address <= {26{1'b0}};
	end
	else begin
	case (state)
	 0 : begin
			if (avl.local_init_done && bif.load_ddr) begin
				avl.avl_address <= bif.start_address;
				state <= 1;
				bif.ready <= 0;
			end
		end
		//Reading from DDR3 to output
	 1 : begin	
			avl.avl_read <= 1;

			if (!write_count[3])
				write_count <= write_count + 1'b1;

			if (avl.avl_wait_request_n) //Ready to read
				state <= 2;
		end
	 2 : begin
			avl.avl_read <= 0;

			if (!write_count[3])
				write_count <= write_count + 1'b1;

			if (avl.avl_readdatavalid)
			begin 
				bif.mask[index*4 +: 4] <= avl.avl_readdata;
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
					avl.avl_address <= avl.avl_address + 1;
					state <= 1;
					index <= index + 1;
				end
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
