// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// megafunction wizard: %ALTECC%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altecc_encoder 

// ============================================================
// File Name: alt_mem_ddrx_ecc_encoder_64.v
// Megafunction Name(s):
// 			altecc_encoder
//
// Simulation Library Files(s):
// 			
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 10.0 Build 262 08/18/2010 SP 1 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2010 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altecc_encoder device_family="Stratix III" lpm_pipeline=0 width_codeword=72 width_dataword=64 data q
//VERSION_BEGIN 10.0SP1 cbx_altecc_encoder 2010:08:18:21:16:35:SJ cbx_mgl 2010:08:18:21:20:44:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  alt_mem_ddrx_ecc_encoder_64_altecc_encoder #
    ( parameter
        CFG_ECC_ENC_REG = 0
    )
	(
        clk,
        reset_n,
	    data,
	    q
    ) /* synthesis synthesis_clearbox=1 */;
    input           clk;
    input           reset_n;
	input   [63:0]  data;
	output   [71:0]  q;

	wire  [63:0]  data_wire;
	wire  [34:0]  parity_01_wire;
	wire  [17:0]  parity_02_wire;
	wire  [8:0]   parity_03_wire;
	wire  [3:0]   parity_04_wire;
	wire  [1:0]   parity_05_wire;
	wire  [30:0]  parity_06_wire;
	wire  [6:0]   parity_07_wire;
    wire  [70:0]  parity_final;
	wire  [70:0]  parity_final_wire;
    reg   [70:0]  parity_final_reg;
	wire  [70:0]  q_wire;
    reg   [70:0]  q_reg;
    
	assign
		data_wire = data,
		parity_01_wire = {
                            (data_wire[63] ^ parity_01_wire[33]),
                            (data_wire[61] ^ parity_01_wire[32]),
                            (data_wire[59] ^ parity_01_wire[31]),
                            (data_wire[57] ^ parity_01_wire[30]),
                            (data_wire[56] ^ parity_01_wire[29]),
                            (data_wire[54] ^ parity_01_wire[28]),
                            (data_wire[52] ^ parity_01_wire[27]),
                            (data_wire[50] ^ parity_01_wire[26]),
                            (data_wire[48] ^ parity_01_wire[25]),
                            (data_wire[46] ^ parity_01_wire[24]),
                            (data_wire[44] ^ parity_01_wire[23]),
                            (data_wire[42] ^ parity_01_wire[22]),
                            (data_wire[40] ^ parity_01_wire[21]),
                            (data_wire[38] ^ parity_01_wire[20]),
                            (data_wire[36] ^ parity_01_wire[19]),
                            (data_wire[34] ^ parity_01_wire[18]),
                            (data_wire[32] ^ parity_01_wire[17]),
                            (data_wire[30] ^ parity_01_wire[16]),
                            (data_wire[28] ^ parity_01_wire[15]),
                            (data_wire[26] ^ parity_01_wire[14]),
                            (data_wire[25] ^ parity_01_wire[13]),
                            (data_wire[23] ^ parity_01_wire[12]),
                            (data_wire[21] ^ parity_01_wire[11]),
                            (data_wire[19] ^ parity_01_wire[10]),
                            (data_wire[17] ^ parity_01_wire[9]),
                            (data_wire[15] ^ parity_01_wire[8]),
                            (data_wire[13] ^ parity_01_wire[7]),
                            (data_wire[11] ^ parity_01_wire[6]),
                            (data_wire[10] ^ parity_01_wire[5]),
                            (data_wire[8] ^ parity_01_wire[4]),
                            (data_wire[6] ^ parity_01_wire[3]),
                            (data_wire[4] ^ parity_01_wire[2]),
                            (data_wire[3] ^ parity_01_wire[1]),
                            (data_wire[1] ^ parity_01_wire[0]),
                            data_wire[0]
                         },
		parity_02_wire = {
                            ((data_wire[62] ^ data_wire[63]) ^ parity_02_wire[16]),
                            ((data_wire[58] ^ data_wire[59]) ^ parity_02_wire[15]),
                            ((data_wire[55] ^ data_wire[56]) ^ parity_02_wire[14]),
                            ((data_wire[51] ^ data_wire[52]) ^ parity_02_wire[13]),
                            ((data_wire[47] ^ data_wire[48]) ^ parity_02_wire[12]),
                            ((data_wire[43] ^ data_wire[44]) ^ parity_02_wire[11]),
                            ((data_wire[39] ^ data_wire[40]) ^ parity_02_wire[10]),
                            ((data_wire[35] ^ data_wire[36]) ^ parity_02_wire[9]),
                            ((data_wire[31] ^ data_wire[32]) ^ parity_02_wire[8]),
                            ((data_wire[27] ^ data_wire[28]) ^ parity_02_wire[7]),
                            ((data_wire[24] ^ data_wire[25]) ^ parity_02_wire[6]),
                            ((data_wire[20] ^ data_wire[21]) ^ parity_02_wire[5]),
                            ((data_wire[16] ^ data_wire[17]) ^ parity_02_wire[4]),
                            ((data_wire[12] ^ data_wire[13]) ^ parity_02_wire[3]),
                            ((data_wire[9] ^ data_wire[10]) ^ parity_02_wire[2]),
                            ((data_wire[5] ^ data_wire[6]) ^ parity_02_wire[1]),
                            ((data_wire[2] ^ data_wire[3]) ^ parity_02_wire[0]),
                            data_wire[0]
                         },
		parity_03_wire = {
                            ((((data_wire[60] ^ data_wire[61]) ^ data_wire[62]) ^ data_wire[63]) ^ parity_03_wire[7]),
                            ((((data_wire[53] ^ data_wire[54]) ^ data_wire[55]) ^ data_wire[56]) ^ parity_03_wire[6]),
                            ((((data_wire[45] ^ data_wire[46]) ^ data_wire[47]) ^ data_wire[48]) ^ parity_03_wire[5]),
                            ((((data_wire[37] ^ data_wire[38]) ^ data_wire[39]) ^ data_wire[40]) ^ parity_03_wire[4]),
                            ((((data_wire[29] ^ data_wire[30]) ^ data_wire[31]) ^ data_wire[32]) ^ parity_03_wire[3]),
                            ((((data_wire[22] ^ data_wire[23]) ^ data_wire[24]) ^ data_wire[25]) ^ parity_03_wire[2]),
                            ((((data_wire[14] ^ data_wire[15]) ^ data_wire[16]) ^ data_wire[17]) ^ parity_03_wire[1]),
                            ((((data_wire[7] ^ data_wire[8]) ^ data_wire[9]) ^ data_wire[10]) ^ parity_03_wire[0]),
                            ((data_wire[1] ^ data_wire[2]) ^ data_wire[3])
                         },
		parity_04_wire = {
                            ((((((((data_wire[49] ^ data_wire[50]) ^ data_wire[51]) ^ data_wire[52]) ^ data_wire[53]) ^ data_wire[54]) ^ data_wire[55]) ^ data_wire[56]) ^ parity_04_wire[2]),
                            ((((((((data_wire[33] ^ data_wire[34]) ^ data_wire[35]) ^ data_wire[36]) ^ data_wire[37]) ^ data_wire[38]) ^ data_wire[39]) ^ data_wire[40]) ^ parity_04_wire[1]),
                            ((((((((data_wire[18] ^ data_wire[19]) ^ data_wire[20]) ^ data_wire[21]) ^ data_wire[22]) ^ data_wire[23]) ^ data_wire[24]) ^ data_wire[25]) ^ parity_04_wire[0]),
                            ((((((data_wire[4] ^ data_wire[5]) ^ data_wire[6]) ^ data_wire[7]) ^ data_wire[8]) ^ data_wire[9]) ^ data_wire[10])
                         },
		parity_05_wire = {
                            ((((((((((((((((data_wire[41] ^ data_wire[42]) ^ data_wire[43]) ^ data_wire[44]) ^ data_wire[45]) ^ data_wire[46]) ^ data_wire[47]) ^ data_wire[48]) ^ data_wire[49]) ^ data_wire[50]) ^ data_wire[51]) ^ data_wire[52]) ^ data_wire[53]) ^ data_wire[54]) ^ data_wire[55]) ^ data_wire[56]) ^ parity_05_wire[0]),
                            ((((((((((((((data_wire[11] ^ data_wire[12]) ^ data_wire[13]) ^ data_wire[14]) ^ data_wire[15]) ^ data_wire[16]) ^ data_wire[17]) ^ data_wire[18]) ^ data_wire[19]) ^ data_wire[20]) ^ data_wire[21]) ^ data_wire[22]) ^ data_wire[23]) ^ data_wire[24]) ^ data_wire[25])
                         },
		parity_06_wire = {
                            (data_wire[56] ^ parity_06_wire[29]),
                            (data_wire[55] ^ parity_06_wire[28]),
                            (data_wire[54] ^ parity_06_wire[27]),
                            (data_wire[53] ^ parity_06_wire[26]),
                            (data_wire[52] ^ parity_06_wire[25]),
                            (data_wire[51] ^ parity_06_wire[24]),
                            (data_wire[50] ^ parity_06_wire[23]),
                            (data_wire[49] ^ parity_06_wire[22]),
                            (data_wire[48] ^ parity_06_wire[21]),
                            (data_wire[47] ^ parity_06_wire[20]),
                            (data_wire[46] ^ parity_06_wire[19]),
                            (data_wire[45] ^ parity_06_wire[18]),
                            (data_wire[44] ^ parity_06_wire[17]),
                            (data_wire[43] ^ parity_06_wire[16]),
                            (data_wire[42] ^ parity_06_wire[15]),
                            (data_wire[41] ^ parity_06_wire[14]),
                            (data_wire[40] ^ parity_06_wire[13]),
                            (data_wire[39] ^ parity_06_wire[12]),
                            (data_wire[38] ^ parity_06_wire[11]),
                            (data_wire[37] ^ parity_06_wire[10]),
                            (data_wire[36] ^ parity_06_wire[9]),
                            (data_wire[35] ^ parity_06_wire[8]),
                            (data_wire[34] ^ parity_06_wire[7]),
                            (data_wire[33] ^ parity_06_wire[6]),
                            (data_wire[32] ^ parity_06_wire[5]),
                            (data_wire[31] ^ parity_06_wire[4]),
                            (data_wire[30] ^ parity_06_wire[3]),
                            (data_wire[29] ^ parity_06_wire[2]),
                            (data_wire[28] ^ parity_06_wire[1]),
                            (data_wire[27] ^ parity_06_wire[0]),
                            data_wire[26]
                         },
		parity_07_wire = {
                            (data_wire[63] ^ parity_07_wire[5]),
                            (data_wire[62] ^ parity_07_wire[4]),
                            (data_wire[61] ^ parity_07_wire[3]),
                            (data_wire[60] ^ parity_07_wire[2]),
                            (data_wire[59] ^ parity_07_wire[1]),
                            (data_wire[58] ^ parity_07_wire[0]),
                            data_wire[57]
                         },
		parity_final_wire = {
                                (q_wire[70] ^ parity_final_wire[69]),
                                (q_wire[69] ^ parity_final_wire[68]),
                                (q_wire[68] ^ parity_final_wire[67]),
                                (q_wire[67] ^ parity_final_wire[66]),
                                (q_wire[66] ^ parity_final_wire[65]),
                                (q_wire[65] ^ parity_final_wire[64]),
                                (q_wire[64] ^ parity_final_wire[63]),
                                (q_wire[63] ^ parity_final_wire[62]),
                                (q_wire[62] ^ parity_final_wire[61]),
                                (q_wire[61] ^ parity_final_wire[60]),
                                (q_wire[60] ^ parity_final_wire[59]),
                                (q_wire[59] ^ parity_final_wire[58]),
                                (q_wire[58] ^ parity_final_wire[57]),
                                (q_wire[57] ^ parity_final_wire[56]),
                                (q_wire[56] ^ parity_final_wire[55]),
                                (q_wire[55] ^ parity_final_wire[54]),
                                (q_wire[54] ^ parity_final_wire[53]),
                                (q_wire[53] ^ parity_final_wire[52]),
                                (q_wire[52] ^ parity_final_wire[51]),
                                (q_wire[51] ^ parity_final_wire[50]),
                                (q_wire[50] ^ parity_final_wire[49]),
                                (q_wire[49] ^ parity_final_wire[48]),
                                (q_wire[48] ^ parity_final_wire[47]),
                                (q_wire[47] ^ parity_final_wire[46]),
                                (q_wire[46] ^ parity_final_wire[45]),
                                (q_wire[45] ^ parity_final_wire[44]),
                                (q_wire[44] ^ parity_final_wire[43]),
                                (q_wire[43] ^ parity_final_wire[42]),
                                (q_wire[42] ^ parity_final_wire[41]),
                                (q_wire[41] ^ parity_final_wire[40]),
                                (q_wire[40] ^ parity_final_wire[39]),
                                (q_wire[39] ^ parity_final_wire[38]),
                                (q_wire[38] ^ parity_final_wire[37]),
                                (q_wire[37] ^ parity_final_wire[36]),
                                (q_wire[36] ^ parity_final_wire[35]),
                                (q_wire[35] ^ parity_final_wire[34]),
                                (q_wire[34] ^ parity_final_wire[33]),
                                (q_wire[33] ^ parity_final_wire[32]),
                                (q_wire[32] ^ parity_final_wire[31]),
                                (q_wire[31] ^ parity_final_wire[30]),
                                (q_wire[30] ^ parity_final_wire[29]),
                                (q_wire[29] ^ parity_final_wire[28]),
                                (q_wire[28] ^ parity_final_wire[27]),
                                (q_wire[27] ^ parity_final_wire[26]),
                                (q_wire[26] ^ parity_final_wire[25]),
                                (q_wire[25] ^ parity_final_wire[24]),
                                (q_wire[24] ^ parity_final_wire[23]),
                                (q_wire[23] ^ parity_final_wire[22]),
                                (q_wire[22] ^ parity_final_wire[21]),
                                (q_wire[21] ^ parity_final_wire[20]),
                                (q_wire[20] ^ parity_final_wire[19]),
                                (q_wire[19] ^ parity_final_wire[18]),
                                (q_wire[18] ^ parity_final_wire[17]),
                                (q_wire[17] ^ parity_final_wire[16]),
                                (q_wire[16] ^ parity_final_wire[15]),
                                (q_wire[15] ^ parity_final_wire[14]),
                                (q_wire[14] ^ parity_final_wire[13]),
                                (q_wire[13] ^ parity_final_wire[12]),
                                (q_wire[12] ^ parity_final_wire[11]),
                                (q_wire[11] ^ parity_final_wire[10]),
                                (q_wire[10] ^ parity_final_wire[9]),
                                (q_wire[9]  ^ parity_final_wire[8]),
                                (q_wire[8]  ^ parity_final_wire[7]),
                                (q_wire[7]  ^ parity_final_wire[6]),
                                (q_wire[6]  ^ parity_final_wire[5]),
                                (q_wire[5]  ^ parity_final_wire[4]),
                                (q_wire[4]  ^ parity_final_wire[3]),
                                (q_wire[3]  ^ parity_final_wire[2]),
                                (q_wire[2]  ^ parity_final_wire[1]),
                                (q_wire[1]  ^ parity_final_wire[0]),
                                 q_wire[0]
                            },
        parity_final = {
                            (q_reg[70] ^ parity_final[69]),
                            (q_reg[69] ^ parity_final[68]),
                            (q_reg[68] ^ parity_final[67]),
                            (q_reg[67] ^ parity_final[66]),
                            (q_reg[66] ^ parity_final[65]),
                            (q_reg[65] ^ parity_final[64]),
                            parity_final_reg [64 : 0]
                       },
		q = {parity_final[70], q_reg},
		q_wire = {parity_07_wire[6], parity_06_wire[30], parity_05_wire[1], parity_04_wire[3], parity_03_wire[8], parity_02_wire[17], parity_01_wire[34], data_wire};
        
        generate
            if (CFG_ECC_ENC_REG)
            begin
                always @ (posedge clk or negedge reset_n)
                begin
                    if (!reset_n)
                    begin
                        q_reg            <= 0;
                        parity_final_reg <= 0;
                    end
                    else
                    begin
                        q_reg            <= q_wire;
                        parity_final_reg <= parity_final_wire;
                    end
                end
            end
            else
            begin
                always @ (*)
                begin
                    q_reg            = q_wire;
                    parity_final_reg = parity_final_wire;
                end
            end
        endgenerate
endmodule //alt_mem_ddrx_ecc_encoder_64_altecc_encoder
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module alt_mem_ddrx_ecc_encoder_64 #
    ( parameter
        CFG_ECC_ENC_REG = 0
    )
    (
        clk,
        reset_n,
	    data,
	    q
    )/* synthesis synthesis_clearbox = 1 */;

    input           clk;
    input           reset_n;
	input	[63:0]  data;
	output	[71:0]  q;

	wire [71:0] sub_wire0;
	wire [71:0] q = sub_wire0[71:0];

	alt_mem_ddrx_ecc_encoder_64_altecc_encoder #
        (
            .CFG_ECC_ENC_REG (CFG_ECC_ENC_REG)
        )
    alt_mem_ddrx_ecc_encoder_64_altecc_encoder_component
        (
            .clk (clk),
            .reset_n (reset_n),
		    .data (data),
		    .q (sub_wire0)
        );

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix III"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix III"
// Retrieval info: CONSTANT: lpm_pipeline NUMERIC "0"
// Retrieval info: CONSTANT: width_codeword NUMERIC "72"
// Retrieval info: CONSTANT: width_dataword NUMERIC "64"
// Retrieval info: USED_PORT: data 0 0 64 0 INPUT NODEFVAL "data[63..0]"
// Retrieval info: USED_PORT: q 0 0 72 0 OUTPUT NODEFVAL "q[71..0]"
// Retrieval info: CONNECT: @data 0 0 64 0 data 0 0 64 0
// Retrieval info: CONNECT: q 0 0 72 0 @q 0 0 72 0
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_bb.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32_bb.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_32_syn.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64_bb.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_mem_ddrx_ecc_encoder_64_syn.v TRUE
