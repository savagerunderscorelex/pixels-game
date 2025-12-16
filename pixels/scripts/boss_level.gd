extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var attacker: AnimationPlayer = $Player.attacker
@onready var currentOrc = null
@onready var orcHealthBar: ProgressBar = $Orc/ProgressBar
@onready var orcHealthDisplay: RichTextLabel = $Orc/ProgressBar/RichTextLabel2
@onready var playerHealthBar: ProgressBar = $Player/ProgressBar
@onready var playerHealthDisplay: RichTextLabel = $Player/ProgressBar/RichTextLabel2
@onready var resetButton: Button = $CanvasLayer/Button

func _ready() -> void:
	if get_tree().get_first_node_in_group("Enemies") == $Orc:
		currentOrc = $Orc
		orcHealthBar.value = currentOrc.health
		orcHealthBar.max_value = 60
	
	playerHealthBar.max_value = 100
	playerHealthBar.value = player.health

func _physics_process(delta: float) -> void:
	self.add_to_group("Boss Areas")
	reset_player_physics()
	change_animations()
	
	if currentOrc != null:
		var orcHealth = currentOrc.health
		orcHealthBar.value = currentOrc.health		
		orcHealthDisplay.text = "Orc Health: %s" %[str(orcHealth)]
		
	if player != null:
		playerHealthBar.value = player.health
		playerHealthDisplay.text = "Your Health: %s" %[str(player.health)]
		

# Player reset stuff 
func reset_player_physics():
	if player != null:
		player.GRAVITY = 0
		var direction = Input.get_vector("left", "right", "jump", "dive")
		player.velocity = direction * player.CHARACTER_SPEED
	
func change_animations():
	if player:
		if player.isDead == false:
			if player.velocity.x != 0 || player.velocity.y != 0 :
				if player.isAttacking == false:
					player.animator.play("walk")
			elif player.velocity.x == 0 && player.velocity.y == 0:
				if player.isAttacking == false:
					player.animator.play("idle")
	else:
		await get_tree().create_timer(3).timeout
		resetButton.disabled = false
		resetButton.visible = true
		
	


func _on_button_pressed() -> void:
	get_tree().call_deferred("reload_current_scene")
