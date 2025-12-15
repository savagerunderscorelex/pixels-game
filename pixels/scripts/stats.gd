extends Control

@onready var progressBar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progressBar.value = 70
	progressBar.max_value = 100
