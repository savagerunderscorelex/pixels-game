extends Node2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "SwordHitboxArea":
		print("i've been hit")
