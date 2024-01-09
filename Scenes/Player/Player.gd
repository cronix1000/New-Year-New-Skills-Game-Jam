class_name Player
extends Entity

var limb_state
var state : State
var state_factory

var jump_force := 0.00
#var 
# Custom Bools
var can_climb = true
var can_jump
var can_crouch
@onready var Arm1 = %Arm1
@onready var Arm2 = %Arm2
@onready var Leg1 = %Leg1
@onready var Leg2 = %Leg2


func load_limb(limb_name : String):
	var scene = load("res://Scenes/Limbs/" + limb_name + ".tscn")
	var scene_node = scene.instantiate()
	return scene_node;


func _ready():
	PlayerStats.connect("limb_changed", Callable(self, "add_limb"))
	state_factory = StateFactory.new()
	change_state("idle")
	
func add_limb(body_part):
	var node = get_node("Limbs/" + body_part)
	var limb = load_limb(PlayerStats.limbs[body_part])
	node.add_child(limb)
	change_states()
	
	
func flip_limbs():
	var arm1_node = null
	var arm2_node = null
	var leg1_node = null
	var leg2_node = null
	if(Arm1.get_child_count() == 1):
		arm1_node = Arm1.get_child(0) 
		print("Got arm1")
		Arm1.remove_child(arm1_node)
	if(Arm2.get_child_count() == 1):
		arm2_node = Arm2.get_child(0)
		print("got arm2")
		Arm2.remove_child(arm2_node)
	if(Leg1.get_child_count() == 1):
		leg1_node = Leg1.get_child(0) 
		Leg1.remove_child(leg1_node)
	if(Leg2.get_child_count() == 1):
		leg2_node = Leg2.get_child(0) 
		Leg2.remove_child(leg2_node)
	
	if(arm2_node != null):
		Arm1.add_child(arm2_node)
	if(arm1_node != null):
		Arm2.add_child(arm1_node)
	if(leg2_node != null):
		Leg1.add_child(leg2_node)
	if(leg1_node != null):
		Leg2.add_child(leg1_node)
	
	
	
func animate_limbs(animation_name):
	var arm1_node = null
	var arm2_node = null
	var leg1_node = null
	var leg2_node = null
	if(Arm1.get_child_count() == 1):
		arm1_node = Arm1.get_child(0) 
		arm1_node.get_node("AnimationPlayer").play(animation_name)
	if(Arm2.get_child_count() == 1):
		arm2_node = Arm2.get_child(0)
		arm2_node.get_node("AnimationPlayer").play(animation_name)
	if(Leg1.get_child_count() == 1):
		leg1_node = Leg1.get_child(0) 

	if(Leg2.get_child_count() == 1):
		leg2_node = Leg2.get_child(0) 


func change_states():
	match(PlayerStats.arm_count):
		0:
			match(PlayerStats.leg_count):
				0:
					limb_state = %NoArmsNoLegs
				1:
					limb_state = %NoArmsOneLeg
				2:
					limb_state = %NoArmTwoLegs
		1:
			match(PlayerStats.leg_count):
				0:
					limb_state = %OneArmNolegs
				1:
					limb_state = %OneArmOneLeg
				2:
					limb_state = %OneArmTwoLegs
		2:
			match(PlayerStats.leg_count):
				0:
					limb_state = %TwoArmsNoLegs
				1:
					limb_state = %TwoArmsOneLeg
				2:
					limb_state = %TwoArmsTwoLegs
		
	limb_state.change_stats()
	
func _process(delta):
	if(Input.is_action_pressed("Left")):
		move_left()
	if(Input.is_action_pressed("Right")):
		move_right()
	
	
func move_left():
	state.move_left()

func move_right():
	state.move_right()

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(Callable(self, "change_state"), $AnimationPlayer,$CharacterSprite ,self)
	state.name = "current_state"
	add_child(state)


