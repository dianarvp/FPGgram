
# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 15.1 193 linux 2016.04.13.04:40:52

# ----------------------------------------
# vcs - auto-generated simulation script

# ----------------------------------------
# This script can be used to simulate the following IP:
#     fpga_ddr3
# To create a top-level simulation script which compiles other
# IP, and manages other system issues, copy the following template
# and adapt it to your needs:
# 
# # Start of template
# # If the copied and modified template file is "vcs_sim.sh", run it as:
# #   ./vcs_sim.sh
# #
# # Override the top-level name
# # specify a command file containing elaboration options 
# # (system verilog extension, and compile the top-level).
# # Override the user-defined sim options, so the simulation 
# # runs forever (until $finish()).
# source vcs_setup.sh \
# TOP_LEVEL_NAME=top \
# USER_DEFINED_ELAB_OPTIONS="'-f ../../../synopsys_vcs.f'" \
# USER_DEFINED_SIM_OPTIONS=""
# 
# # helper file: synopsys_vcs.f
# +systemverilogext+.sv
# ../../../top.sv
# # End of template
# ----------------------------------------
# If fpga_ddr3 is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 15.1 193 linux 2016.04.13.04:40:52
# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="fpga_ddr3"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="/home/diana/altera_lite/15.1/quartus/"
SKIP_FILE_COPY=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"
# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_AC_ROM.hex ./
  cp -f $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_inst_ROM.hex ./
  cp -f $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_sequencer_mem.hex ./
fi

vcs -lca -timescale=1ps/1ps -sverilog +verilog2001ext+.v -ntb_opts dtm $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v \
  $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hmi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hssi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_pcie_hip_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_slave_translator.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_master_translator.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_reset_controller.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_reset_synchronizer.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_dmaster_p2b_adapter.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_dmaster_b2p_adapter.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_packets_to_master.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_packets_to_bytes.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_bytes_to_packets.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_sc_fifo.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_dmaster_timing_adt.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_jtag_interface.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_jtag_dc_streaming.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_jtag_sld_node.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_jtag_streaming.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_clock_crosser.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_std_synchronizer_nocut.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_pipeline_base.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_idle_remover.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_idle_inserter.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_st_pipeline_stage.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_mm_interconnect_1.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_dll_cyclonev.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_oct_cyclonev.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_hard_memory_controller_top_cyclonev.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_dmaster.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_router_002.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_sequencer_cpu_cv_sim_cpu_inst.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_slave_agent.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_cmd_mux.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_cmd_mux_001.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_reorder_memory.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_router_003.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_arbitrator.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_rsp_mux_002.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_rsp_mux_001.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_reg_file.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_siii_phase_decode.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_cmd_mux_003.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_acv_wrapper.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_irq_mapper.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_router_001.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_avalon_st_adapter.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_avalon_mm_bridge.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_rsp_demux_001.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_traffic_limiter.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_sv_phase_decode.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_router_006.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_router.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_router_004.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_cmd_demux_002.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_sequencer_mem_no_ifdef_params.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_sequencer_rst.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_rsp_mux.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_sv_wrapper.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_burst_uncompressor.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_reg_file.v \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_simple_avalon_mm_bridge.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_merlin_master_agent.sv \
  $QSYS_SIMDIR/fpga_ddr3/altera_mem_if_sequencer_cpu_cv_sim_cpu_inst_test_bench.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_cmd_demux_001.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_acv_phase_decode.v \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_mgr.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_cmd_demux.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_s0_mm_interconnect_0_rsp_demux_003.sv \
  $QSYS_SIMDIR/fpga_ddr3/sequencer_scc_siii_wrapper.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_clock_pair_generator.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_acv_hard_addr_cmd_pads.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_acv_hard_memphy.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_acv_ldc.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_acv_hard_io_pads.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_generic_ddio.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_reset.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_reset_sync.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_phy_csr.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_iss_probe.v \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_p0_altdqdqs.v \
  $QSYS_SIMDIR/fpga_ddr3/altdq_dqs2_acv_connect_to_hard_phy_cyclonev.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_pll0.sv \
  $QSYS_SIMDIR/fpga_ddr3/fpga_ddr3_0002.v \
  $QSYS_SIMDIR/fpga_ddr3.v \
  -top $TOP_LEVEL_NAME
# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
