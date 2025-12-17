extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var movingLabel: RichTextLabel = $RichTextLabel3


var isScene : bool = true
	
func _physics_process(delta: float) -> void:
	self.add_to_group("Boss Areas")
	self.add_to_group("Levels")
	reset_player_physics()
	change_animations()

# Player reset stuff 
func reset_player_physics():
	player.GRAVITY = 0
	var direction = Input.get_vector("left", "right", "jump", "dive")
	player.velocity = direction * player.CHARACTER_SPEED
	
func change_animations():
	if player.velocity.x != 0 || player.velocity.y != 0:
		if player.isAttacking == false:
			player.animator.play("walk")
	elif player.velocity.x == 0 && player.velocity.y == 0:
		if player.isAttacking == false:
			player.animator.play("idle")

func _on_to_next_level_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$RichTextLabel3.queue_free()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/level_one.tscn")
