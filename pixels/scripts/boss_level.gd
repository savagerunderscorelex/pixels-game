extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var attacker: AnimationPlayer = $Player.attacker
@onready var orc: CharacterBody2D = $Orc



func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	self.add_to_group("Boss Areas")
	reset_player_physics()
	change_animations()
	check_for_orc()

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

func check_for_orc():	
	if orc.isDead == true:
		orc.queue_free()
		
		await get_tree().create_timer(3).timeout
		
		
		orc.queue_redraw()
		orc.isDead = false
