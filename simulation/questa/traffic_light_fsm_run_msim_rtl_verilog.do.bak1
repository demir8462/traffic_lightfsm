transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ali/Desktop/VERILOGODEVLERI/trafficlightfsm/traffic_lightfsm {C:/Users/ali/Desktop/VERILOGODEVLERI/trafficlightfsm/traffic_lightfsm/traffic_light_fsm.sv}

vlog -sv -work work +incdir+C:/Users/ali/Desktop/VERILOGODEVLERI/trafficlightfsm/traffic_lightfsm {C:/Users/ali/Desktop/VERILOGODEVLERI/trafficlightfsm/traffic_lightfsm/tb_traffic_light_fsm.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_traffic_light_fsm

add wave *
view structure
view signals
run -all
