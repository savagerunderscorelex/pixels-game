extends Node2D

@onready var secondCamera = $SecondPanelCamera # Camera that is focused on the second background
@onready var thirdCamera = $ThirdPanelCamera
@onready var fourthCamera = $FourthPanelCamera

@onready var description = $CanvasLayer/RichTextLabel2

func _ready() -> void:
	self.add_to_group("Levels")
	secondCamera.enabled = false
	thirdCamera.enabled = false
	fourthCamera.enabled = false # Is not enabled at the start of the scene loading, since the character has to walk throughout the whole scene
	globals.change_scene_music(self,$AudioStreamPlayer)
	$Player.CHARACTER_SPEED = 200 # Made character slower to originally match with timing for the video

func _on_right_first_panel_boundary_body_entered(body: Node2D) -> void: # When the player enters this area, the camera is changed (2nd Camera)
	if body.name == "Player":
		secondCamera.enabled = !secondCamera.enabled

func _on_to_next_level_body_entered(body: Node2D) -> void: # Changes Scene to Level 2
	if body.name == "Player":
		await get_tree().create_timer(1.5).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/boss_level.tscn")


func _on_left_third_boundary_body_entered(body: Node2D) -> void: # For second to last section change
	if body.name == "Player":
		description.text = "Keep Going!"
		secondCamera.enabled = !secondCamera.enabled
		thirdCamera.enabled = !thirdCamera.enabled


func _on_left_fourth_boundary_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		thirdCamera.enabled = !thirdCamera.enabled
		fourthCamera.enabled = !fourthCamera.enabled
