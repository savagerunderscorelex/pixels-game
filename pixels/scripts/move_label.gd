extends RichTextLabel
var movingDistance: float = 0.05
var atPlace: bool = false

func _process(delta: float) -> void:
	move_self()
	
func move_self():
	if atPlace == false:
		while self.global_position.x > 750:
			self.position.x -= movingDistance
			await get_tree().create_timer(0.05).timeout
		atPlace = true
	elif atPlace == true:
		while self.global_position.x < 800:
			self.position.x += movingDistance
			await get_tree().create_timer(0.05).timeout
		atPlace = false
