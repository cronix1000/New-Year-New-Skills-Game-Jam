extends Area2D

@onready var hold_timer = $HoldTimer

@export var player : Player = null

var is_pickup_in_range = false
var targeting_limb = null


func _ready():
	if not player:
		player = owner
	body_entered.connect(func(_body): is_pickup_in_range = true; targeting_limb = _body)
	body_exited.connect(func(_body): is_pickup_in_range = false; targeting_limb = null)
	hold_timer.timeout.connect(pickup)


func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and is_pickup_in_range:
		hold_timer.start()
		
	if Input.is_action_just_released("interact"):
		hold_timer.stop()
	
	var limb = null
	# Release Arm1
	if Input.is_action_just_pressed("drop1"):
		if not player.get_node("Limbs/Arm1").get_children().is_empty():
			limb = player.get_node("Limbs/Arm1").get_children()[0]
			player.get_node("Limbs/Arm1").remove_child(limb)
			PlayerStats.limbs["Arm1"] = null
			# todo: remove limb from playerstats
	# Release Arm2
	
	# Release Arm3
	
	# Release Arm4
	
	if limb:
		get_tree().current_scene.add_child(limb)
		limb.global_position = Vector2(player.global_position.x, player.global_position.y +14)


func pickup():
	if targeting_limb:
		var _name = targeting_limb.name
		PlayerStats.limbs[_name] = _name
		PlayerStats.emit_signal("limb_changed", _name)
		targeting_limb.queue_free()
