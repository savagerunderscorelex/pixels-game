extends CharacterBody2D

# Issue Notes: 
# Fixed Orc sitting on player issue by disabling floor layer 1 and setting on leave to do nothing in CharacterBody2D node

@onready var animator = $Sprite2D
@onready var attacker = $AnimationPlayer
@onready var hitbox = $AxeHitbox

var CHARACTER_SPEED: int = 150
var isAttacking = false
var player = null

func _ready() -> void:
	hitbox.add_to_group("Enemy Hitboxes")

func _physics_process(delta: float) -> void:
	update_animation()
	move_to_player()
	move_and_slide()
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body

		
func _on_player_detection_body_exited(body: Node2D) -> void:
	match body.name: # Match statement, switch in other languages (just found out about them, wanted to try it out :3)
		"Player":
			player = null

func flip_self():
	if player.position.x <= 0:
		animator.flip_h = true
		get_node("AxeHitbox").set_scale(Vector2(-1, 1))
	elif player.position.x > 0:
		animator.flip_h = false
		get_node("AxeHitbox").set_scale(Vector2(1, 1))
	
func attack():
	if isAttacking == true:
		print("too close now!") # debug :(
		velocity = velocity * 0	

func update_animation():
	if isAttacking == false:
		if velocity == Vector2(0,0):
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
	else: 
		attacker.play("attack")

func move_to_player():
	velocity = Vector2.ZERO
	if player && isAttacking == false:
		velocity = position.direction_to(player.position) * CHARACTER_SPEED
		flip_self()

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isAttacking = true
		attack()

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(1).timeout
		isAttacking = false


func _on_axe_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Hurtbox":
		$SwordSlashEffect.play()
		print("heehee you've been hit, fellow player >:)")
		
