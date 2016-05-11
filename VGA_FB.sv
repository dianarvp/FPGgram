/*
 * Avalon memory-mapped peripheral for the VGA BALL Emulator
 *
 * Tonye Brown, tb2553
 * Diana Valverde, drv2110
 * Columbia University
 */

module VGA_FB(input logic        clk,
               input logic        reset,
               input logic        write,
               input              chipselect,
               input logic [31:0] address,
	       input logic [31:0] writedata,

               output logic [7:0] VGA_R, VGA_G, VGA_B,
               output logic       VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_n,
               output logic       VGA_SYNC_n);

        logic pixel_write;
        logic[9:0] x,y;
	logic[23:0] rgb;

   VGA_FB_Emulator fb_emulator(.clk50(clk), .*);
	typedef enum logic[2:0] {RESET, HOLD, RUN} state_t;
	state_t state;
	
	logic [307199:0][23:0] framebuffer;
	
	logic[18:0]  write_address, read_address;
	
	assign write_address = address[18:0];
        assign read_address = x + (y << 9) + (y << 7 );
	assign rgb = framebuffer[read_adress];

	logic[18:0] i;
   always_ff @(posedge clk) begin
		if (reset) state <= RESET;
		else case (state)
			RESET: begin
				for (i=18'd0; i < 18'd307199; i = i+ 18'd1) begin
					framebuffer[i] <= 23'd0;
				end
				pixel_write <= 0;
				state <= HOLD;
				end
			HOLD: 
				if (chipselect && write) begin
					pixel_write <= 0;
					framebuffer[write_address] <= writedata[24:1];
					if (writedata[1]) state <= RUN;
				end
			RUN:
				pixel_write <= 1;
				state <= HOLD;
				
			default:
				state <= HOLD;
			endcase
	end
endmodule

