extends RichTextLabel

var movingDistance: float = 0.05
var atPlace: bool = false

@export var end: int
@export var start: int 

func _physics_process(delta: float) -> void:
	move_self()
	
func move_self():
	while get_parent().is_in_group("Levels") && get_parent() != null:
		if atPlace == false:
			while self.global_position.x > end:
				self.position.x -= movingDistance
				await get_tree().create_timer(0.05).timeout
			atPlace = true
		elif atPlace == true:
			while self.global_position.x < start:
				self.position.x += movingDistance
				await get_tree().create_timer(0.05).timeout
			atPlace = false
