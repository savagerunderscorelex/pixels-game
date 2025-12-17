extends Control

@onready var howToPlayDescription: Panel = $Panel

func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/leaving_home.tscn")


func _on_how_2_play_button_pressed() -> void:
	howToPlayDescription.visible = true


func _on_close_how_2_play_pressed() -> void:
	howToPlayDescription.visible = false
