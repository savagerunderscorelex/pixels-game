extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# self.text = "[wave amp=90 freq=100] wavey is so wavey and i like gravy [/wave]"
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "[wave amp=200.0 freq=9.0 connected=0]You Won!!![/wave]"
	pass
