extends Node

var power = 0 setget set_power

signal power_changed(po)

func add_power(val):

	power += val/100.0
	
	emit_signal("power_changed", power)
	
func set_power(val):
	print("use função add_power")

