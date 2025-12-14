extends Control

# Watched a video about how statically typing kind of improves speed, thought it was a good habit to try out
# I did do this when first starting out with Godot, but that was because the tutorial guys did that
@onready var completeLevels : RichTextLabel = $RichTextLabel2
@onready var defeatOrc : RichTextLabel = $RichTextLabel3
@onready var dontDie : RichTextLabel = $RichTextLabel4
@onready var button : Button = $Button


func _ready() -> void:
	completeLevels.visible = false
	defeatOrc.visible = false
	dontDie.visible = false
	button.visible = false
	button.disabled = true
	
func _process(delta: float) -> void:
	show_goals()
	
func show_goals(): # Showing each goal after 3.5 secs to match up with the music :3
	await get_tree().create_timer(3.5).timeout
	completeLevels.visible = true
	await get_tree().create_timer(3.5).timeout
	defeatOrc.visible = true
	await get_tree().create_timer(3.5).timeout
	dontDie.visible = true
	await get_tree().create_timer(3.5).timeout
	next_button_appear()

func next_button_appear():
	button.visible = true
	button.disabled = false

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_two.tscn")
	#ac6963
