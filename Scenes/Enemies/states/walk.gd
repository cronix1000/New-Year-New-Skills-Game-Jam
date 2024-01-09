extends State

@export var enemy : Entity
@export var anim : AnimatedSprite2D

var walk_time : float

func enter():
	anim.play("walk")
	walk_time = randf_range(1, 3)
	enemy.velocity.x = 1 if enemy.is_facing_right else -1
	enemy.velocity.x *= enemy.movement_speed


func exit():
	pass


func update(_delta : float):
	walk_time -= _delta
	if walk_time <= 0:
		emit_signal("transitioned", self, "idle")
	if enemy.is_player_in_range:
		emit_signal("transitioned", self, "chase")


func physics_update(_delta : float):
	enemy.move_and_slide()
