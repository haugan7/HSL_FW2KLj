
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:c_counter_binary:12.0\
xilinx.com:ip:c_shift_ram:12.0\
xilinx.com:user:drp_bridge:1.0\
sintef.no:user:register_array:1.0\
sintef.no:user:internal_reset_timer:1.0\
xilinx.com:ip:util_reduced_logic:2.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:aurora_8b10b:11.1\
xilinx.com:ip:axi_dma:7.1\
sintef.no:sintef_ip:axi_s_chain_link_switch:1.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:util_vector_logic:2.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: sfp_0_1
proc create_hier_cell_sfp_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_sfp_0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:drp_rtl:1.0 GT0_DRP_IF

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:drp_rtl:1.0 GT0_DRP_IF1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 mgt_refclk0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 mgt_rx0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 mgt_rx1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 mgt_tx0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 mgt_tx1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I AXI_ARESETN
  create_bd_pin -dir O -from 0 -to 0 Op1
  create_bd_pin -dir O -from 0 -to 0 Op2
  create_bd_pin -dir I -type clk S_AXI_ACLK
  create_bd_pin -dir O frame1_start_puls
  create_bd_pin -dir I gt_reset
  create_bd_pin -dir I reset
  create_bd_pin -dir O sys_reset_out
  create_bd_pin -dir O sys_reset_out1

  # Create instance: aurora_8b10b_0, and set properties
  set aurora_8b10b_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.1 aurora_8b10b_0 ]
  set_property -dict [ list \
   CONFIG.C_DRP_IF {true} \
   CONFIG.C_LANE_WIDTH {4} \
   CONFIG.C_LINE_RATE {5} \
   CONFIG.C_USE_BYTESWAP {true} \
   CONFIG.C_USE_CRC {true} \
   CONFIG.SINGLEEND_INITCLK {true} \
   CONFIG.SupportLevel {1} \
   CONFIG.TransceiverControl {true} \
 ] $aurora_8b10b_0

  # Create instance: aurora_8b10b_1, and set properties
  set aurora_8b10b_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.1 aurora_8b10b_1 ]
  set_property -dict [ list \
   CONFIG.C_DRP_IF {true} \
   CONFIG.C_LANE_WIDTH {4} \
   CONFIG.C_LINE_RATE {5} \
   CONFIG.C_USE_BYTESWAP {true} \
   CONFIG.C_USE_CRC {true} \
   CONFIG.TransceiverControl {true} \
 ] $aurora_8b10b_1

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_enable_multi_channel {0} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_mm2s_dre {0} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_s2mm_dre {0} \
   CONFIG.c_include_sg {1} \
   CONFIG.c_micro_dma {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
 ] $axi_dma_0

  # Create instance: axi_s_chain_link_swi_0, and set properties
  set axi_s_chain_link_swi_0 [ create_bd_cell -type ip -vlnv sintef.no:sintef_ip:axi_s_chain_link_switch:1.0 axi_s_chain_link_swi_0 ]
  set_property -dict [ list \
   CONFIG.CONFIG_REGISTER_DEFAULTVALUE {0x04000400} \
   CONFIG.LINK_FIFO_SIZE {2048} \
 ] $axi_s_chain_link_swi_0

  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [ list \
   CONFIG.NUM_CLKS {2} \
   CONFIG.NUM_SI {3} \
 ] $axi_smc

  # Create instance: channel_up_n_0, and set properties
  set channel_up_n_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 channel_up_n_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $channel_up_n_0

  # Create instance: channel_up_n_1, and set properties
  set channel_up_n_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 channel_up_n_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $channel_up_n_1

  # Create instance: rx_lpm_en0, and set properties
  set rx_lpm_en0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 rx_lpm_en0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $rx_lpm_en0

  # Create instance: rx_lpm_en1, and set properties
  set rx_lpm_en1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 rx_lpm_en1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $rx_lpm_en1

  # Create instance: sys_reset_n_0, and set properties
  set sys_reset_n_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 sys_reset_n_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $sys_reset_n_0

  # Create instance: tvalid, and set properties
  set tvalid [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 tvalid ]

  # Create interface connections
  connect_bd_intf_net -intf_net GT0_DRP_IF1_1 [get_bd_intf_pins GT0_DRP_IF1] [get_bd_intf_pins aurora_8b10b_1/GT0_DRP_IF]
  connect_bd_intf_net -intf_net GT0_DRP_IF_1 [get_bd_intf_pins GT0_DRP_IF] [get_bd_intf_pins aurora_8b10b_0/GT0_DRP_IF]
  connect_bd_intf_net -intf_net aurora_8b10b_0_GT_SERIAL_TX [get_bd_intf_pins mgt_tx0] [get_bd_intf_pins aurora_8b10b_0/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_8b10b_0_USER_DATA_M_AXI_RX [get_bd_intf_pins aurora_8b10b_0/USER_DATA_M_AXI_RX] [get_bd_intf_pins axi_s_chain_link_swi_0/link_in1_axis]
  connect_bd_intf_net -intf_net aurora_8b10b_1_GT_SERIAL_TX [get_bd_intf_pins mgt_tx1] [get_bd_intf_pins aurora_8b10b_1/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_8b10b_1_USER_DATA_M_AXI_RX [get_bd_intf_pins aurora_8b10b_1/USER_DATA_M_AXI_RX] [get_bd_intf_pins axi_s_chain_link_swi_0/link_in2_axis]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axi_s_chain_link_swi_0/node_out1_axis]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_smc/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M37_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M38_AXI [get_bd_intf_pins s_axi] [get_bd_intf_pins axi_s_chain_link_swi_0/s_axi]
  connect_bd_intf_net -intf_net axi_s_chain_link_swi_0_link_out1_axis [get_bd_intf_pins aurora_8b10b_0/USER_DATA_S_AXI_TX] [get_bd_intf_pins axi_s_chain_link_swi_0/link_out1_axis]
  connect_bd_intf_net -intf_net axi_s_chain_link_swi_0_link_out2_axis [get_bd_intf_pins aurora_8b10b_1/USER_DATA_S_AXI_TX] [get_bd_intf_pins axi_s_chain_link_swi_0/link_out2_axis]
  connect_bd_intf_net -intf_net axi_s_chain_link_swi_0_node_in1_axis [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axi_s_chain_link_swi_0/node_in1_axis]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_smc/M00_AXI]
  connect_bd_intf_net -intf_net mgt_refclk0_1 [get_bd_intf_pins mgt_refclk0] [get_bd_intf_pins aurora_8b10b_0/GT_DIFF_REFCLK1]
  connect_bd_intf_net -intf_net mgt_rx0_1 [get_bd_intf_pins mgt_rx0] [get_bd_intf_pins aurora_8b10b_0/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net mgt_rx1_1 [get_bd_intf_pins mgt_rx1] [get_bd_intf_pins aurora_8b10b_1/GT_SERIAL_RX]

  # Create port connections
  connect_bd_net -net AXI_ARESETN_1 [get_bd_pins AXI_ARESETN] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_s_chain_link_swi_0/s_axi_aresetn] [get_bd_pins axi_smc/aresetn]
  connect_bd_net -net aurora_8b10b_0_channel_up [get_bd_pins Op1] [get_bd_pins aurora_8b10b_0/channel_up] [get_bd_pins channel_up_n_0/Op1]
  connect_bd_net -net aurora_8b10b_0_gt_qpllclk_quad1_out [get_bd_pins aurora_8b10b_0/gt_qpllclk_quad1_out] [get_bd_pins aurora_8b10b_1/gt_qpllclk_quad1_in]
  connect_bd_net -net aurora_8b10b_0_gt_qpllrefclk_quad1_out [get_bd_pins aurora_8b10b_0/gt_qpllrefclk_quad1_out] [get_bd_pins aurora_8b10b_1/gt_qpllrefclk_quad1_in]
  connect_bd_net -net aurora_8b10b_0_gt_refclk1_out [get_bd_pins aurora_8b10b_0/gt_refclk1_out] [get_bd_pins aurora_8b10b_1/gt_refclk1]
  connect_bd_net -net aurora_8b10b_0_gt_reset_out [get_bd_pins aurora_8b10b_0/gt_reset_out] [get_bd_pins aurora_8b10b_1/gt_reset]
  connect_bd_net -net aurora_8b10b_0_sync_clk_out [get_bd_pins aurora_8b10b_0/sync_clk_out] [get_bd_pins aurora_8b10b_1/sync_clk]
  connect_bd_net -net aurora_8b10b_0_sys_reset_out [get_bd_pins sys_reset_out] [get_bd_pins aurora_8b10b_0/sys_reset_out] [get_bd_pins aurora_8b10b_1/reset] [get_bd_pins sys_reset_n_0/Op1]
  connect_bd_net -net aurora_8b10b_0_user_clk_out [get_bd_pins aurora_8b10b_0/user_clk_out] [get_bd_pins aurora_8b10b_1/user_clk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_s_chain_link_swi_0/axis_aclk] [get_bd_pins axi_smc/aclk1]
  connect_bd_net -net aurora_8b10b_1_channel_up [get_bd_pins Op2] [get_bd_pins aurora_8b10b_1/channel_up] [get_bd_pins channel_up_n_1/Op1]
  connect_bd_net -net aurora_8b10b_1_sys_reset_out [get_bd_pins sys_reset_out1] [get_bd_pins aurora_8b10b_1/sys_reset_out]
  connect_bd_net -net axi_s_chain_link_swi_0_frame1_start_pulse [get_bd_pins frame1_start_puls] [get_bd_pins axi_s_chain_link_swi_0/frame1_start_pulse]
  connect_bd_net -net channel_up_n_0_Res [get_bd_pins axi_s_chain_link_swi_0/link1_flush] [get_bd_pins channel_up_n_0/Res]
  connect_bd_net -net channel_up_n_1_Res [get_bd_pins axi_s_chain_link_swi_0/link2_flush] [get_bd_pins channel_up_n_1/Res]
  connect_bd_net -net gt_reset_1 [get_bd_pins gt_reset] [get_bd_pins aurora_8b10b_0/gt_reset]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins S_AXI_ACLK] [get_bd_pins aurora_8b10b_0/drpclk_in] [get_bd_pins aurora_8b10b_0/init_clk_in] [get_bd_pins aurora_8b10b_1/drpclk_in] [get_bd_pins aurora_8b10b_1/init_clk_in] [get_bd_pins axi_dma_0/m_axi_sg_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_s_chain_link_swi_0/s_axi_aclk] [get_bd_pins axi_smc/aclk]
  connect_bd_net -net reset_1 [get_bd_pins reset] [get_bd_pins aurora_8b10b_0/reset]
  connect_bd_net -net rx_lpm_en1_dout [get_bd_pins aurora_8b10b_1/gt0_rxlpmen_in] [get_bd_pins rx_lpm_en1/dout]
  connect_bd_net -net sys_reset_n_0_Res [get_bd_pins axi_s_chain_link_swi_0/axis_aresetn] [get_bd_pins sys_reset_n_0/Res]
  connect_bd_net -net tvalid_dout [get_bd_pins axi_s_chain_link_swi_0/node_out2_axis_tvalid] [get_bd_pins tvalid/dout]
  connect_bd_net -net xlconstant_6_dout [get_bd_pins aurora_8b10b_0/gt0_rxlpmen_in] [get_bd_pins rx_lpm_en0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gigabit_block
proc create_hier_cell_gigabit_block { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_gigabit_block() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GT_DIFF_REFCLK1_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_RX_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_RX_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_TX_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_TX_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi2


  # Create pins
  create_bd_pin -dir I -type clk S_AXI_ACLK
  create_bd_pin -dir I S_AXI_ARESETN
  create_bd_pin -dir I capture_pwm_sync_ce
  create_bd_pin -dir I capture_timer_int_ce

  # Create instance: Aurora_status_concat_0, and set properties
  set Aurora_status_concat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 Aurora_status_concat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {7} \
 ] $Aurora_status_concat_0

  # Create instance: Aurora_status_concat_1, and set properties
  set Aurora_status_concat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 Aurora_status_concat_1 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {9} \
 ] $Aurora_status_concat_1

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary:12.0 c_counter_binary_0 ]
  set_property -dict [ list \
   CONFIG.CE {false} \
   CONFIG.Count_Mode {UP} \
   CONFIG.Latency {2} \
   CONFIG.Latency_Configuration {Manual} \
   CONFIG.Load {false} \
   CONFIG.Load_Sense {Active_High} \
   CONFIG.Output_Width {32} \
   CONFIG.Restrict_Count {false} \
   CONFIG.SCLR {false} \
   CONFIG.SINIT {false} \
   CONFIG.SSET {false} \
   CONFIG.Sync_Threshold_Output {false} \
 ] $c_counter_binary_0

  # Create instance: capture_pwm_base1, and set properties
  set capture_pwm_base1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 capture_pwm_base1 ]
  set_property -dict [ list \
   CONFIG.CE {true} \
   CONFIG.Depth {1} \
 ] $capture_pwm_base1

  # Create instance: capture_rx0, and set properties
  set capture_rx0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 capture_rx0 ]
  set_property -dict [ list \
   CONFIG.CE {true} \
   CONFIG.Depth {1} \
 ] $capture_rx0

  # Create instance: capture_timer_int, and set properties
  set capture_timer_int [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 capture_timer_int ]
  set_property -dict [ list \
   CONFIG.CE {true} \
   CONFIG.Depth {1} \
 ] $capture_timer_int

  # Create instance: drp_bridge_0, and set properties
  set drp_bridge_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:drp_bridge:1.0 drp_bridge_0 ]
  set_property -dict [ list \
   CONFIG.DRP_COUNT {2} \
   CONFIG.DRP_DATA_WIDTH {16} \
 ] $drp_bridge_0

  # Create instance: gigabit_regarray, and set properties
  set gigabit_regarray [ create_bd_cell -type ip -vlnv sintef.no:user:register_array:1.0 gigabit_regarray ]
  set_property -dict [ list \
   CONFIG.NUMBER_OF_REGISTERS {9} \
 ] $gigabit_regarray

  # Create instance: internal_reset_timer_aurora0, and set properties
  set internal_reset_timer_aurora0 [ create_bd_cell -type ip -vlnv sintef.no:user:internal_reset_timer:1.0 internal_reset_timer_aurora0 ]
  set_property -dict [ list \
   CONFIG.RESET_IN_ACTIVE {"1"} \
   CONFIG.RESET_OUT_ACTIVE {"1"} \
   CONFIG.RESET_TIME {1000} \
 ] $internal_reset_timer_aurora0

  # Create instance: internal_reset_timer_aurora_gt_0, and set properties
  set internal_reset_timer_aurora_gt_0 [ create_bd_cell -type ip -vlnv sintef.no:user:internal_reset_timer:1.0 internal_reset_timer_aurora_gt_0 ]
  set_property -dict [ list \
   CONFIG.RESET_IN_ACTIVE {"1"} \
   CONFIG.RESET_OUT_ACTIVE {"1"} \
 ] $internal_reset_timer_aurora_gt_0

  # Create instance: intr_ce_type_joint_0, and set properties
  set intr_ce_type_joint_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 intr_ce_type_joint_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $intr_ce_type_joint_0

  # Create instance: sfp_0_1
  create_hier_cell_sfp_0_1 $hier_obj sfp_0_1

  # Create instance: stuff_16_0_0, and set properties
  set stuff_16_0_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 stuff_16_0_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {16} \
 ] $stuff_16_0_0

  # Create instance: stuff_32_0_1, and set properties
  set stuff_32_0_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 stuff_32_0_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $stuff_32_0_1

  # Create instance: stuff_6_0_0, and set properties
  set stuff_6_0_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 stuff_6_0_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {6} \
 ] $stuff_6_0_0

  # Create instance: synchronizer_reg_1, and set properties
  set synchronizer_reg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 synchronizer_reg_1 ]
  set_property -dict [ list \
   CONFIG.AsyncInitVal {00000000000000000000000000000000} \
   CONFIG.CE {false} \
   CONFIG.DefaultData {00000000000000000000000000000000} \
   CONFIG.Depth {1} \
   CONFIG.ShiftRegType {Fixed_Length} \
   CONFIG.SyncInitVal {00000000000000000000000000000000} \
   CONFIG.Width {32} \
 ] $synchronizer_reg_1

  # Create instance: xlslice_0_0, and set properties
  set xlslice_0_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0_0 ]

  # Create instance: xlslice_1_1, and set properties
  set xlslice_1_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1_1

  # Create interface connections
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_pins GT_DIFF_REFCLK1_0] [get_bd_intf_pins sfp_0_1/mgt_refclk0]
  connect_bd_intf_net -intf_net GT_RX_0_1 [get_bd_intf_pins GT_RX_0] [get_bd_intf_pins sfp_0_1/mgt_rx0]
  connect_bd_intf_net -intf_net GT_RX_1_1 [get_bd_intf_pins GT_RX_1] [get_bd_intf_pins sfp_0_1/mgt_rx1]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins drp_bridge_0/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_1_1 [get_bd_intf_pins S_AXI1] [get_bd_intf_pins gigabit_regarray/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M37_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins sfp_0_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M38_AXI [get_bd_intf_pins s_axi2] [get_bd_intf_pins sfp_0_1/s_axi]
  connect_bd_intf_net -intf_net drp_bridge_0_DRP0 [get_bd_intf_pins drp_bridge_0/DRP0] [get_bd_intf_pins sfp_0_1/GT0_DRP_IF]
  connect_bd_intf_net -intf_net drp_bridge_0_DRP1 [get_bd_intf_pins drp_bridge_0/DRP1] [get_bd_intf_pins sfp_0_1/GT0_DRP_IF1]
  connect_bd_intf_net -intf_net sfp_0_1_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins sfp_0_1/M00_AXI]
  connect_bd_intf_net -intf_net sfp_0_1_mgt_tx0 [get_bd_intf_pins GT_TX_0] [get_bd_intf_pins sfp_0_1/mgt_tx0]
  connect_bd_intf_net -intf_net sfp_0_1_mgt_tx1 [get_bd_intf_pins GT_TX_1] [get_bd_intf_pins sfp_0_1/mgt_tx1]

  # Create port connections
  connect_bd_net -net Aurora_status_concat_0_dout [get_bd_pins Aurora_status_concat_0/dout] [get_bd_pins synchronizer_reg_1/D]
  connect_bd_net -net Aurora_status_concat_1_dout [get_bd_pins Aurora_status_concat_1/dout] [get_bd_pins gigabit_regarray/register_array_read_vec]
  connect_bd_net -net S_AXI_ARESETN_1 [get_bd_pins S_AXI_ARESETN] [get_bd_pins drp_bridge_0/AXI_aresetn] [get_bd_pins gigabit_regarray/S_AXI_ARESETN] [get_bd_pins sfp_0_1/AXI_ARESETN]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins Aurora_status_concat_1/In3] [get_bd_pins c_counter_binary_0/Q] [get_bd_pins capture_pwm_base1/D] [get_bd_pins capture_rx0/D] [get_bd_pins capture_timer_int/D]
  connect_bd_net -net capture_pwm_base1_Q [get_bd_pins Aurora_status_concat_1/In6] [get_bd_pins capture_pwm_base1/Q]
  connect_bd_net -net capture_pwm_sync_ce_1 [get_bd_pins capture_pwm_sync_ce] [get_bd_pins capture_pwm_base1/CE]
  connect_bd_net -net capture_rx0_Q [get_bd_pins Aurora_status_concat_1/In4] [get_bd_pins capture_rx0/Q]
  connect_bd_net -net capture_timer_int_Q [get_bd_pins Aurora_status_concat_1/In7] [get_bd_pins capture_timer_int/Q]
  connect_bd_net -net capture_timer_int_ce_1 [get_bd_pins capture_timer_int_ce] [get_bd_pins intr_ce_type_joint_0/Op1]
  connect_bd_net -net internal_reset_timer_0_rst_out [get_bd_pins internal_reset_timer_aurora0/rst_out] [get_bd_pins sfp_0_1/reset]
  connect_bd_net -net internal_reset_timer_1_rst_out [get_bd_pins internal_reset_timer_aurora_gt_0/rst_out] [get_bd_pins sfp_0_1/gt_reset]
  connect_bd_net -net intr_ce_type_joint_0_Res [get_bd_pins capture_timer_int/CE] [get_bd_pins intr_ce_type_joint_0/Res]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins S_AXI_ACLK] [get_bd_pins c_counter_binary_0/CLK] [get_bd_pins capture_pwm_base1/CLK] [get_bd_pins capture_rx0/CLK] [get_bd_pins capture_timer_int/CLK] [get_bd_pins drp_bridge_0/AXI_aclk] [get_bd_pins gigabit_regarray/S_AXI_ACLK] [get_bd_pins internal_reset_timer_aurora0/clock] [get_bd_pins internal_reset_timer_aurora_gt_0/clock] [get_bd_pins sfp_0_1/S_AXI_ACLK] [get_bd_pins synchronizer_reg_1/CLK]
  connect_bd_net -net register_array_1_register_write_a [get_bd_pins Aurora_status_concat_1/In0] [get_bd_pins gigabit_regarray/register_write_a] [get_bd_pins xlslice_0_0/Din] [get_bd_pins xlslice_1_1/Din]
  connect_bd_net -net sfp_0_1_Op1 [get_bd_pins Aurora_status_concat_0/In0] [get_bd_pins sfp_0_1/Op1]
  connect_bd_net -net sfp_0_1_Op2 [get_bd_pins Aurora_status_concat_0/In1] [get_bd_pins sfp_0_1/Op2]
  connect_bd_net -net sfp_0_1_sys_reset_out [get_bd_pins Aurora_status_concat_0/In4] [get_bd_pins sfp_0_1/sys_reset_out]
  connect_bd_net -net sfp_0_1_sys_reset_out1 [get_bd_pins Aurora_status_concat_0/In3] [get_bd_pins sfp_0_1/sys_reset_out1]
  connect_bd_net -net stuff_32_0_1_dout [get_bd_pins Aurora_status_concat_1/In2] [get_bd_pins Aurora_status_concat_1/In5] [get_bd_pins Aurora_status_concat_1/In8] [get_bd_pins stuff_32_0_1/dout]
  connect_bd_net -net stuff_6_0_1_dout [get_bd_pins Aurora_status_concat_0/In6] [get_bd_pins stuff_16_0_0/dout]
  connect_bd_net -net synchronizer_reg_1_Q [get_bd_pins Aurora_status_concat_1/In1] [get_bd_pins synchronizer_reg_1/Q]
  connect_bd_net -net xlconstant_6_dout [get_bd_pins Aurora_status_concat_0/In2] [get_bd_pins Aurora_status_concat_0/In5] [get_bd_pins stuff_6_0_0/dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins internal_reset_timer_aurora0/rst_in] [get_bd_pins xlslice_0_0/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins internal_reset_timer_aurora_gt_0/rst_in] [get_bd_pins xlslice_1_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


proc available_tcl_procs { } {
   puts "##################################################################"
   puts "# Available Tcl procedures to recreate hierarchical blocks:"
   puts "#"
   puts "#    create_hier_cell_gigabit_block parentCell nameHier"
   puts "#    create_hier_cell_sfp_0_1 parentCell nameHier"
   puts "#"
   puts "##################################################################"
}

available_tcl_procs
