extends Area2D

@onready var hold_timer = $HoldTimer

@export var player : Player = null

var is_pickup_in_range = false
var targeting_limb = null


func _ready():
	if !player:
		player = owner
	body_entered.connect(func(_body): is_pickup_in_range = true; targeting_limb = _body)
	body_exited.connect(func(_body): is_pickup_in_range = false; targeting_limb = null)
	hold_timer.timeout.connect(pickup)


func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and is_pickup_in_range:
		hold_timer.start()
		
	if Input.is_action_just_released("interact"):
		hold_timer.stop()


func pickup():
	if targeting_limb:
		var _name = targeting_limb.name
		PlayerStats.limbs[_name] = _name
		PlayerStats.emit_signal("limb_changed", _name)
