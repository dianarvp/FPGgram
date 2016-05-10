/* This unit MUXes between the buffers' AVL interfaces*/
module mem_control (
	input iCLK,
	input [3:0] selector,
	AVL.Master to_ddr3,
	READ_BUFFER.BUFFER rbi1,
	READ_BUFFER.BUFFER rbi2,
	MASK_BUFFER.BUFFER mi,
	WRITE_BACK.BUFFER wi
);

	AVL rb1();
	AVL rb2();
	AVL mask();
	AVL wba();

	read_buffer rb1_i  (
		.iCLK (iCLK),
		.bif (rbi1),
		.avl (rb1.Master)
	);

	read_buffer rb2_i (
		.iCLK (iCLK),
		.bif (rbi1),
		.avl (rb2.Master)
	);

	mask_buffer mb_i (
		.iCLK (iCLK),
		.bif (mi),
		.avl (mask.Master)
	);

	write_back_accumulator wba_i (
		.iCLK (iCLK),
		.bif (wi),
		.avl (wba.Master)
	);

/*
	000 : read buffer 1 selected -- this one is the default read buffer
	001 : read buffer 2 selected -- used when both buffers are needed
	010 : mask buffer
	011 : write back accumulator
	100 : basic read
	101 : basic write
*/
always_comb begin
	to_ddr3.avl_burstbegin = 0;
	to_ddr3.avl_address = 0;
	to_ddr3.avl_writedata = 0;
	to_ddr3.avl_write = 0;
	to_ddr3.avl_read = 0;
	rb1.local_init_done = 0;
	rb1.avl_readdatavalid = 0;
	rb1.avl_wait_request_n = 0;
	rb1.avl_readdata = 0;
	rb2.local_init_done = 0;
	rb2.avl_readdatavalid = 0;
	rb2.avl_wait_request_n = 0;
	rb2.avl_readdata = 0;
	mask.local_init_done = 0;
	mask.avl_readdatavalid = 0;
	mask.avl_wait_request_n = 0;
	mask.avl_readdata = 0;
	wba.local_init_done = 0;
	wba.avl_readdatavalid = 0;
	wba.avl_wait_request_n = 0;
	wba.avl_readdata = 0;

	case (selector)
		2'b00 : begin
			rb1.local_init_done = to_ddr3.local_init_done;
			rb1.avl_readdatavalid = to_ddr3.avl_readdatavalid;
			rb1.avl_wait_request_n = to_ddr3.avl_wait_request_n;
			rb1.avl_readdata = to_ddr3.avl_readdata;
			to_ddr3.avl_burstbegin = rb1.avl_burstbegin;
			to_ddr3.avl_address = rb1.avl_address;
			to_ddr3.avl_writedata = rb1.avl_writedata;
			to_ddr3.avl_write = rb1.avl_write;
			to_ddr3.avl_read = rb1.avl_read;
		end
		2'b01 : begin
			rb2.local_init_done = to_ddr3.local_init_done;
			rb2.avl_readdatavalid = to_ddr3.avl_readdatavalid;
			rb2.avl_wait_request_n = to_ddr3.avl_wait_request_n;
			rb2.avl_readdata = to_ddr3.avl_readdata;
			to_ddr3.avl_burstbegin = rb2.avl_burstbegin;
			to_ddr3.avl_address = rb2.avl_address;
			to_ddr3.avl_writedata = rb2.avl_writedata;
			to_ddr3.avl_write = rb2.avl_write;
			to_ddr3.avl_read = rb2.avl_read;
		end
		2'b10 : begin
			mask.local_init_done = to_ddr3.local_init_done;
			mask.avl_readdatavalid = to_ddr3.avl_readdatavalid;
			mask.avl_wait_request_n = to_ddr3.avl_wait_request_n;
			mask.avl_readdata = to_ddr3.avl_readdata;
			to_ddr3.avl_burstbegin = mask.avl_burstbegin;
			to_ddr3.avl_address = mask.avl_address;
			to_ddr3.avl_writedata = mask.avl_writedata;
			to_ddr3.avl_write = mask.avl_write;
			to_ddr3.avl_read = mask.avl_read;
		end
		2'b11 : begin
			wba.local_init_done = to_ddr3.local_init_done;
			wba.avl_readdatavalid = to_ddr3.avl_readdatavalid;
			wba.avl_wait_request_n = to_ddr3.avl_wait_request_n;
			wba.avl_readdata = to_ddr3.avl_readdata;
			to_ddr3.avl_burstbegin = wba.avl_burstbegin;
			to_ddr3.avl_address = wba.avl_address;
			to_ddr3.avl_writedata = wba.avl_writedata;
			to_ddr3.avl_write = wba.avl_write;
			to_ddr3.avl_read = wba.avl_read;
		end
	endcase
end			
endmodule
