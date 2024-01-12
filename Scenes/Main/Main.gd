extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var cutscene_one = %cutscene_one
@onready var player : Player = %Player

func _ready():
	PlayerStats.limbs["Arm1"] = "Arm1"
	PlayerStats.emit_signal("limb_changed", "Arm1")
	PlayerStats.limbs["Arm2"] = "Arm2"
	PlayerStats.emit_signal("limb_changed", "Arm2")
	
	
func _on_cutscene_one_area_entered(area):
	print("cutscene")
	animation_player.play("Cutscene")
	player.change_state("cut_scene")
	


func _on_animation_player_animation_finished(anim_name):
	player.change_state("idle")
