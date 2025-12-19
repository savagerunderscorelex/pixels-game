extends Node2D

@onready var secondCamera = $SecondPanelCamera # Camera that is focused on the second background

@onready var description = $CanvasLayer/RichTextLabel2

func _ready() -> void:
	globals.change_scene_music(self,$AudioStreamPlayer)
	secondCamera.enabled = false
	self.add_to_group("Levels")

	$Player.CHARACTER_SPEED = 190 # Made character slower to originally match with timing for the video

func _on_right_first_panel_boundary_body_entered(body: Node2D) -> void: # When the player enters this area, the camera is changed (2nd Camera)
	if body.name == "Player":
		secondCamera.enabled = !secondCamera.enabled


func _on_to_next_level_body_entered(body: Node2D) -> void: # Changes Scene to Level 2
	if body.name == "Player":
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/goals.tscn")
