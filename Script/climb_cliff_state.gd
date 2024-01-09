extends State

class_name ClimbCliffState

var climb_speed = 50
var min_move_speed = 0.005
var friction = 0.32

func _ready():
	
	climb_speed = persistent_state.movement_speed
	if character_sprite.flip_h:
		climb_speed *= -1
	persistent_state.velocity.x += climb_speed
	if(persistent_state.is_on_floor()):
		persistent_state.animate_limbs("climb")
	
func _physics_process(_delta):
	if abs(persistent_state.velocity.y) < min_move_speed:
		change_state.call("idle")
	persistent_state.velocity.y *= friction
	persistent_state.move_and_slide()
	if(persistent_state.interacting == null):
		change_state.call("run")

func move_left():
	if character_sprite.flip_h:
		#climb
		persistent_state.velocity.y += climb_speed
	else:
		change_state.call("idle")

func move_right():
	if not character_sprite.flip_h:
		persistent_state.velocity.y += climb_speed
	else:
		change_state.call("idle")
