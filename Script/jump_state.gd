extends State

class_name JumpState

var jump_force = 300
var move_speed = 50
var min_move_speed = 0.005
var friction = 0.32

func _ready():
	
	move_speed = persistent_state.movement_speed
	if character_sprite.flip_h:
		move_speed *= -1
	persistent_state.velocity.y = -jump_force 
	
	#if(persistent_state.is_on_floor()):
	#	persistent_state.animate_limbs("climb")
	
func _physics_process(_delta):
	check_interactions()
	if !persistent_state.is_on_floor():
			persistent_state.velocity.y += 30
		
	persistent_state.velocity.x *= friction
	persistent_state.move_and_slide()
	

func move_left():
	if character_sprite.flip_h:
		#climb
		persistent_state.velocity.x += move_speed
	else:
		change_state.call("idle")

func move_right():
	if not character_sprite.flip_h:
		persistent_state.velocity.x += move_speed
	else:
		change_state.call("idle")
		
func check_interactions():
	if(persistent_state.interacting == "Cliff"):
		if(persistent_state.can_climb):
			change_state.call("climb_cliff")		

