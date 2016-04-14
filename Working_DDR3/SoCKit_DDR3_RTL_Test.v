// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
// ============================================================================
//
// Major Function :      SoCKit_DDR3_RTL_Test
//
// ============================================================================
//
// Revision History :  
// ============================================================================
//   Ver  :| Author                    :| Mod. Date :| Changes Made:
//   V1.0 :| Young      					:| 04/07/13  :| Initial Revision
// ============================================================================

`define ENABLE_DDR3
//`define ENABLE_HPS
//`define ENABLE_HSMC_XCVR
module SoCKit_DDR3_RTL_Test(

							///////////AUD/////////////
							AUD_ADCDAT,
							AUD_ADCLRCK,
							AUD_BCLK,
							AUD_DACDAT,
							AUD_DACLRCK,
							AUD_I2C_SCLK,
							AUD_I2C_SDAT,
							AUD_MUTE,
							AUD_XCK,

`ifdef ENABLE_DDR3
							/////////DDR3/////////
							DDR3_A,
							DDR3_BA,
							DDR3_CAS_n,
							DDR3_CKE,
							DDR3_CK_n,
							DDR3_CK_p,
							DDR3_CS_n,
							DDR3_DM,
							DDR3_DQ,
							DDR3_DQS_n,
							DDR3_DQS_p,
							DDR3_ODT,
							DDR3_RAS_n,
							DDR3_RESET_n,
							DDR3_RZQ,
							DDR3_WE_n,
`endif /*ENABLE_DDR3*/

							/////////FAN/////////
							FAN_CTRL,

`ifdef ENABLE_HPS
							/////////HPS/////////
							HPS_CLOCK_25,
							HPS_CLOCK_50,
							HPS_CONV_USB_n,
							HPS_DDR3_A,
							HPS_DDR3_BA,
							HPS_DDR3_CAS_n,
							HPS_DDR3_CKE,
							HPS_DDR3_CK_n,
							HPS_DDR3_CK_p,
							HPS_DDR3_CS_n,
							HPS_DDR3_DM,
							HPS_DDR3_DQ,
							HPS_DDR3_DQS_n,
							HPS_DDR3_DQS_p,
							HPS_DDR3_ODT,
							HPS_DDR3_RAS_n,
							HPS_DDR3_RESET_n,
							HPS_DDR3_RZQ,
							HPS_DDR3_WE_n,
							HPS_ENET_GTX_CLK,
							HPS_ENET_INT_n,
							HPS_ENET_MDC,
							HPS_ENET_MDIO,
							HPS_ENET_RESET_n,
							HPS_ENET_RX_CLK,
							HPS_ENET_RX_DATA,
							HPS_ENET_RX_DV,
							HPS_ENET_TX_DATA,
							HPS_ENET_TX_EN,
							HPS_FLASH_DATA,
							HPS_FLASH_DCLK,
							HPS_FLASH_NCSO,
							HPS_GSENSOR_INT,
							HPS_I2C_CLK,
							HPS_I2C_SDA,
							HPS_KEY,
							HPS_LCM_D_C,
							HPS_LCM_RST_N,
							HPS_LCM_SPIM_CLK,
							HPS_LCM_SPIM_MISO,
							HPS_LCM_SPIM_MOSI,
							HPS_LCM_SPIM_SS,
							HPS_LED,
							HPS_LTC_GPIO,
							HPS_RESET_n,
							HPS_SD_CLK,
							HPS_SD_CMD,
							HPS_SD_DATA,
							HPS_SPIM_CLK,
							HPS_SPIM_MISO,
							HPS_SPIM_MOSI,
							HPS_SPIM_SS,
							HPS_SW,
							HPS_UART_RX,
							HPS_UART_TX,
							HPS_USB_CLKOUT,
							HPS_USB_DATA,
							HPS_USB_DIR,
							HPS_USB_NXT,
							HPS_USB_STP,
							HPS_WARM_RST_n,
`endif /*ENABLE_HPS*/

							/////////HSMC/////////
							HSMC_CLKIN_n,
							HSMC_CLKIN_p,
							HSMC_CLKOUT_n,
							HSMC_CLKOUT_p,
							HSMC_CLK_IN0,
							HSMC_CLK_OUT0,
							HSMC_D,
							
`ifdef ENABLE_HSMC_XCVR
							
							HSMC_GXB_RX_p,
							HSMC_GXB_TX_p,
							HSMC_REF_CLK_p,
`endif							
							HSMC_RX_n,
							HSMC_RX_p,
							HSMC_SCL,
							HSMC_SDA,
							HSMC_TX_n,
							HSMC_TX_p,

							/////////IRDA/////////
							IRDA_RXD,

							/////////KEY/////////
							KEY,

							/////////LED/////////
							LED,

							/////////OSC/////////
							OSC_50_B3B,
							OSC_50_B4A,
							OSC_50_B5B,
							OSC_50_B8A,

							/////////PCIE/////////
							PCIE_PERST_n,
							PCIE_WAKE_n,

							/////////RESET/////////
							RESET_n,

							/////////SI5338/////////
							SI5338_SCL,
							SI5338_SDA,

							/////////SW/////////
							SW,

							/////////TEMP/////////
							TEMP_CS_n,
							TEMP_DIN,
							TEMP_DOUT,
							TEMP_SCLK,

							/////////USB/////////
							USB_B2_CLK,
							USB_B2_DATA,
							USB_EMPTY,
							USB_FULL,
							USB_OE_n,
							USB_RD_n,
							USB_RESET_n,
							USB_SCL,
							USB_SDA,
							USB_WR_n,

							/////////VGA/////////
							VGA_B,
							VGA_BLANK_n,
							VGA_CLK,
							VGA_G,
							VGA_HS,
							VGA_R,
							VGA_SYNC_n,
							VGA_VS,

);

//=======================================================
//  PORT declarations
//=======================================================

///////// AUD /////////
input                                              AUD_ADCDAT;
inout                                              AUD_ADCLRCK;
inout                                              AUD_BCLK;
output                                             AUD_DACDAT;
inout                                              AUD_DACLRCK;
output                                             AUD_I2C_SCLK;
inout                                              AUD_I2C_SDAT;
output                                             AUD_MUTE;
output                                             AUD_XCK;

`ifdef ENABLE_DDR3
///////// DDR3 /////////
output                        [14:0]               DDR3_A;
output                        [2:0]                DDR3_BA;
output                                             DDR3_CAS_n;
output                                             DDR3_CKE;
output                                             DDR3_CK_n;
output                                             DDR3_CK_p;
output                                             DDR3_CS_n;
output                        [3:0]                DDR3_DM;
inout                         [31:0]               DDR3_DQ;
inout                         [3:0]                DDR3_DQS_n;
inout                         [3:0]                DDR3_DQS_p;
output                                             DDR3_ODT;
output                                             DDR3_RAS_n;
output                                             DDR3_RESET_n;
input                                              DDR3_RZQ;
output                                             DDR3_WE_n;
`endif /*ENABLE_DDR3*/

///////// FAN /////////
output                                             FAN_CTRL;

`ifdef ENABLE_HPS
///////// HPS /////////
input                                              HPS_CLOCK_25;
input                                              HPS_CLOCK_50;
input                                              HPS_CONV_USB_n;
output                        [14:0]               HPS_DDR3_A;
output                        [2:0]                HPS_DDR3_BA;
output                                             HPS_DDR3_CAS_n;
output                                             HPS_DDR3_CKE;
output                                             HPS_DDR3_CK_n;
output                                             HPS_DDR3_CK_p;
output                                             HPS_DDR3_CS_n;
output                        [3:0]                HPS_DDR3_DM;
inout                         [31:0]               HPS_DDR3_DQ;
inout                         [3:0]                HPS_DDR3_DQS_n;
inout                         [3:0]                HPS_DDR3_DQS_p;
output                                             HPS_DDR3_ODT;
output                                             HPS_DDR3_RAS_n;
output                                             HPS_DDR3_RESET_n;
input                                              HPS_DDR3_RZQ;
output                                             HPS_DDR3_WE_n;
input                                              HPS_ENET_GTX_CLK;
input                                              HPS_ENET_INT_n;
output                                             HPS_ENET_MDC;
inout                                              HPS_ENET_MDIO;
output															HPS_ENET_RESET_n;
input                                              HPS_ENET_RX_CLK;
input                         [3:0]                HPS_ENET_RX_DATA;
input                                              HPS_ENET_RX_DV;
output                        [3:0]                HPS_ENET_TX_DATA;
output                                             HPS_ENET_TX_EN;
inout                         [3:0]                HPS_FLASH_DATA;
output                                             HPS_FLASH_DCLK;
output                                             HPS_FLASH_NCSO;
input                                              HPS_GSENSOR_INT;
inout                                              HPS_I2C_CLK;
inout                                              HPS_I2C_SDA;
input                         [3:0]                HPS_KEY;
output                                             HPS_LCM_D_C;
output                                             HPS_LCM_RST_N;
input                                              HPS_LCM_SPIM_CLK;
inout                                              HPS_LCM_SPIM_MISO;
output                                             HPS_LCM_SPIM_MOSI;
output                                             HPS_LCM_SPIM_SS;
output                        [3:0]                HPS_LED;
inout                                              HPS_LTC_GPIO;
input                                              HPS_RESET_n;
output                                             HPS_SD_CLK;
inout                                              HPS_SD_CMD;
inout                         [3:0]                HPS_SD_DATA;
output                                             HPS_SPIM_CLK;
input                                              HPS_SPIM_MISO;
output                                             HPS_SPIM_MOSI;
output                                             HPS_SPIM_SS;
input                         [3:0]                HPS_SW;
input                                              HPS_UART_RX;
output                                             HPS_UART_TX;
input                                              HPS_USB_CLKOUT;
inout                         [7:0]                HPS_USB_DATA;
input                                              HPS_USB_DIR;
input                                              HPS_USB_NXT;
output                                             HPS_USB_STP;
input                                              HPS_WARM_RST_n;
`endif /*ENABLE_HPS*/

///////// HSMC /////////
inout                         [2:1]                HSMC_CLKIN_n;
inout                         [2:1]                HSMC_CLKIN_p;
inout                         [2:1]                HSMC_CLKOUT_n;
inout                         [2:1]                HSMC_CLKOUT_p;
inout                                              HSMC_CLK_IN0;
inout                                              HSMC_CLK_OUT0;
inout                         [3:0]                HSMC_D;

`ifdef ENABLE_HSMC_XCVR
input                         [7:0]                HSMC_GXB_RX_p;
output                        [7:0]                HSMC_GXB_TX_p;
input                                              HSMC_REF_CLK_p;
`endif

inout                         [16:0]               HSMC_RX_n;
inout                         [16:0]               HSMC_RX_p;
output                                             HSMC_SCL;
inout                                              HSMC_SDA;
inout                         [16:0]               HSMC_TX_n;
inout                         [16:0]               HSMC_TX_p;

///////// IRDA /////////
input                                              IRDA_RXD;

///////// KEY /////////
input                         [3:0]                KEY;

///////// LED /////////
output                        [3:0]                LED;

///////// OSC /////////
input                                              OSC_50_B3B;
input                                              OSC_50_B4A;
input                                              OSC_50_B5B;
input                                              OSC_50_B8A;

///////// PCIE /////////
input                                              PCIE_PERST_n;
input                                              PCIE_WAKE_n;

///////// RESET /////////
input                                              RESET_n;

///////// SI5338 /////////
inout                                              SI5338_SCL;
inout                                              SI5338_SDA;

///////// SW /////////
input                         [3:0]                SW;

///////// TEMP /////////
output                                             TEMP_CS_n;
output                                             TEMP_DIN;
input                                              TEMP_DOUT;
output                                             TEMP_SCLK;

///////// USB /////////
input                                              USB_B2_CLK;
inout                         [7:0]                USB_B2_DATA;
output                                             USB_EMPTY;
output                                             USB_FULL;
input                                              USB_OE_n;
input                                              USB_RD_n;
input                                              USB_RESET_n;
inout                                              USB_SCL;
inout                                              USB_SDA;
input                                              USB_WR_n;

///////// VGA /////////
output                        [7:0]                VGA_B;
output                                             VGA_BLANK_n;
output                                             VGA_CLK;
output                        [7:0]                VGA_G;
output                                             VGA_HS;
output                        [7:0]                VGA_R;
output                                             VGA_SYNC_n;
output                                             VGA_VS;


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire afi_clk; // clock for test controllers
/// test status ..
//DDR3 Verify (A)
wire fpga_ddr3_test_pass/*synthesis keep*/;
wire fpga_ddr3_test_fail/*synthesis keep*/;
wire fpga_ddr3_test_complete/*synthesis keep*/;
wire fpga_ddr3_local_init_done/*synthesis keep*/;
wire fpga_ddr3_local_cal_success/*synthesis keep*/;
wire fpga_ddr3_local_cal_fail/*synthesis keep*/;

assign FAN_CTRL = 1'bz;

//=======================================================
//  Structural coding
//=======================================================
  fpga_ddr3 fpga_ddr3_inst(
		/*input  wire         */    .pll_ref_clk(OSC_50_B4A),       
		/*input  wire         */    .global_reset_n(test_global_reset_n),    
		/*input  wire         */    .soft_reset_n(test_software_reset_n),      
		/*output wire         */    .afi_clk(afi_clk),           
		/*output wire         */    .afi_half_clk(),      
		/*output wire         */    .afi_reset_n(),       
		/*output wire [14:0]  */    .mem_a(DDR3_A),             
		/*output wire [2:0]   */    .mem_ba(DDR3_BA),            
		/*output wire [0:0]   */    .mem_ck(DDR3_CK_p),            
		/*output wire [0:0]   */    .mem_ck_n(DDR3_CK_n),          
		/*output wire [0:0]   */    .mem_cke(DDR3_CKE),           
		/*output wire [0:0]   */    .mem_cs_n(DDR3_CS_n),          
		/*output wire [3:0]   */    .mem_dm(DDR3_DM),            
		/*output wire [0:0]   */    .mem_ras_n(DDR3_RAS_n),         
		/*output wire [0:0]   */    .mem_cas_n(DDR3_CAS_n),         
		/*output wire [0:0]   */    .mem_we_n(DDR3_WE_n),          
		/*output wire         */    .mem_reset_n(DDR3_RESET_n),       
		/*inout  wire [31:0]  */    .mem_dq(DDR3_DQ),            
		/*inout  wire [3:0]   */    .mem_dqs(DDR3_DQS_p),           
		/*inout  wire [3:0]   */    .mem_dqs_n(DDR3_DQS_n),         
		/*output wire [0:0]   */    .mem_odt(DDR3_ODT),    
		
		/*output wire         */    .avl_ready(fpga_ddr3_avl_ready),         
		/*input  wire         */    .avl_burstbegin(fpga_ddr3_avl_burstbegin),    
		/*input  wire [25:0]  */    .avl_addr(fpga_ddr3_avl_addr),          
		/*output wire         */    .avl_rdata_valid(fpga_ddr3_avl_rdata_valid),   
		/*output wire [127:0] */    .avl_rdata(fpga_ddr3_avl_rdata),         
		/*input  wire [127:0] */    .avl_wdata(fpga_ddr3_avl_wdata),         
		/*input  wire [15:0]  */    .avl_be(16'hFFFF),            
		/*input  wire         */    .avl_read_req(fpga_ddr3_avl_read_req),      
		/*input  wire         */    .avl_write_req(fpga_ddr3_avl_write_req),     
		/*input  wire [2:0]   */    .avl_size(fpga_ddr3_avl_size),          
		/*output wire         */    .local_init_done(fpga_ddr3_local_init_done),   
		/*output wire         */    .local_cal_success(fpga_ddr3_local_cal_success), 
		/*output wire         */    .local_cal_fail(fpga_ddr3_local_cal_fail),    

		/*input  wire         */    .oct_rzqin(DDR3_RZQ)          
	);

	/////////////////// DDR3(A) Test ///////////////////
wire         fpga_ddr3_avl_ready;                  //          avl.waitrequest_n
wire         fpga_ddr3_avl_burstbegin;             //             .beginbursttransfer
wire [25:0]  fpga_ddr3_avl_addr;                   //             .address
wire         fpga_ddr3_avl_rdata_valid;            //             .readdatavalid
wire [127:0] fpga_ddr3_avl_rdata;                  //             .readdata
wire [127:0] fpga_ddr3_avl_wdata;                  //             .writedata
wire         fpga_ddr3_avl_read_req;               //             .read
wire         fpga_ddr3_avl_write_req;              //             .write
wire [2:0]   fpga_ddr3_avl_size;                   //             .burstcount

assign fpga_ddr3_avl_size = 3'b001;

Avalon_bus_RW_Test fpga_ddr3_Verify(
		.iCLK(afi_clk),
		.iRST_n(test_software_reset_n),
		.iBUTTON(test_start_n),

		.local_init_done(fpga_ddr3_local_init_done),
		.avl_waitrequest_n(fpga_ddr3_avl_ready),                 
		.avl_address(fpga_ddr3_avl_addr),                      
		.avl_readdatavalid(fpga_ddr3_avl_rdata_valid),                 
		.avl_readdata(fpga_ddr3_avl_rdata),                      
		.avl_writedata(fpga_ddr3_avl_wdata),                     
		.avl_read(fpga_ddr3_avl_read_req),                          
		.avl_write(fpga_ddr3_avl_write_req),    
		.avl_burstbegin(fpga_ddr3_avl_burstbegin),
		
		.drv_status_pass(fpga_ddr3_test_pass),
		.drv_status_fail(fpga_ddr3_test_fail),
		.drv_status_test_complete(fpga_ddr3_test_complete),
);

	
//////////////////////////////////////////////
// nios control

wire test_software_reset_n;
wire test_global_reset_n;
wire test_start_n;

 
// / //////////////////////////////////////////////
// reset_n and start_n control
reg [31:0]  cont;
always@(posedge OSC_50_B3B)
cont<=(cont==32'd4_000_001)?32'd0:cont+1'b1;

reg[4:0] sample;
always@(posedge OSC_50_B3B)
begin
	if(cont==32'd4_000_000)
		sample[4:0]={sample[3:0],KEY[0]};
	else 
		sample[4:0]=sample[4:0];
end

assign test_software_reset_n=(sample[1:0]==2'b10)?1'b0:1'b1;
assign test_global_reset_n   =(sample[3:2]==2'b10)?1'b0:1'b1;
assign test_start_n         =(sample[4:3]==2'b01)?1'b0:1'b1;


wire [2:0] test_result;
assign test_result[0] = KEY[0];
assign test_result[1] = (fpga_ddr3_local_init_done& fpga_ddr3_local_cal_success) ? (fpga_ddr3_test_complete? fpga_ddr3_test_pass : heart_beat[23]):1'b0;
assign test_result[2] =  heart_beat[23];


assign LED[2:0] = KEY[0]?test_result:4'b1111;
	
reg [23:0] heart_beat;
always @ (posedge OSC_50_B3B)
begin
	heart_beat <= heart_beat + 1;
end
			
			
endmodule
