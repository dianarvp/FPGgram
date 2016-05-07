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

interface READ_BUFFER #(parameter BLOCK_SIZE = 64);
	input iCLK;
	input reset;
	output ready;
	input block_num;
	output [BLOCK_SIZE-1:0][31:0] block;
	input load_ddr;
	input pad;
	input [25:0] start_address;
	input [9:0] stride;
	input [9:0] rows;
endinterface

interface MASK_BUFFER;
	input iCLK;
	input reset;
	output ready;
	output [8:0][31:0] mask;
	input load_ddr;
	input [25:0] start_address;
endinterface

interface WRITE_BACK #(parameter BLOCK_SIZE = 64);
	input iCLK;
	input reset;
	output ready;
	input accumulate;
	input block_num;
	input [BLOCK_SIZE-1:0][31:0] block;
	input load_ddr;
	input store_ddr;
	input [25:0] start_address;
	input [9:0] stride;
	input [9:0] rows;
endinterface




module mem_control (
	
);
	// AVL interface to MUX between
	// Instantiate all memory modules
   /*
	* ==============
	* READ BUFFER 1
	* ==============
	*/
	read_buffer rb1  (
	);

	/*
	* ==============
	* READ BUFFER 2
	* ==============
	*/
	
	read_buffer rb2 (
	);

	/*
	* ==============
	* MASK BUFFER
	* ==============
	*/

	mask_buffer mb (
	);

	/*
	* ======================
	* WRITE BACK ACCUMULATOR
	* ======================
	*/
	write_back_accumulator wba (
	);

endmodule
