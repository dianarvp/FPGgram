module mem_control (
	input [3:0] selector,
	AVL.Master to_avl,
	READ_BUFFER.BUFFER rbi1,
	READ_BUFFER.BUFFER rbi2,
	MASK_BUFFER.BUFFER mask,
	WRITE_BACK.BUFFER wba
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
