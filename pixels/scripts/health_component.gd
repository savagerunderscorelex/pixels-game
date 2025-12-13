extends Control

@onready var completeLevels : RichTextLabel = $RichTextLabel2
@onready var defeatOrc : RichTextLabel = $RichTextLabel3
@onready var dontDie : RichTextLabel = $RichTextLabel4

func _ready() -> void:
	completeLevels.visible = false
	defeatOrc.visible = false
	dontDie.visible = false
	
func _process(delta: float) -> void:
	show_goals()
	
func show_goals():
	await get_tree().create_timer(4).timeout
	completeLevels.visible = true
