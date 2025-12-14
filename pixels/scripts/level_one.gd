extends Node2D

@onready var secondCamera = $SecondPanelCamera # Camera that is focused on the second background

func _ready() -> void:
	secondCamera.set_enabled(false) # Is not enabled at the start of the scene loading, since the character has to walk throughout the whole scene
	$Player.CHARACTER_SPEED = 190 # Made character slower to originally match with timing for the video

func _on_right_first_panel_boundary_body_entered(body: Node2D) -> void: # When the player enters this area, the camera is changed
	if body.name == "Player":
		secondCamera.enabled = !secondCamera.enabled


func _on_to_next_level_body_entered(body: Node2D) -> void: # Changes Scene to Level 2
	if body.name == "Player":
		$RichTextLabel3.queue_free()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/goals.tscn")
