extends State

@export var enemy : Entity
@export var anim : AnimatedSprite2D


func enter():
	anim.play("walk")


func exit():
	pass


func update(_delta : float):
	pass


func physics_update(_delta : float):
	pass
