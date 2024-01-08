extends Entity

var state


func load_limb(limb_name : String):
	var scene = load("res://Scenes/Limbs/" + limb_name + ".tscn")
	var scene_node = scene.instantiate()
	return scene_node;


func _ready():
	PlayerStats.connect("limb_changed", Callable(self, "add_limb"))
	
	
func add_limb(body_part):
	var node = get_node("Limbs/" + body_part)
	var limb = load_limb(PlayerStats.limbs[body_part])
	node.add_child(limb)
	change_states()
	
	
func change_states():
	match(PlayerStats.arm_count):
		0:
			match(PlayerStats.leg_count):
				0:
					state = %NoArmsNoLegs
				1:
					state = %NoArmsOneLeg
				2:
					state = %NoArmTwoLegs
		1:
			match(PlayerStats.leg_count):
				0:
					state = %OneArmNolegs
				1:
					state = %OneArmOneLeg
				2:
					state = %OneArmTwoLegs
		2:
			match(PlayerStats.leg_count):
				0:
					state = %TwoArmsNoLegs
				1:
					state = %TwoArmsOneLeg
				2:
					state = %TwoArmsTwoLegs
					
	
func _process(delta):
	if get_node("Limbs/Arm1").get_child(0):
		print(get_node("Limbs/Arm1").get_child(0).name)
		
	state.move()
