@tool
extends CharacterBody2D
class_name Entity


@export var movement_speed : int = 35.0
@export var hp_total : int = 0
var hp : int = hp_total : set = set_hp
@export var defence : int = 0
var interacting

@onready var player : AnimationPlayer = $AnimationPlayer
@onready var character_sprite : Sprite2D = $CharacterSprite
@onready var hurt_box = $Hurt_Box

signal hp_changed(new_hp)
signal hp_max_changed(new_total_hp)
signal has_died

var is_facing_left : bool: 
	get: return $CharacterSprite.flip_h
var is_facing_right : bool: 
	get: return not $CharacterSprite.flip_h


func load_ability(ability_name : String):
	var scene = load("res://Scenes/Abilities/" + ability_name + ".tscn")
	var scene_node = scene.instantiate()
	add_child(scene_node)
	return scene_node;

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_total)
		emit_signal("hp_changed", hp)
		if(hp == 0):
			emit_signal("has_died")
	
func set_hp_total(value):
	if value != hp_total:
		hp_total = max(0, value)
		emit_signal("hp_max_changed", hp_total)
		self.hp = hp

func _on_hurt_box_area_entered(hitbox):
	print(hitbox.name)
	if(hitbox.is_in_group("hitbox")):
		var base_damage = hitbox.damage
		self.hp -= base_damage
	if(hitbox.is_in_group("interact")):
		interacting = hitbox.name
		print(hitbox.name)
		

	# switch to actual recieve damage funtion


func _on_hurt_box_area_exited(area):
	interacting = null
