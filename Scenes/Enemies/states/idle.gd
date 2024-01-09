extends State

@export var enemy : Entity
@export var anim : AnimatedSprite2D

var idle_time : float

func enter():
	enemy.velocity = Vector2.ZERO
	anim.play("idle")
	idle_time = randf_range(1, 3)


func exit():
	pass


func update(_delta : float):
	idle_time -= _delta
	if idle_time <= 0:
		emit_signal("transitioned", self, "walk")
	if enemy.is_player_in_range:
		emit_signal("transitioned", self, "chase")


func physics_update(_delta : float):
	pass
