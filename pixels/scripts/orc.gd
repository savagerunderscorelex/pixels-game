extends CharacterBody2D

# Issue Notes: 
# Fixed Orc sitting on player issue by disabling floor layer 1 and setting on leave to do nothing in CharacterBody2D node
var CHARACTER_SPEED: int = 150
var isAttacking = false
@onready var animator = $Sprite2D
var player = null

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	update_animation()
	move_to_player()
	move_and_slide()
	attack()
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		
func _on_player_detection_body_exited(body: Node2D) -> void:
	player = null

func flip_self():
	if player.position.x < 0:
		animator.flip_h = true
	else:
		animator.flip_h = false
	animator.play("walk")
	
func attack():
	if player:
		var distanceFromPlayer = position.distance_squared_to(player.position)
		if distanceFromPlayer < 1:
			print("too close now!")
			velocity = Vector2(0,0)
			animator.play("attack")

func update_animation():
	if !isAttacking && velocity == Vector2(0,0):
		animator.play("idle")

func move_to_player():
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * CHARACTER_SPEED
		flip_self()
