extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var attacker: AnimationPlayer = $Player.attacker
@onready var currentOrc = null
@onready var orcHealthBar: ProgressBar = $Orc/ProgressBar
@onready var orcHealthDisplay: RichTextLabel = $Orc/ProgressBar/RichTextLabel2

func _ready() -> void:
	if get_tree().get_first_node_in_group("Enemies") == $Orc:
		currentOrc = $Orc
		orcHealthBar.value = currentOrc.health
		orcHealthBar.max_value = 60

func _physics_process(delta: float) -> void:
	self.add_to_group("Boss Areas")
	reset_player_physics()
	change_animations()
	
	if currentOrc != null:
		var orcHealth = currentOrc.health
		orcHealthBar.value = currentOrc.health		
		orcHealthDisplay.text = "Orc Health: %s" %[str(orcHealth)]
		

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
