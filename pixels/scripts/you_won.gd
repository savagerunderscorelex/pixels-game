extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var wonMessage: RichTextLabel = $Control/RichTextLabel
@onready var areasss: Area2D = $YouWon

func _ready() -> void:
	globals.change_scene_music(self,$AudioStreamPlayer)
	await get_tree().create_timer(30).timeout
	$Panel.visible = true

func _physics_process(delta: float) -> void:
	self.add_to_group("Boss Areas")
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


func _on_you_won_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("hey")
		areasss.set_deferred("monitoring", false)
		
		while wonMessage.global_position.x > 550: # I feel so smart figuring this out lol
			wonMessage.global_position.x -= 2
			await get_tree().create_timer(0.006).timeout
			
		


func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/enter.tscn")
