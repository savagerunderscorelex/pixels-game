extends Node2D

@onready var secondCamera = $SecondPanelCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	secondCamera.set_enabled(false)
	$Player.CHARACTER_SPEED = 190

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_right_first_panel_boundary_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		secondCamera.enabled = !secondCamera.enabled


func _on_to_next_level_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/you_won.tscn")
