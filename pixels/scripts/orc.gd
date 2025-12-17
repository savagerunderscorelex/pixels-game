extends CharacterBody2D

# Issue Notes: 
# Fixed Orc sitting on player issue by disabling floor layer 1 and setting on leave to do nothing in CharacterBody2D node

@onready var animator: AnimatedSprite2D = $Animator
@onready var attacker: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $AxeHitbox 
var isDead: bool = false

var CHARACTER_SPEED: int = 150
var isAttacking: bool = false
var player = null
var health: int = 60
var attack_damage: int = 25

func _ready() -> void:
	self.add_to_group("Enemies") # For Sword Processing

func _physics_process() -> void:
	update_animation()
	check_for_dead() # Check if orc is dead
	health_function()

	move_to_player() # Chase feature
	move_and_slide() # Physics stuff
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body

		
func _on_player_detection_body_exited(body: Node2D) -> void:
	match body.name: # Match statement, switch in other languages (just found out about them, wanted to try it out :3)
		"Player":
			player = null

func flip_self(): # Flipping the orc based on where the player is
	if player.position.x <= 0:
		animator.flip_h = true
		get_node("AxeHitbox").set_scale(Vector2(-1, 1))
	elif player.position.x > 0:
		animator.flip_h = false
		get_node("AxeHitbox").set_scale(Vector2(1, 1))

func check_for_dead():
	if isDead == true:
		velocity = velocity * 0
		animator.pause()
		attacker.play("death")
		
func do_attack():
	if isAttacking == true:
		print("too close now!") # debug :(
		velocity = velocity * 0	

func health_function():
	if health <= 0:
		isDead = true
		await get_tree().create_timer(2).timeout
		self.queue_free()
		
func update_animation():
	if isAttacking == false && isDead == false: # Not attacking
		if velocity == Vector2(0,0): # If orc is still
			animator.play("idle")
		else:
			if player:
				if player.position.x < 0:
					animator.flip_h = true
					get_node("AxeHitbox").set_scale(Vector2(-1, 1))
				elif player.position.x > 0:
					animator.flip_h = false
					get_node("AxeHitbox").set_scale(Vector2(1, 1))
				animator.play("walk")
	elif isDead == true:
		velocity = Vector2.ZERO
		attacker.play("death")
	else: 
		attacker.play("attack")

func move_to_player():
	velocity = Vector2.ZERO
	if player && isAttacking == false && isDead == false:
		velocity = position.direction_to(player.position) * CHARACTER_SPEED
		flip_self()

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isAttacking = true
		do_attack()

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(1).timeout
		isAttacking = false
		
func take_damage(attack: Attack):
	health -= attack.attack_damage
	print("taken damage!")


func _on_axe_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player" && body.has_method("take_damage"): # Original issue was that the orc hurtbox and player hurtbox had the same name
		var attack = Attack.new()
		attack.attack_damage = attack_damage

		body.take_damage(attack)

		$SwordSlashEffect.play()
		print("heehee you've been hit, fellow player >:)")
