#### Template Script for RTL->Gate-Level Flow (modified for systolic_array)

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################

set DESIGN systolic_array
set GEN_EFF medium
set MAP_OPT_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set _OUTPUTS_PATH outputs_${DATE}
set _REPORTS_PATH reports_${DATE}
set _LOG_PATH logs_${DATE}

set_db / .init_lib_search_path {../library} 
set_db / .script_search_path {.} 
set_db / .init_hdl_search_path {../rtl} 

set_db / .max_cpus_per_server 4
set_db / .hdl_unconnected_value 0
set_db / .ultra_global_mapping true 
set_db / .information_level 7 

###############################################################
## Library setup
###############################################################

read_libs {slow.lib fast.lib}

# ============================================
# FIX: Prevent scan flip-flop generation
# This prevents scan chains from appearing in the netlist
# Without this, Innovus will complain about undefined scan chains
# ============================================
set_db use_scan_seqs_for_non_dft false

set_db / .lp_insert_clock_gating false 
set_db / .leakage_power_effort medium 

####################################################################
## Load Design
####################################################################

read_hdl pe.v
read_hdl sram.v
read_hdl systolic_array.v

elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

# Prevent deletion of unloaded instances
set_db / .delete_unloaded_insts false

# ============================================
# CRITICAL FIX: Disable auto-ungrouping
# Without this, PEs are flattened and internal flops lose hierarchical names
# ============================================
set_db / .auto_ungroup none

check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

if {[file exists systolic.sdc]} {
    read_sdc systolic.sdc
    puts "Loaded constraints from systolic.sdc"
} else {
    puts "WARNING: systolic.sdc not found - creating default clock"
    create_clock -name clk -period 13.33 [find /designs/$DESIGN -port clk]
}

puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"

# Create directories
if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
}
if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
}
if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
}
if {![file exists ${_REPORTS_PATH}/generic]} {
  file mkdir ${_REPORTS_PATH}/generic
}
if {![file exists ${_REPORTS_PATH}/map]} {
  file mkdir ${_REPORTS_PATH}/map
}

check_timing_intent

###################################################################################
## Define cost groups
###################################################################################

if {[llength [all_registers]] > 0} { 
  define_cost_group -name I2C -design $DESIGN
  define_cost_group -name C2O -design $DESIGN
  define_cost_group -name C2C -design $DESIGN
  path_group -from [all_registers] -to [all_registers] -group C2C -name C2C
  path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O
  path_group -from [all_inputs]  -to [all_registers] -group I2C -name I2C
}

define_cost_group -name I2O -design $DESIGN
path_group -from [all_inputs]  -to [all_outputs] -group I2O -name I2O

foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] >> ${_REPORTS_PATH}/${DESIGN}_pretim.rpt
}

set_db / .optimize_merge_flops false 
set_db / .optimize_merge_latches false 

####################################################################################################
## Synthesizing to generic 
####################################################################################################

set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > ${_REPORTS_PATH}/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir ${_REPORTS_PATH} -tag generic
report_summary -directory ${_REPORTS_PATH}

####################################################################################################
## Synthesizing to gates
####################################################################################################

set_db / .syn_map_effort $MAP_OPT_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED

# ============================================
# FIX: Preserve intentionally unused eastward outputs for LEC
# Apply AFTER syn_map (cells are mapped) but BEFORE syn_opt
# ============================================
puts "Preserving eastward output registers for LEC (128 flops)..."
set_db [get_cells -hier -filter "full_name =~ *outp_east_reg*"] .preserve true

write_snapshot -outdir ${_REPORTS_PATH} -tag map
report_summary -directory ${_REPORTS_PATH}
report_dp > ${_REPORTS_PATH}/map/${DESIGN}_datapath.rpt

foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] > ${_REPORTS_PATH}/${DESIGN}_[vbasename $cg]_post_map.rpt
}

write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

#######################################################################################################
## Optimize Netlist
#######################################################################################################

syn_opt -incremental
write_snapshot -outdir ${_REPORTS_PATH} -tag syn_opt_incr
report_summary -directory ${_REPORTS_PATH}

puts "Runtime & Memory after 'syn_opt'"
time_info OPT

foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] > ${_REPORTS_PATH}/${DESIGN}_[vbasename $cg]_post_opt.rpt
}

######################################################################################################
## Write outputs
######################################################################################################

# Reports
report_power > ${_REPORTS_PATH}/${DESIGN}_power.rpt
report_gates -power > ${_REPORTS_PATH}/${DESIGN}_gates_power.rpt
report_area > ${_REPORTS_PATH}/${DESIGN}_area.rpt
report_area -depth 2 > ${_REPORTS_PATH}/${DESIGN}_area_hierarchical.rpt
report_timing -max_paths 1 > ${_REPORTS_PATH}/${DESIGN}_timing_summary.rpt
report_timing -max_paths 10 > ${_REPORTS_PATH}/${DESIGN}_timing_detail.rpt

report_dp > ${_REPORTS_PATH}/${DESIGN}_datapath_incr.rpt
report_messages > ${_REPORTS_PATH}/${DESIGN}_messages.rpt
write_snapshot -outdir ${_REPORTS_PATH} -tag final
report_summary -directory ${_REPORTS_PATH}

# WRITE NETLIST
puts "Writing netlist to ${_OUTPUTS_PATH}/${DESIGN}_netlist.v"
write_hdl > ${_OUTPUTS_PATH}/${DESIGN}_netlist.v

# Verify netlist was created
if {[file exists ${_OUTPUTS_PATH}/${DESIGN}_netlist.v]} {
    puts "SUCCESS: Netlist created successfully!"
    puts "Netlist size: [file size ${_OUTPUTS_PATH}/${DESIGN}_netlist.v] bytes"
} else {
    puts "ERROR: Netlist was NOT created!"
    puts "Trying alternative method..."
    write_hdl -netlist_only > ${_OUTPUTS_PATH}/${DESIGN}_netlist_alt.v
}

write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_final.sdc

#################################
### write_do_lec
#################################

write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_netlist.v -logfile ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do

puts ""
puts "============================"
puts "Synthesis Finished Successfully!"
puts "============================"
puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Outputs saved to: ${_OUTPUTS_PATH}"
puts "  - Netlist: ${DESIGN}_netlist.v"
puts "  - SDC: ${_OUTPUTS_PATH}/${DESIGN}_final.sdc"
puts "Reports saved to: ${_REPORTS_PATH}"
puts "Logs saved to: ${_LOG_PATH}"
puts "============================"

file copy [get_db / .stdout_log] ${_LOG_PATH}/.

# Print final summary
puts ""
puts "=== FINAL AREA SUMMARY ==="
report_area -summary
puts ""
puts "=== FINAL TIMING SUMMARY ==="
report_timing -max_paths 1
puts ""
puts "=== FINAL GATE COUNT ==="
report_gates -power
