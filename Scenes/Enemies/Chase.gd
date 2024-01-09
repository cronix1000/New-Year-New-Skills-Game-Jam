extends State

@export var enemy : Entity
@export var attack_trigger : Area2D


func enter():
	attack_trigger.body_entered.connect(func(): emit_signal("transitioned", self, "attack"))


func exit():
	attack_trigger.body_entered.disconnect(func(): emit_signal("transitioned", self, "attack"))


func update(_delta : float):
	pass


func physics_update(_delta : float):
	if !enemy.is_player_in_range:
		emit_signal("transitioned", self, "idle")
		return
	enemy.velocity.x = 1 if enemy.get_player.global_position.x > enemy.global_position.x else -1
	enemy.velocity.x *= enemy.movement_speed
	enemy.move_and_slide()
