extends "res://Scenes/Entitiy/Entity.gd"

@export var jump_velocity = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_player_in_range : bool = false
var get_player = null


func _ready():
	$PlayerDetectionArea.connect("body_entered", func(_body): is_player_in_range = true; get_player = _body)
	$PlayerDetectionArea.connect("body_exited", func(_body): is_player_in_range = false)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
		$CharacterSprite.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
		$CharacterSprite.flip_h = false

	move_and_slide()
