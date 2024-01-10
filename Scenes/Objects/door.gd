extends StaticBody2D

@export var key_id : int = 0


func _on_interaction_area_area_entered(area):
	for key in PlayerStats.items["keys"]:
		if key.id == key_id:
			# PlayerStats.items["keys"].erase(key)
			open()


func open():
	queue_free()
