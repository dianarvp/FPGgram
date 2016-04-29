interface AVL;
	input avl_readdatavalid;
	output avl_burstbegin;
	input avl_wait_request_n;
	output [25:0] avl_address;
	input [127:0] avl_readdata;
	output [127:0] avl_writedata;
	output avl_write;
	output avl_read;
endinterface


module mem_control (
	
);

	read_buffer rb1  (
	);
	
	read_buffer rb2 (
	);
	mask_buffer mb (
	);
	write_back_accumulator wba (
	);

endmodule
