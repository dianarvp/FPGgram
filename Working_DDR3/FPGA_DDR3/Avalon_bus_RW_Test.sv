module Avalon_bus_RW_Test (

		iCLK,
		iRST_n,
		iBUTTON,

		local_init_done,
		avl_waitrequest_n,                 
		avl_address,                      
		avl_readdatavalid,                 
		avl_readdata,                      
		avl_writedata,                     
		avl_read,                          
		avl_write,    
		avl_burstbegin,
		
		drv_status_pass,
		drv_status_fail,
		drv_status_test_complete,
		
		c_state		


);

parameter      ADDR_W             =     26;
parameter      DATA_W             =     128;

input          iCLK;
input          iRST_n;
input          iBUTTON;
input				local_init_done;
input          avl_waitrequest_n;                 //             avl.waitrequest_n
output [ADDR_W-1:0]  avl_address;                       //                .address
input          avl_readdatavalid;                 //                .readdatavalid
input  [DATA_W-1:0] avl_readdata;                      //                .readdata
output [DATA_W-1:0] avl_writedata;                     //                .writedata
output         avl_read;                          //                .read
output         avl_write;                         //                .write

output		drv_status_pass;
output		drv_status_fail;
output		drv_status_test_complete;

output			avl_burstbegin;
output	[3:0]c_state;		

//=======================================================
//  Signal declarations
//=======================================================
reg  [63:0]          clk_cnt, cal_data;
reg  [1:0]           pre_button;
reg                  trigger;
reg  [DATA_W-1:0]    data_reg;
wire [63:0]          y0, y1, y2;
wire [7:0]           z;
wire [DATA_W-1:0]    y;	
reg  [3:0]           c_state;		
reg	                avl_write, avl_read;
reg	 [ADDR_W-1:0]   avl_address;  	
reg	 [DATA_W-1:0]   avl_writedata;
reg  [4:0]            write_count;
wire                  max_avl_address;
wire                  same;


//=======================================================
//  Structural coding
//=======================================================
assign avl_burstbegin = avl_write || avl_read;

assign y0 = cal_data + {44'b0, avl_address};
assign y1 = {y0[31:0], y0[63:32]} ^ cal_data;
assign y2 = y1 + cal_data;
assign z = y1[7:0] + y2[7:0];
assign y = {y2[61:5],z,y2}; //128 bits  32bits DDR3 width,128 bits avalon data; data not allign to 32 bits

assign max_avl_address = &avl_address;
assign same = data_reg == avl_writedata;

//=====================================================
// Instantiating everything
//=====================================================

reg [63:0][15:0] ap_in;
reg [15:0][15:0] ap_out;
avg_pool av (
	.pixels_in (ap_in),
	.pixels_out (ap_out));
	
reg [63:0][15:0] bcl_content_pixels;
reg [63:0][15:0] bcl_generated_pixels;
reg [63:0][15:0] bcl_derivative_out;
backprop_content_loss bcl (
	.content_pixels (bcl_content_pixels),
	.generated_pixels (bcl_generated_pixels),
	.derivative_out (bcl_derivative_out));
	
reg [15:0][15:0] bp_in;
reg [63:0][15:0] bp_out;
backprop_pool bp (
	.derivative_in (bp_in),
	.derivative_out (bp_out));

reg [63:0][15:0] br_derivative_in;
reg [63:0][15:0] br_pixels;
reg [63:0][15:0] br_derivative_out;
backprop_relu br (
	.derivative_in (br_derivative_in),
	.pixels (br_pixels),
	.derivative_out (br_derivative_out));
	
reg [63:0][15:0] cl_content_pixels;
reg [63:0][15:0] cl_generated_pixels;
reg [63:0][15:0] cl_loss_out;
content_loss cl (
	.content_pixels (cl_content_pixels),
	.generated_pixels (cl_generated_pixels),
	.loss_out (cl_loss_out));

reg [99:0][15:0] convo_in;
reg [8:0][15:0] convo_mask;
reg [15:0] convo_bias;
reg [63:0][15:0] convo_out;
convolution convo( 
	.pixels_in (convo_in),
	.mask (convo_mask),
	.bias (convo_bias),
	.pixels_out (convo_out));

reg [63:0][15:0] r_pixels_in;
reg [63:0][15:0] r_pixels_out;
relu r (
	.pixels_in (r_pixels_in),
	.pixels_out (r_pixels_out));
	
reg [8:0][15:0] rm_kernel;
reg [8:0][15:0] rm_reversed;
reverse_mask rm (
	.kernel (rm_kernel),
	.reversed (rm_reversed));

logic store;
logic write_done;
write_data wd (
	.iCLK (iCLK),
	.store (store),
	.buffer (output_test),
	.avl_waitrequest_n (avl_waitrequest_n),
	.avl_address (avl_address),
	.avl_burstbegin (avl_burstbegin),
	.avl_writedata (avl_writedata),
	.avl_write (avl_write),
	.avl_read (avl_read),
	.write_done (write_done)
);

logic load;
logic read_done;
load_data ld (
	.iCLK (iCLK),
	.load (load),
	.avl_readdatavalid (avl_readdatavalid),
	.avl_burstbegin (avl_burstbegin),
	.avl_wait_request_n (avl_wait_request_n),
	.avl_address (avl_address),
	.avl_readdata (avl_readdata),
	.avl_write (avl_write),
	.avl_read (avl_read),
	.buffer (output_test),
	.read_done (read_done)
	);


//=====================================================
// Registers for storing kernels and output representation
//=====================================================
reg [511:0][15:0] input_test;
reg [511:0][15:0] output_test;

//=====================================================
// Test load/store modules
//=====================================================
always@(posedge iCLK)
  if (!iRST_n)
  	 clk_cnt <= 64'b0;
  else  
  	 clk_cnt <= clk_cnt + 64'b1;

reg [5:0] test_index;
always@(posedge iCLK)
	begin
		if (!iRST_n)
		begin
			test_index <= 0;
			write_count <= 5'b0;
			store <= 0;
			write_done <= 0;
			load <= 0;
			read_done <= 0;
			input_test <= {512{1'b1}};
			output_test <= {512{1'b1}};
		end
		else
		begin
		case (c_state)
		 0 : begin
			if (local_init_done && trigger)
			begin
				c_state <= 1;
			end
		end
		 1 : begin
			store <= 1;
			if (!write_done) c_state <= 1;
			else c_state <= 2;
		end
		 2 : begin
			if (!read_done) c_state <= 2;
			else c_state <= 3;
		end
		 3 : begin
			if (input_test[test_index] == output_test[test_index])
				c_state <= 4;
			else
				c_state <= 5;
			end
		 4 : begin
			if (test_index > 510) begin
				avl_address <= {ADDR_W{1'b0}};
				c_state <= 6;
			end
			else
			begin
				test_index <= test_index + 1'b1;
				c_state <= 3;
			end
		end
		6 : c_state <= 6;
		5 : c_state <= 5;
	endcase
	end
end

//=====================================================
// DDR3 stuff
//=====================================================


/*
always@(posedge iCLK)
begin
	if (!iRST_n)
	begin 
		pre_button <= 2'b11;
		trigger <= 1'b0;
		write_count <= 5'b0;
		c_state <= 4'b0;
		avl_write <= 1'b0;
		avl_read <= 1'b0;
	end
	else
	begin
		pre_button <= {pre_button[0], iBUTTON};
		trigger <= !pre_button[0] && pre_button[1];

	  case (c_state)
	  	0 : begin //idle
	  		avl_address <= {ADDR_W{1'b0}};
	  		if (local_init_done && trigger)
	  		begin
	  			cal_data <= clk_cnt;
	  			c_state <= 1;
	  		end
	  	end
	  	1 : begin //write
	  		avl_writedata <= y; //sdc set multi-cycle 3
	  		if (write_count[3])
	  		begin
	  			write_count <= 5'b0;
	  		  avl_write <= 1'b1;
	  		  c_state <= 2;
	  		end
	  	  else
	  	  	write_count <= write_count + 1'b1;
	  	end
	  	2 : begin //finish write one data
	  		if (avl_waitrequest_n)
	  		begin
	  			avl_write <= 1'b0;
	  			c_state <= 3;
	  		end
	  	end
	  	3 : begin
	  	   if (max_avl_address) //finish write all(burst) 
	  		begin
	  			avl_address <=  {ADDR_W{1'b0}};
	  			c_state <= 10;
	  		end
	  		else //write the next data
	  		begin
	  			avl_address <= avl_address + 1'b1;
	  			c_state <= 1;
	  		end
      end
		10 : c_state <= 11;
		11 : c_state <= 4;
	  	4 : begin //read
	  		avl_writedata <= y; //sdc set multi-cycle 3  		
	  		avl_read <= 1;
	  		
	  		if (!write_count[3])
	  			write_count <= write_count + 1'b1;
	  		
	  		if (avl_waitrequest_n)
	  			c_state <= 5;
	  	end
	  	5 : begin //latch read data
	  		avl_read <= 0;
 		
	  		if (!write_count[3])
	  			write_count <= write_count + 5'b1;

	  		if (avl_readdatavalid)
	  		begin
	  			data_reg <= avl_readdata;
	  			c_state <= 6;
        end
	  	end
	  	6 : begin //finish compare one data
	  		if (write_count[3])
	  		begin
	  			write_count <= 5'b0;
	  			if (same)
	  				c_state <= 7;
	  			else
	  				c_state <= 8;
        end
        else
        	write_count <= write_count + 1'b1;
	  	end
	  	7 : begin
	  	  if (max_avl_address) //finish compare all 
	  		begin
	  			avl_address <=  {ADDR_W{1'b0}};
	  			c_state <= 9;
	  		end
	  		else //compare the next data
	  		begin
	  			avl_address <= avl_address + 1'b1;
	  			c_state <= 4;
	  		end
	  	end
		8 : c_state <= 8;
		9 : c_state <= 9;
	    default : c_state <= 0;
	  endcase
  end
end
*/
// test result
assign drv_status_pass = (c_state == 6) ? 1 : 0;
assign drv_status_fail = (c_state == 5) ? 1 : 0;
assign drv_status_test_complete = drv_status_pass || drv_status_fail;

endmodule
