extends Node

signal limb_changed(name)
signal limb_removed(name)
signal collected_item(item)

var arm_count := 0
var leg_count := 0

var limbs = {
	"Arm1" : null,
	"Arm2" : null,
	"Leg1" : null,
	"Leg2" : null,
}

var temp_limbs = {
	"Arm1" : null,
	"Arm2" : null,
	"Leg1" : null,
	"Leg2" : null,
}

var items = {
	"keys": []
}


func _ready():
	connect("limb_changed", Callable(self, "update_limb_count"))
	connect("limb_removed", Callable(self, "update_limb_count"))
	
func update_limb_count(name):
	arm_count = 0
	
	if(limbs["Arm1"] != null && limbs["Arm1"].substr(0,3) == "Arm"):
		arm_count = arm_count + 1
	if(limbs["Arm2"] != null && limbs["Arm2"].substr(0,3) == "Arm"):
		arm_count = arm_count + 1
	if(limbs["Leg1"] != null):
		leg_count = leg_count + 1
	if(limbs["Leg2"] != null):
		leg_count = leg_count + 1


