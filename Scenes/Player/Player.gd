extends Entity

var arm_state
var leg_state


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
	if(PlayerStats.limbs["Arm1"] == null and PlayerStats.limbs["Arm2"] == null):
		arm_state = get_node("ArmStates/NoArms")
	elif(PlayerStats.limbs["Arm1"] == null or PlayerStats.limbs["Arm2"] == null):
		arm_state = get_node("ArmStates/OneArm")
	elif(PlayerStats.limbs["Arm1"] != null and PlayerStats.limbs["Arm2"] != null):
		arm_state = get_node("ArmStates/TwoArms")
	
	if(PlayerStats.limbs["Leg1"] == null and PlayerStats.limbs["Leg2"] == null):
		arm_state = get_node("LegStates/NoLegs")
	elif(PlayerStats.limbs["Leg1"] == null or PlayerStats.limbs["Leg2"] == null):
		arm_state = get_node("LegStates/OneLeg")
	elif(PlayerStats.limbs["Leg1"] != null and PlayerStats.limbs["Leg2"] != null):
		arm_state = get_node("LegStates/TwoLegs")
	
func _process(delta):
	if get_node("Limbs/Arm1").get_child(0):
		print(get_node("Limbs/Arm1").get_child(0).name)
		
	leg_state.move()
