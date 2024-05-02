# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BARAXI" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BARSIZE" -parent ${Page_0}
  set READ32_ONCE [ipgui::add_param $IPINST -name "READ32_ONCE" -parent ${Page_0}]
  set_property tooltip {TRUE read and latch 32-bit axi data on LB LW read. return latched data when LB HW read. used for modules with read self clear register bits. FALSE read the same 32-bit data twice, return HW or LW based on the LB address.} ${READ32_ONCE}
  set WRITE32_ONCE [ipgui::add_param $IPINST -name "WRITE32_ONCE" -parent ${Page_0}]
  set_property tooltip {TRUE combine two 16-bit LB writes into one 32-bit axi write when LB HW is written. used for modules do not support axi_wstrb. FALSE issue 32-bit axi write using axi_wstrb for each LB 16-bit write.} ${WRITE32_ONCE}


}

proc update_PARAM_VALUE.BARAXI { PARAM_VALUE.BARAXI } {
	# Procedure called to update BARAXI when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BARAXI { PARAM_VALUE.BARAXI } {
	# Procedure called to validate BARAXI
	return true
}

proc update_PARAM_VALUE.BARSIZE { PARAM_VALUE.BARSIZE } {
	# Procedure called to update BARSIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BARSIZE { PARAM_VALUE.BARSIZE } {
	# Procedure called to validate BARSIZE
	return true
}

proc update_PARAM_VALUE.READ32_ONCE { PARAM_VALUE.READ32_ONCE } {
	# Procedure called to update READ32_ONCE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.READ32_ONCE { PARAM_VALUE.READ32_ONCE } {
	# Procedure called to validate READ32_ONCE
	return true
}

proc update_PARAM_VALUE.WRITE32_ONCE { PARAM_VALUE.WRITE32_ONCE } {
	# Procedure called to update WRITE32_ONCE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WRITE32_ONCE { PARAM_VALUE.WRITE32_ONCE } {
	# Procedure called to validate WRITE32_ONCE
	return true
}


proc update_MODELPARAM_VALUE.WRITE32_ONCE { MODELPARAM_VALUE.WRITE32_ONCE PARAM_VALUE.WRITE32_ONCE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WRITE32_ONCE}] ${MODELPARAM_VALUE.WRITE32_ONCE}
}

proc update_MODELPARAM_VALUE.READ32_ONCE { MODELPARAM_VALUE.READ32_ONCE PARAM_VALUE.READ32_ONCE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.READ32_ONCE}] ${MODELPARAM_VALUE.READ32_ONCE}
}

proc update_MODELPARAM_VALUE.M_AXI_ADDR_WIDTH { MODELPARAM_VALUE.M_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	# WARNING: There is no corresponding user parameter named "M_AXI_ADDR_WIDTH". Setting updated value from the model parameter.
set_property value 32 ${MODELPARAM_VALUE.M_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.BARAXI { MODELPARAM_VALUE.BARAXI PARAM_VALUE.BARAXI } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BARAXI}] ${MODELPARAM_VALUE.BARAXI}
}

proc update_MODELPARAM_VALUE.BARSIZE { MODELPARAM_VALUE.BARSIZE PARAM_VALUE.BARSIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BARSIZE}] ${MODELPARAM_VALUE.BARSIZE}
}

