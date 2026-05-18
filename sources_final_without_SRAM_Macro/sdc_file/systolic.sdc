#=============================================================================
# systolic.sdc - Simplified Error-Free Timing Constraints
# For 4x4 Systolic Array
#=============================================================================

#=============================================================================
# 1. Clock Definition
#=============================================================================
create_clock -name clk -period 13.33 [get_ports clk]


# Clock uncertainty
set_clock_uncertainty -setup 0.3 [get_clocks clk]
set_clock_uncertainty -hold 0.1 [get_clocks clk]

# Clock transition
set_clock_transition -rise 0.2 [get_clocks clk]
set_clock_transition -fall 0.2 [get_clocks clk]

#=============================================================================
# 2. Reset (asynchronous - false path)
#=============================================================================
set_false_path -from [get_ports rst]

#=============================================================================
# 3. Input Delays
#=============================================================================
set_input_delay -clock clk -max 2.0 [get_ports load_valid]
set_input_delay -clock clk -min 0.5 [get_ports load_valid]

set_input_delay -clock clk -max 2.0 [get_ports w_we]
set_input_delay -clock clk -max 2.0 [get_ports {w_addr*}]
set_input_delay -clock clk -max 2.0 [get_ports {weight_din*}]

set_input_delay -clock clk -max 2.0 [get_ports a_we]
set_input_delay -clock clk -max 2.0 [get_ports {a_addr*}]
set_input_delay -clock clk -max 2.0 [get_ports {act_din*}]

#=============================================================================
# 4. Output Delays
#=============================================================================
set_output_delay -clock clk -max 2.0 [get_ports result_valid]
set_output_delay -clock clk -min 0.5 [get_ports result_valid]

set_output_delay -clock clk -max 2.0 [get_ports {Re1 Re2 Re3 Re4}]
set_output_delay -clock clk -min 0.5 [get_ports {Re1 Re2 Re3 Re4}]

set_output_delay -clock clk -max 2.0 [get_ports load_ready]
set_output_delay -clock clk -min 0.5 [get_ports load_ready]

#=============================================================================
# 5. Drive Strength and Load
#=============================================================================
set_driving_cell -lib_cell BUFX2 -library slow [get_ports {load_valid w_we a_we}]
set_driving_cell -lib_cell BUFX2 -library slow [get_ports {w_addr* a_addr*}]
set_driving_cell -lib_cell BUFX2 -library slow [get_ports {weight_din* act_din*}]
set_driving_cell -lib_cell BUFX2 -library slow [get_ports clk]

set_load 0.1 [get_ports {Re1 Re2 Re3 Re4 result_valid load_ready}]
set_max_capacitance 0.5 [get_ports {Re1 Re2 Re3 Re4 result_valid load_ready}]
set_max_transition 0.5 [get_designs *]

#=============================================================================
# 6. Multicycle Paths - SIMPLIFIED (using wildcards that will match)
#=============================================================================

# SRAM to registers (2 cycles)
set_multicycle_path -setup 2 -from [get_pins W_SRAM/dout*] -to [get_cells -hier *weight_reg*] -end
set_multicycle_path -hold 1 -from [get_pins W_SRAM/dout*] -to [get_cells -hier *weight_reg*] -end

set_multicycle_path -setup 2 -from [get_pins A_SRAM/dout*] -to [get_cells -hier *act_reg*] -end
set_multicycle_path -hold 1 -from [get_pins A_SRAM/dout*] -to [get_cells -hier *act_reg*] -end

# Full computation path (from load_valid to results)
set_multicycle_path -setup 29 -from [get_ports load_valid] -to [get_ports {Re1 Re2 Re3 Re4}]
set_multicycle_path -setup 29 -from [get_ports load_valid] -to [get_ports result_valid]

#=============================================================================
# End of Constraints
#=============================================================================
