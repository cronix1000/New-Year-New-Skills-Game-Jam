extends StaticBody2D

@export var key_id : int = 0


func _on_interaction_area_area_entered(area):
	#for key in PlayerStats.items["keys"]:
	#	if key.id == key_id:
	#		PlayerStats.items["keys"].erase(key)
	#		
	#		open()
	if(int(PlayerStats.limbs["Arm1"].substr(3, 10)) == key_id):
		PlayerStats.limbs["Arm1"] = PlayerStats.temp_limbs["Arm1"]
		PlayerStats.temp_limbs["Arm1"] = null
		PlayerStats.emit_signal("limb_changed", "Arm1")
		open()
	elif(int(PlayerStats.limbs["Arm2"].substr(3)) == key_id):
		PlayerStats.limbs["Arm2"] = PlayerStats.temp_limbs["Arm2"]
		PlayerStats.temp_limbs["Arm1"] = null
		PlayerStats.emit_signal("limb_changed", "Arm2")
		open()

func open():
	queue_free()
