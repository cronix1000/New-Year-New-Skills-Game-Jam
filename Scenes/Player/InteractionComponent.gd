extends Area2D

@onready var hold_timer = $HoldTimer

@export var player : Player = null

var is_item_in_range = false
var targeting_item = null


func _ready():
	if not player:
		player = owner
	body_entered.connect(func(_body): is_item_in_range = true; targeting_item = _body)
	body_exited.connect(func(_body): is_item_in_range = false; targeting_item = null)
	area_entered.connect(func(_body): is_item_in_range = true; targeting_item = _body)
	area_exited.connect(func(_body): is_item_in_range = false; targeting_item = null)
	hold_timer.timeout.connect(pickup)


func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and is_item_in_range:
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
			PlayerStats.emit_signal("limb_removed", "Arm1")
	# Release Arm2
	if Input.is_action_just_pressed("drop2"):
		if not player.get_node("Limbs/Arm2").get_children().is_empty():
			limb = player.get_node("Limbs/Arm2").get_children()[0]
			player.get_node("Limbs/Arm2").remove_child(limb)
			PlayerStats.limbs["Arm2"] = null
	# Release Arm3
	if Input.is_action_just_pressed("drop3"):
		if not player.get_node("Limbs/Leg1").get_children().is_empty():
			limb = player.get_node("Limbs/Leg1").get_children()[0]
			player.get_node("Limbs/Leg1").remove_child(limb)
			PlayerStats.limbs["Leg1"] = null
	# Release Arm4
	if Input.is_action_just_pressed("drop4"):
		if not player.get_node("Limbs/Leg2").get_children().is_empty():
			limb = player.get_node("Limbs/Leg2").get_children()[0]
			player.get_node("Limbs/Leg2").remove_child(limb)
			PlayerStats.limbs["Leg2"] = null
	if limb:
		get_tree().current_scene.add_child(limb)
		limb.get_node("CollisionShape2D").disabled = false
		limb.global_position = Vector2(player.global_position.x, player.global_position.y +14)


func pickup():
	if is_item_in_range:
		if targeting_item.is_in_group("key"):
			targeting_item.pickup()
		elif targeting_item.is_in_group("limb"):
			var _name = targeting_item.name.erase(4,10)
			PlayerStats.limbs[_name] = _name
			PlayerStats.emit_signal("limb_changed", _name)
			targeting_item.queue_free()
