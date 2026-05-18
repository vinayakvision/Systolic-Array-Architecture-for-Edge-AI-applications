#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon May  4 10:58:04 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v20.14-s095_1 (64bit) 04/19/2021 14:41 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.14-s095_1 NR210411-1939/20_14-UB (database version 18.20.547) {superthreading v2.13}
#@(#)CDS: AAE 20.14-s018 (64bit) 04/19/2021 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.14-s027_1 () Apr 13 2021 21:29:07 ( )
#@(#)CDS: SYNTECH 20.14-s017_1 () Mar 25 2021 13:07:27 ( )
#@(#)CDS: CPE v20.14-s080
#@(#)CDS: IQuantus/TQuantus 20.1.1-s460 (64bit) Fri Mar 5 18:46:16 PST 2021 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
getVersion
getVersion
win
fit
fit
fit
fit
fit
fit
fit
fit
fit
fit
save_global Default.globals
set init_gnd_net VSS
set init_lef_file ../../../../../../installs/FOUNDRY/digital/90nm/dig/lef/gsclib090_translated.lef
set init_design_settop 0
set init_verilog ../../inputs/netlist/systolic_array_netlist.v
set init_mmmc_file Default.view
set init_pwr_net VDD
init_design
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site gsclib090site -r 0.7 0.6 10 10 10 10
uiSetTool select
getIoFlowFlag
fit
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 5 -pin {{a_addr[0]} {a_addr[1]} {a_addr[2]} {a_addr[3]} a_we {act_din[0]} {act_din[1]} {act_din[2]} {act_din[3]} {act_din[4]} {act_din[5]} {act_din[6]} {act_din[7]} {act_din[8]} {act_din[9]} {act_din[10]} {act_din[11]} {act_din[12]} {act_din[13]} {act_din[14]} {act_din[15]} clk load_ready rst}
setPinAssignMode -pinEditInBatch false
set ptngSprNoRefreshPins 1
setPtnPinStatus -cell systolic_array -pin load_ready -status unplaced -silent
set ptngSprNoRefreshPins 0
ptnSprRefreshPinsAndBlockages
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 5 -pin load_valid
setPinAssignMode -pinEditInBatch false
set ptngSprNoRefreshPins 1
setPtnPinStatus -cell systolic_array -pin {a_addr[0]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {a_addr[1]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {a_addr[2]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {a_addr[3]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin a_we -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[0]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[1]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[2]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[3]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[4]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[5]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[6]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[7]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[8]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[9]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[10]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[11]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[12]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[13]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[14]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin {act_din[15]} -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin clk -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin load_valid -status unplaced -silent
setPtnPinStatus -cell systolic_array -pin rst -status unplaced -silent
set ptngSprNoRefreshPins 0
ptnSprRefreshPinsAndBlockages
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 5 -pin {{a_addr[0]} {a_addr[1]} {a_addr[2]} {a_addr[3]} a_we {act_din[0]} {act_din[1]} {act_din[2]} {act_din[3]} {act_din[4]} {act_din[5]} {act_din[6]} {act_din[7]} {act_din[8]} {act_din[9]} {act_din[10]} {act_din[11]} {act_din[12]} {act_din[13]} {act_din[14]} {act_din[15]} clk load_valid rst}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Right -layer 3 -spreadType center -spacing 1 -pin {load_ready {Re1[0]} {Re1[1]} {Re1[2]} {Re1[3]} {Re1[4]} {Re1[5]} {Re1[6]} {Re1[7]} {Re1[8]} {Re1[9]} {Re1[10]} {Re1[11]} {Re1[12]} {Re1[13]} {Re1[14]} {Re1[15]} {Re1[16]} {Re1[17]} {Re1[18]} {Re1[19]} {Re1[20]} {Re1[21]} {Re1[22]} {Re1[23]} {Re1[24]} {Re1[25]} {Re1[26]} {Re1[27]} {Re1[28]} {Re1[29]} {Re1[30]} {Re1[31]} {Re2[0]} {Re2[1]} {Re2[2]} {Re2[3]} {Re2[4]} {Re2[5]} {Re2[6]} {Re2[7]} {Re2[8]} {Re2[9]} {Re2[10]} {Re2[11]} {Re2[12]} {Re2[13]} {Re2[14]} {Re2[15]} {Re2[16]} {Re2[17]} {Re2[18]} {Re2[19]} {Re2[20]} {Re2[21]} {Re2[22]} {Re2[23]} {Re2[24]} {Re2[25]} {Re2[26]} {Re2[27]} {Re2[28]} {Re2[29]} {Re2[30]} {Re2[31]} {Re3[0]} {Re3[1]} {Re3[2]} {Re3[3]} {Re3[4]} {Re3[5]} {Re3[6]} {Re3[7]} {Re3[8]} {Re3[9]} {Re3[10]} {Re3[11]} {Re3[12]} {Re3[13]} {Re3[14]} {Re3[15]} {Re3[16]} {Re3[17]} {Re3[18]} {Re3[19]} {Re3[20]} {Re3[21]} {Re3[22]} {Re3[23]} {Re3[24]} {Re3[25]} {Re3[26]} {Re3[27]} {Re3[28]} {Re3[29]} {Re3[30]} {Re3[31]} {Re4[0]} {Re4[1]} {Re4[2]} {Re4[3]} {Re4[4]} {Re4[5]} {Re4[6]} {Re4[7]} {Re4[8]} {Re4[9]} {Re4[10]} {Re4[11]} {Re4[12]} {Re4[13]} {Re4[14]} {Re4[15]} {Re4[16]} {Re4[17]} {Re4[18]} {Re4[19]} {Re4[20]} {Re4[21]} {Re4[22]} {Re4[23]} {Re4[24]} {Re4[25]} {Re4[26]} {Re4[27]} {Re4[28]} {Re4[29]} {Re4[30]} {Re4[31]} result_valid}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 4 -spreadType center -spacing 5 -pin {{w_addr[0]} {w_addr[1]} {w_addr[2]} {w_addr[3]} w_we {weight_din[0]} {weight_din[1]} {weight_din[2]} {weight_din[3]} {weight_din[4]} {weight_din[5]} {weight_din[6]} {weight_din[7]} {weight_din[8]} {weight_din[9]} {weight_din[10]} {weight_din[11]} {weight_din[12]} {weight_din[13]} {weight_din[14]} {weight_din[15]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.14 -pinDepth 0.575 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 4 -spreadType center -spacing 5.22 -pin {}
setPinAssignMode -pinEditInBatch false
zoomBox 181.19150 112.71350 666.61950 346.17450
zoomBox 335.18050 171.12300 633.29550 314.49800
zoomBox 428.06250 210.14250 611.14350 298.19300
zoomBox 450.23600 219.45750 605.85500 294.30050
pan -0.15200 -247.66400
pan 1.36900 -268.65700
pan 0.45650 -289.64950
pan -1.52150 -305.62250
pan 0.45650 -321.44300
pan -1.06500 -336.35100
pan 1.06500 -341.97950
fit
checkPinAssignment
checkFPlan
fit
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}
fit
addEndCap -preCap FILL1 -postCap FILL2 -prefix ENDCAP
addWellTap -cell FILL8 -cellInterval 40 -skipRow 1 -prefix WELLTAP
addWellTap -cell FILL8 -cellInterval 40 -inRowOffset 20 -startRowNum 2 -skipRow 1 -prefix WELLTAP
zoomBox 218.37600 179.41600 630.99050 377.85800
zoomBox 372.60950 246.31450 587.99850 349.90350
zoomBox 453.12050 279.82700 565.55550 333.90150
fit
fit
saveDesign ../flow/floorplan.enc
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top Metal9 bottom Metal9 left Metal8 right Metal8} -width {top 2.5 bottom 2.5 left 2.5 right 2.5} -spacing {top 2 bottom 2 left 2 right 2} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer Metal9 -direction horizontal -width 2 -spacing 1 -set_to_set_distance 50 -start_from bottom -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal9 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal9 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer Metal8 -direction vertical -width 2 -spacing 1 -set_to_set_distance 50 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal9 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal9 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal9 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer Metal8 -direction vertical -width 2 -spacing 1 -set_to_set_distance 50 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal9 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal9 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal9(9) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal9(9) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal9(9) }
zoomBox 103.11650 136.52750 588.54550 369.98900
pan 0.47450 108.85900
zoomBox 52.51050 194.72550 623.60350 469.38600
zoomBox -7.58400 174.43100 664.29050 497.56150
pan -43.34650 111.74100
zoomBox -50.93100 71.84350 620.94400 394.97400
zoomBox -129.27950 35.56650 661.16150 415.72000
zoomBox -221.45500 -7.11200 708.47600 440.12750
zoomBox -129.28050 35.56650 661.16150 415.72050
zoomBox -50.93200 71.84350 620.94400 394.97450
zoomBox 15.66450 102.67850 586.75900 377.34000
zoomBox -50.93300 71.84300 620.94400 394.97450
zoomBox 161.28500 170.10350 512.00950 338.78050
zoomBox 290.21150 229.79850 445.83000 304.64150
zoomBox 305.63600 236.94050 437.91200 300.55700
zoomBox 347.41550 256.28500 416.46600 289.49400
zoomBox 369.12900 267.93150 405.17400 285.26700
zoomBox 372.68600 269.83950 403.32400 284.57450
zoomBox 382.29150 275.06450 398.28550 282.75650
zoomBox 375.69900 271.47850 401.74300 284.00400
zoomBox 372.68450 269.83850 403.32450 284.57450
zoomBox 369.13800 267.90950 405.18500 285.24600
zoomBox 364.96550 265.63950 407.37400 286.03550
zoomBox 360.05600 262.96900 409.94900 286.96450
zoomBox 354.28100 259.82750 412.97850 288.05750
zoomBox 347.48650 256.13150 416.54300 289.34350
zoomBox 339.49300 251.78350 420.73650 290.85650
zoomBox 330.08850 246.66800 425.66950 292.63650
pan 2.52300 -97.24850
pan -0.09350 -117.14950
pan -0.37350 -137.98450
pan 1.02750 -154.98950
pan 1.12150 -170.49900
pan -0.56100 -185.44800
pan -1.12150 -197.50050
pan -0.56050 -207.87100
pan -1.02750 -218.42900
pan -0.74750 -228.14650
pan 0.00000 -237.20950
pan -1.02750 -245.89900
pan 0.28000 -259.44700
pan -0.18700 -276.63800
pan 0.56050 -294.76350
pan 0.56100 -308.12450
pan 0.09350 -319.24300
pan 0.00000 -324.28850
pan 0.18700 -339.05100
pan 0.37400 -341.48000
fit
verify_drc
verifyConnectivity
checkFPlan
saveDesign ../flow/power_plan.enc
place_design
timeDesign -early
report_timing -late
report_timing -early
place_opt_design
report_timing -early
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_preCTS -outDir timingReports
report_clocks
saveDesign ../flow/place_opt.enc
report_clocks
create_ccopt_clock_tree
create_ccopt_clock_tree -help
create_ccopt_clock_tree_spec -file ../../inputs/new_clock.spec
set_ccopt_property -target_max_trans 0.2
set_ccopt_property -target_max_capacitance 0.4
set_ccopt_property -target_max_fanout 5
get_ccopt_clock_trees
ccopt_check_and_flatten_ilms_no_restore
set_ccopt_property cts_is_sdc_clock_root -pin clk true
create_ccopt_clock_tree -name clk -source clk -no_skew_group
set_ccopt_property target_max_trans_sdc -delay_corner max_delay -early -clock_tree clk 0.200
set_ccopt_property target_max_trans_sdc -delay_corner max_delay -late -clock_tree clk 0.200
set_ccopt_property source_driver -clock_tree clk {BUFX2/A BUFX2/Y}
set_ccopt_property clock_period -pin clk 13.33
create_ccopt_skew_group -name clk/sdc -sources clk -auto_sinks
set_ccopt_property include_source_latency -skew_group clk/sdc true
set_ccopt_property extracted_from_clock_name -skew_group clk/sdc clk
set_ccopt_property extracted_from_constraint_mode_name -skew_group clk/sdc sdc
set_ccopt_property extracted_from_delay_corners -skew_group clk/sdc {max_delay min_delay}
check_ccopt_clock_tree_convergence
get_ccopt_property auto_design_state_for_ilms
ctd_win -side none -id ctd_window
set_ccopt_property -target_max_trans 0.2
set_ccopt_property -target_max_capacitance 0.4
set_ccopt_property -target_max_fanout 5
set_ccopt_property -source ../../inputs/cts_spec.spec
set_ccopt_property -help
ccopt_design
set_ccopt_property -target_max_trans 0.2
set_ccopt_property -target_max_capacitance 0.4
set_ccopt_property -target_max_fanout 5
ctd_win -side none -id ctd_window
set_ccopt_property -target_max_trans 0.2
set_ccopt_property -target_max_capacitance 0.4
set_ccopt_property -target_max_fanout 5
set_ccopt_property -target_skew 0.5
set_ccopt_property -target_max_insertion_delay 0.2
set_ccopt_property buffer_cells { CLKBUFX20 CLKBUFX4 CLKBUFX16 CLKBUFX6 CLKBUFX3 CLKBUFX12 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX12 CLKINVX8 CLKINVX2 CLKINVX20 CLKINVX4 CLKINVX1 CLKINVX16 CLKINVX6 CLKINVX3 }
ctd_win -side none -id ctd_window
set_ccopt_property buffer_cells { CLKBUFX20 CLKBUFX4 CLKBUFX16 CLKBUFX6 CLKBUFX3 CLKBUFX12 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX12 CLKINVX8 CLKINVX2 CLKINVX20 CLKINVX4 CLKINVX1 CLKINVX16 CLKINVX6 CLKINVX3 }
ctd_win -side none -id ctd_window
set_propagated_clock -all
set_propagated_clock [all_clocks]
all_constraint_modes -active
set_interactive_constraint_modes [all_constraint_modes -active]
set_propagated_clock [all_clocks]
report_clocks
ctd_win -side none -id ctd_window
set_ccopt_property buffer_cells { CLKBUFX20 CLKBUFX4 CLKBUFX16 CLKBUFX6 CLKBUFX3 CLKBUFX12 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX12 CLKINVX8 CLKINVX2 CLKINVX20 CLKINVX4 CLKINVX1 CLKINVX16 CLKINVX6 CLKINVX3 }
create_ccopt_clock_tree_spec -file ../../inputs/new1clock.spec
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/place_opt.enc.dat systolic_array
create_ccopt_clock_tree -name test_tree -source cts_spec.spec
create_ccopt_clock_tree
set_ccopt_property -target_max_trans 0.2
set_ccopt_property -target_max_capacitance 0.4
set_ccopt_property -target_max_fanout 5
set_ccopt_property buffer_cells { CLKBUFX20 CLKBUFX4 CLKBUFX16 CLKBUFX6 CLKBUFX3 CLKBUFX12 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX12 CLKINVX8 CLKINVX2 CLKINVX20 CLKINVX4 CLKINVX1 CLKINVX16 CLKINVX6 CLKINVX3 }
ccopt_design
ctd_win -side none -id ctd_window
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/place_opt.enc.dat systolic_array
set_ccopt_property buffer_cells { CLKBUFX20 CLKBUFX4 CLKBUFX16 CLKBUFX6 CLKBUFX3 CLKBUFX12 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX12 CLKINVX8 CLKINVX2 CLKINVX20 CLKINVX4 CLKINVX1 CLKINVX16 CLKINVX6 CLKINVX3 }
ccopt_design
report_clocks
all_constraint_modes
set_interactive_constraint_modes [all_constraint_modes]
set_propagated_clock [all_clocks]
report_clocks
ctd_win -side none -id ctd_window
zoomBox -115.80700 22.62150 674.63300 402.77450
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix systolic_array_postCTS -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postCTS -outDir timingReports
optDesign -postCTS
fit
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postCTS -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS -hold
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postCTS -outDir timingReports
routeDesign
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
setAnalysisMode -analysisType onChipVariation -cppr both
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
optDesign -postRoute
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
optDesign -postRoute -hold
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
verify_drc
verifyConnectivity
extractRC
saveDesign ../flow/post_route.enc
saveDesign ../flow/extractRC.enc
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
timeDesign -postRoute
timeDesign -postRoute -hold
report_clocks
report_noise
report_area
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/place_opt.enc.dat systolic_array
report_clocks
set_ccopt_property buffer_cells { CLKBUFX20 CLKBUFX4 CLKBUFX16 CLKBUFX6 CLKBUFX3 CLKBUFX12 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX12 CLKINVX8 CLKINVX2 CLKINVX20 CLKINVX4 CLKINVX1 CLKINVX16 CLKINVX6 CLKINVX3 }
ccopt_design
ctd_win -side none -id ctd_window
all_constraint_modes
set_interactive_constraint_modes [all_constraint_modes]
set_propagated_clock [all_clocks]
report_clocks
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/extractRC.enc.dat systolic_array
addFiller -cell {FILL1 FILL2 FILL4 FILL8} -prefix FILL
zoomBox -80.06150 22.81500 491.03150 297.47550
zoomBox -25.19200 47.18100 272.92300 190.55600
zoomBox 12.90350 69.22850 145.17950 132.84500
zoomBox 29.80650 79.01050 88.49900 107.23800
fit
verify_drc
verifyConnectivity
zoomBox 116.65350 120.57750 602.08250 354.03900
zoomBox 228.31600 174.43400 579.03900 343.11000
zoomBox 304.23550 212.67900 557.63300 334.54750
zoomBox 397.77000 258.18100 530.04600 321.79750
zoomBox 442.70250 276.72200 511.75150 309.93050
fit
checkDesign
checkDesign -all
checkFPlan
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/extractRC.enc.dat systolic_array
addFiller -cell {FILL1 FILL2 FILL4 FILL8} -prefix FILL
verify_drc
verifyConnectivity
checkFPlan
checkDesign
checkDesign -all
saveDesign ../flow/filler_completed.enc
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -signoff -pathReports -drvReports -slackReports -numPaths 50 -prefix systolic_array_signOff -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -signoff -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_signOff -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
saveDesign ../flow/filler_completed.enc
saveNetlist ../../tempus/design.v
verify_PG_short -no_routing_blkg
report_timing -path_type full >../../reports/timing_report.rpt
report_timing -path_type end > /home/vlsi_S34/Desktop/tempppp/pd/reports/timing_summary.rpt
report_area > /home/vlsi_S34/Desktop/tempppp/pd/reports/area.rpt
report_power > /home/vlsi_S34/Desktop/tempppp/pd/reports/power.rpt
reportGateCount -outfile /home/vlsi_S34/Desktop/tempppp/pd/reports/gate_count.rpt
report_design -physical > /home/vlsi_S34/Desktop/tempppp/pd/reports/design_physical.rpt
report_design -early > /home/vlsi_S34/Desktop/tempppp/pd/reports/design_physical.rpt
verify_drc > /home/vlsi_S34/Desktop/tempppp/pd/reports/drc_report.rpt
verifyConnectivity > /home/vlsi_S34/Desktop/tempppp/pd/reports/connectivity_report.rpt
report_design -late > /home/vlsi_S34/Desktop/tempppp/pd/reports/design_info.rpt
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/extractRC.enc.dat systolic_array
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
getAnalysisMode -checkType
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -early > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
ctd_win -side none -id ctd_window
streamOut /home/vlsi_S34/Desktop/tempppp/pd/final_layout.gds -mapFile streamOut.map -mode ALL
ui_view_box
ui_view_box
dbquery -area {-177.574 -20.329 752.354 426.909} -objType inst
dbquery -area {-177.574 -20.329 752.354 426.909} -objType regular
dbquery -area {-177.574 -20.329 752.354 426.909} -objType special
fit
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
verify_drc
verifyConnectivity
checkFPlan
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
ctd_win -side none -id ctd_window
zoomBox -75.03100 21.81800 410.39750 255.27900
zoomBox -12.73550 47.42250 202.65300 151.01100
zoomBox -5.28200 50.48600 177.79800 138.53600
zoomBox 14.90600 58.78350 110.47550 104.74650
zoomBox 28.63700 64.42700 64.68200 81.76250
fit
check_timing -all > /home/vlsi_S34/Desktop/tempppp/pd/reports/complete_timing_check.rpt
report_timing -unconstrained > unconstrained_paths_detail.rpt
report_timing -unconstrained -max_paths 2000 > /home/vlsi_S34/Desktop/tempppp/pd/reports/unconstrained_paths_full.rpt
check_timing -type unconstrained_endpoint -verbose > /home/vlsi_S34/Desktop/tempppp/pd/reports/unconstrained_endpoints_summary.rpt
check_timing -type endpoint -verbose > /home/vlsi_S34/Desktop/tempppp/pd/reports/unconstrained_endpoints_summary.rpt
check_timing -all > /home/vlsi_S34/Desktop/tempppp/pd/reports/complete_timing_check_final.rpt
report_timing -unconstrained -max_paths 20 > /home/vlsi_S34/Desktop/tempppp/pd/reports/unconstrained_paths_first20.rpt
check_timing -type clocks 
check_timing -type endpoints > /home/vlsi_S34/Desktop/tempppp/pd/reports/check_endpoints.rpt
check_timing -type clocks > /home/vlsi_S34/Desktop/tempppp/pd/reports/check_clocks.rpt
check_timing -type inputs > /home/vlsi_S34/Desktop/tempppp/pd/reports/check_inputs.rpt
check_timing -type nets > /home/vlsi_S34/Desktop/tempppp/pd/reports/check_nets.rpt
report_timing -unconstrained -max_paths 100 | grep -v "rst" | grep -v "RN"
report_timing -unconstrained -max_paths 10
timeDesign -postRoute -hold
verify_drc
verifyConnectivity
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/filler_completed.enc.dat systolic_array
zoomBox -72.42400 37.89450 413.00500 271.35600
zoomBox -8.54400 73.53000 206.84400 177.11850
zoomBox 23.18950 91.23350 104.42450 130.30250
zoomBox 19.72800 88.87900 115.29900 134.84300
pan 16.34900 71.58050
zoomBox 67.58650 102.41950 109.99250 122.81400
zoomBox 82.07000 108.17700 98.06500 115.86950
zoomBox 86.26200 109.84300 94.61250 113.85900
zoomBox 84.50350 109.14400 96.06100 114.70250
zoomBox 76.55550 105.98550 102.60500 118.51350
zoomBox 71.06850 103.80450 107.12350 121.14450
pan -15.01400 32.87700
fit
zoomBox -101.10700 25.27000 469.98600 299.93050
zoomBox -82.85200 36.23950 402.57700 269.70100
zoomBox -11.92000 85.46450 171.15950 173.51450
zoomBox 11.97250 102.09000 93.20650 141.15850
pan -21.12250 89.87900
zoomBox -5.92200 104.73350 63.12700 137.94200
zoomBox 4.25250 113.81950 34.89050 128.55450
zoomBox 9.18150 117.88400 22.77800 124.42300
zoomBox 7.70150 117.19900 23.69750 124.89200
zoomBox 5.96050 116.39350 24.77900 125.44400
zoomBox 3.91200 115.44550 26.05150 126.09300
zoomBox -1.33300 113.01800 29.31000 127.75550
zoomBox -25.03200 102.05150 44.03200 135.26700
zoomBox -115.31700 60.27100 100.12000 163.88300
fit
verify_drc
verifyConnectivity
checkFPlan
checkFiller
report_metal_fill
report_clocks
check_design -help
check_design -type all
check_design -type cts
check_design -type signoff
deleteFiller -prefix FILLER
deleteFiller -prefix
deleteFiller -prefix -help
setFillerMode -add_fillers_without_pg_pin true -eco_mode true -core_prefix FILL
setFillerMode -ecoMode true -corePrefix FILL
setDistributeHost -local
check_design -type signoff
saveDesign ../flow/filler_completed.enc
verify_drc
verifyConnectivity
checkFPlan
freeDesign
reportCongestion
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/extractRC.enc.dat systolic_array
reportCongestion
reportCongestion -hotspot
reportCongestion -overflow
zoomBox -85.02600 28.76900 400.40400 262.23100
zoomBox -69.86550 36.81200 342.75050 235.25500
zoomBox -54.80100 44.85850 295.92300 213.53500
zoomBox -41.99600 51.69800 256.11950 195.07300
zoomBox -21.74900 63.34450 193.64000 166.93350
zoomBox -13.09600 70.48200 169.98500 158.53250
zoomBox 0.51150 81.70550 132.78800 145.32250
fit
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/filler_completed.enc.dat systolic_array
reportCongestArea
reportCongestion -overflow
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
freeDesign
is_common_ui_mode
restoreDesign /home/vlsi_S34/Desktop/tempppp/pd/final_flow/flow/extractRC.enc.dat systolic_array
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix systolic_array_postRoute -outDir timingReports
freeDesign
