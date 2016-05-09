/*********** Mem control interfaces ******************/
interface AVL;
	logic local_init_done;
	logic avl_readdatavalid;
	logic avl_burstbegin;
	logic avl_wait_request_n;
	logic [25:0] avl_address;
	logic [127:0] avl_readdata;
	logic [127:0] avl_writedata;
	logic avl_write;
	logic avl_read;
	modport Master (  input local_init_done,
									avl_readdatavalid,
									avl_wait_request_n,
									avl_readdata,
							output avl_burstbegin,
									avl_address,
									avl_writedata,
									avl_write,
									avl_read);
endinterface

interface READ_BUFFER #(parameter BLOCK_SIZE = 100);
	logic reset;
	logic ready;
	logic [10:0] block_num;
	logic [BLOCK_SIZE-1:0][31:0] block;
	logic load_ddr;
	logic pad;
	logic [25:0] start_address;
	logic [9:0] stride;
	logic [9:0] rows;
	modport TOP (output load_ddr,
								start_address,
								stride,
								rows,
								pad,
								reset,
								block_num,
					 input ready);
	modport ALU (input block);
	modport BUFFER (input load_ddr,
								start_address,
								stride,
								rows,
								pad,
								reset,
								block_num,
						output ready,
								block);					
endinterface

interface MASK_BUFFER;
	logic reset;
	logic ready;
	logic [8:0][31:0] mask;
	logic load_ddr;
	logic [25:0] start_address;
	modport TOP (output load_ddr,
							start_address,
							reset,
					 input ready);
	modport ALU (input mask);
	modport BUFFER (input reset,
								load_ddr,
								start_address,
						 output ready,
								mask);
endinterface

interface WRITE_BACK #(parameter BLOCK_SIZE = 64);
	logic reset;
	logic ready;
	logic accumulate;
	logic [10:0] block_num;
	logic [BLOCK_SIZE-1:0][31:0] block;
	logic store_ddr;
	logic [25:0] start_address;
	logic [9:0] stride;
	logic [9:0] rows;
	modport TOP (output store_ddr,
								start_address,
								stride,
								rows,
								reset,
								block_num,
					 input ready);
	modport ALU (output block, accumulate);
	modport BUFFER (input reset,
								accumulate,
								block_num,
								block,
								store_ddr,
								start_address,
								stride,
								rows,
						 output ready);								
endinterface

/***************** ALU interface ******************/
interface ALU_i;
	logic execute;
	logic [2:0] operation;
	logic rev_mask;
	logic [1:0] sub_block;
	logic [7:0] sub_index;
	logic ready;
	modport TOP ( output execute,
								operation,
								rev_mask,
								sub_block,
								sub_index,
						input ready);
	modport ALU ( input execute,
								operation,
								rev_mask,
								sub_block,
								sub_index,
					  output ready);