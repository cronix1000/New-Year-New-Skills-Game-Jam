extends Area2D


@export var id : int = 0

var can_pickup = true


func pickup():
	if can_pickup:
		PlayerStats.items["keys"].append(self)
		PlayerStats.emit_signal("collected_item", self)
		get_parent().remove_child(self)
