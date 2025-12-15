extends Node2D

@onready var detect: Area2D = $PlayerDetection

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().call_deferred("reload_current_scene") # Using this because the debugger said that removing the collision body during a frame will cause problems
