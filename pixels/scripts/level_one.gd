extends Node2D

@onready var player = $Player
@onready var attacker = $Player.attacker
@onready var enemyOne = $enemy_one
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.add_to_group("Boss Areas")
	reset_player_physics()
	reset_enemy_one_physics()
	change_animations()

			
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
func reset_enemy_one_physics():
	enemyOne.GRAVITY = 0
