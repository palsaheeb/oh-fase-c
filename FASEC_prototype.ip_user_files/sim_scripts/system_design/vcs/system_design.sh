#!/bin/bash -f
# Vivado (TM) v2016.2 (64-bit)
#
# Filename    : system_design.sh
# Simulator   : Synopsys Verilog Compiler Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Wed Oct 19 10:09:32 CEST 2016
# IP Build 1577682 on Fri Jun  3 12:00:54 MDT 2016 
#
# usage: system_design.sh [-help]
# usage: system_design.sh [-lib_map_path]
# usage: system_design.sh [-noclean_files]
# usage: system_design.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'system_design.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
# ********************************************************************************************************

# Directory path for design sources and include directories (if any) wrt this path
ref_dir="."

# Override directory with 'export_sim_ref_dir' env path value if set in the shell
if [[ (! -z "$export_sim_ref_dir") && ($export_sim_ref_dir != "") ]]; then
  ref_dir="$export_sim_ref_dir"
fi

# Command line options
vlogan_opts="-full64 -timescale=1ps/1ps"
vhdlan_opts="-full64"
vcs_elab_opts="-load "/local/EDA/Xilinx/Vivado/2016.2/lib/lnx64.o/libxil_vcs.so:xilinx_register_systf" -full64 -debug_pp -t ps -licqueue -l elaborate.log"
vcs_sim_opts="-ucli -licqueue -l simulate.log"

# Design libraries
design_libs=(processing_system7_bfm_v2_0_5 xil_defaultlib xil_pvtmisc lib_cdc_v1_0_2 proc_sys_reset_v5_0_9 generic_baseblocks_v2_1_0 axi_infrastructure_v1_1_0 axi_register_slice_v2_1_9 fifo_generator_v13_1_1 axi_data_fifo_v2_1_8 axi_crossbar_v2_1_10 axi_protocol_converter_v2_1_9)

# Simulation root library directory
sim_lib_dir="vcs"

# Script info
echo -e "system_design.sh - Script generated by export_simulation (Vivado v2016.2 (64-bit)-id)\n"

# Main steps
run()
{
  check_args $# $1
  setup $1 $2
  compile
  elaborate
  simulate
}

# RUN_STEP: <compile>
compile()
{
  # Compile design files
  vlogan -work processing_system7_bfm_v2_0_5 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr_4.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd_4.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp2_3.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp0_1.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ssw_hp.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_sparse_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_reg_map.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocm_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_wr_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_rd_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_fmsw_gp.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_regc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocmc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_interconnect_model.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_reset.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_clock.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ddrc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_slave.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_master.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_afi_slave.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_processing_system7_bfm.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/system_design/ip/system_design_processing_system7_0_0/sim/system_design_processing_system7_0_0.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/system_design/hdl/system_design.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_pvtmisc $vhdlan_opts \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/doubleBufferEdge.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/clockDivider.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/shiftRegister.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/myPackage.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/doubleBufferVector.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/doubleBuffer.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/axis_wbm_bridge.vhd" \
    "$ref_dir/../../../../FASEC_prototype.srcs/sources_1/bd/system_design/ipshared/cern.ch/xil_pvtmisc_v1_1/axi4lite_slave.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/system_design/ipshared/user.org/fasec_hwtest_v2_5_2/FASEC_hwtest.srcs/sources_1/new/general_fmc.vhd" \
    "$ref_dir/../../../bd/system_design/ipshared/user.org/fasec_hwtest_v2_5_2/FASEC_hwtest.srcs/sources_1/new/top_mod.vhd" \
    "$ref_dir/../../../bd/system_design/ip/system_design_fasec_hwtest_0_0/sim/system_design_fasec_hwtest_0_0.vhd" \
    "$ref_dir/../../../bd/system_design/ipshared/user.org/axi_wb_i2c_master_v2_5/src/i2c_master_bit_ctrl.vhd" \
    "$ref_dir/../../../bd/system_design/ipshared/user.org/axi_wb_i2c_master_v2_5/src/i2c_master_byte_ctrl.vhd" \
    "$ref_dir/../../../bd/system_design/ipshared/user.org/axi_wb_i2c_master_v2_5/src/i2c_master_top.vhd" \
    "$ref_dir/../../../bd/system_design/ipshared/user.org/axi_wb_i2c_master_v2_5/src/axis_to_i2c_wbs_v1_0.vhd" \
    "$ref_dir/../../../bd/system_design/ip/system_design_axi_wb_i2c_master_0_0/sim/system_design_axi_wb_i2c_master_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work lib_cdc_v1_0_2 $vhdlan_opts \
    "$ref_dir/../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work proc_sys_reset_v5_0_9 $vhdlan_opts \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/system_design/ip/system_design_rst_processing_system7_0_100M_2/sim/system_design_rst_processing_system7_0_100M_2.vhd" \
    "$ref_dir/../../../bd/system_design/ip/system_design_axi_wb_i2c_master_1_0/sim/system_design_axi_wb_i2c_master_1_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work generic_baseblocks_v2_1_0 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_infrastructure_v1_1_0 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_register_slice_v2_1_9 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
    "$ref_dir/../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work fifo_generator_v13_1_1 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_1/simulation/fifo_generator_vlog_beh.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work fifo_generator_v13_1_1 $vhdlan_opts \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work fifo_generator_v13_1_1 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_data_fifo_v2_1_8 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_crossbar_v2_1_10 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/system_design/ip/system_design_xbar_0/sim/system_design_xbar_0.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_protocol_converter_v2_1_9 $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/system_design/ip/system_design_auto_pc_0/sim/system_design_auto_pc_0.v" \
  2>&1 | tee -a vlogan.log


  vlogan -work xil_defaultlib $vlogan_opts +v2k \
    glbl.v \
  2>&1 | tee -a vlogan.log

}

# RUN_STEP: <elaborate>
elaborate()
{
  vcs $vcs_elab_opts xil_defaultlib.system_design xil_defaultlib.glbl -o system_design_simv
}

# RUN_STEP: <simulate>
simulate()
{
  ./system_design_simv $vcs_sim_opts -do simulate.do
}

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./system_design.sh -help\" for more information)\n"
        exit 1
      fi
      create_lib_mappings $2
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
      create_lib_mappings $2
  esac

  create_lib_dir

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Define design library mappings
create_lib_mappings()
{
  file="synopsys_sim.setup"
  if [[ -e $file ]]; then
    if [[ ($1 == "") ]]; then
      return
    else
      rm -rf $file
    fi
  fi

  touch $file

  lib_map_path=""
  if [[ ($1 != "") ]]; then
    lib_map_path="$1"
  fi

  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    mapping="$lib:$sim_lib_dir/$lib"
    echo $mapping >> $file
  done

  if [[ ($lib_map_path != "") ]]; then
    incl_ref="OTHERS=$lib_map_path/synopsys_sim.setup"
    echo $incl_ref >> $file
  fi
}

# Create design library directory paths
create_lib_dir()
{
  if [[ -e $sim_lib_dir ]]; then
    rm -rf $sim_lib_dir
  fi

  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    lib_dir="$sim_lib_dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
    fi
  done
}

# Delete generated data from the previous run
reset_run()
{
  files_to_remove=(ucli.key system_design_simv vlogan.log vhdlan.log compile.log elaborate.log simulate.log .vlogansetup.env .vlogansetup.args .vcs_lib_lock scirocco_command.log 64 AN.DB csrc system_design_simv.daidir)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done

  create_lib_dir
}

# Check command line arguments
check_args()
{
  if [[ ($1 == 1 ) && ($2 != "-lib_map_path" && $2 != "-noclean_files" && $2 != "-reset_run" && $2 != "-help" && $2 != "-h") ]]; then
    echo -e "ERROR: Unknown option specified '$2' (type \"./system_design.sh -help\" for more information)\n"
    exit 1
  fi

  if [[ ($2 == "-help" || $2 == "-h") ]]; then
    usage
  fi
}

# Script usage
usage()
{
  msg="Usage: system_design.sh [-help]\n\
Usage: system_design.sh [-lib_map_path]\n\
Usage: system_design.sh [-reset_run]\n\
Usage: system_design.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

# Launch script
run $1 $2
