vcom -reportprogress 300 -work work {} {}
vsim -gui -novopt work.elevator_tb
add wave -position insertpoint  \
sim:/elevator_tb/switch_t \
sim:/elevator_tb/nreset_t \
sim:/elevator_tb/move_state_t \
sim:/elevator_tb/motor_up_t \
sim:/elevator_tb/motor_down_t \
sim:/elevator_tb/go_t \
sim:/elevator_tb/current_floor_t \
sim:/elevator_tb/come_t \
sim:/elevator_tb/clk_t \
sim:/elevator_tb/u1/next_state \
sim:/elevator_tb/u1/current_state
run 350ns