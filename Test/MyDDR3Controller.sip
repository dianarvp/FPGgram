set_global_assignment -entity "MyDDR3Controller" -library "lib_MyDDR3Controller" -name IP_TOOL_NAME "altera_mem_if_ddr3_emif"
set_global_assignment -entity "MyDDR3Controller" -library "lib_MyDDR3Controller" -name IP_TOOL_VERSION "15.1"
set_global_assignment -entity "MyDDR3Controller" -library "lib_MyDDR3Controller" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_MyDDR3Controller" -name SPD_FILE [file join $::quartus(sip_path) "MyDDR3Controller.spd"]

set_global_assignment -library "lib_MyDDR3Controller" -name MISC_FILE [file join $::quartus(sip_path) "MyDDR3Controller_sim/MyDDR3Controller.vhd"]
set_global_assignment -library "lib_MyDDR3Controller" -name MISC_FILE [file join $::quartus(sip_path) "MyDDR3Controller_sim/MyDDR3Controller/MyDDR3Controller_0002.vhd"]
set_global_assignment -library "lib_MyDDR3Controller" -name MISC_FILE [file join $::quartus(sip_path) "MyDDR3Controller_sim/MyDDR3Controller/MyDDR3Controller_pll0.vho"]
set_global_assignment -library "lib_MyDDR3Controller" -name MISC_FILE [file join $::quartus(sip_path) "MyDDR3Controller_sim/MyDDR3Controller/MyDDR3Controller_pll0_sim_delay.vhd"]
