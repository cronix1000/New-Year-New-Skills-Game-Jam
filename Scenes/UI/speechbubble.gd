extends Area2D

@onready var anim = $AnimationPlayer


func _ready():
	var shape = get_node("CollisionShape2D") as CollisionShape2D
	connect("body_entered", func(_body): 
		anim.play("appear")
	)


func _process(delta):
	if Input.is_action_just_pressed("interact"):
		anim.play_backwards("appear")
		await anim.animation_finished
		queue_free()
