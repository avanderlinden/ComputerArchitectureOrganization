onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_tb/mips_0/registersmap/registers
add wave -noupdate /mips_tb/mips_0/clk
add wave -noupdate /mips_tb/mips_0/controlmap/instruction
add wave -noupdate /mips_tb/mips_0/alucontrolmap/instruction
add wave -noupdate -radix decimal /mips_tb/mips_0/alumap/data1
add wave -noupdate -radix decimal /mips_tb/mips_0/alumap/data2
add wave -noupdate -radix decimal /mips_tb/mips_0/alumap/result
add wave -noupdate /mips_tb/mips_0/alumap/sraBit
add wave -noupdate /mips_tb/mips_0/jalsel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21246 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 302
configure wave -valuecolwidth 93
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {41430 ps}
