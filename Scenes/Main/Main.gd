extends Node2D


func _ready():
	PlayerStats.limbs["Arm1"] = "Arm1"
	PlayerStats.emit_signal("limb_changed", "Arm1")
	PlayerStats.limbs["Arm2"] = "Arm2"
	PlayerStats.emit_signal("limb_changed", "Arm2")
	
	

