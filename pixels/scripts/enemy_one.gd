extends CharacterBody2D

@onready var animator = $AnimationPlayer
@onready var player = get_parent().get_node("Player")
@onready var hurtbox = $Area2D


var GRAVITY : int = 750
var speed = 100
var isAlive = true
var hasBeenAttacked = false
	
func _physics_process(delta: float) -> void:

	updateMovement(delta)
	playMoving()
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		hasBeenAttacked = false
		
func playMoving():
	hurtbox.add_to_group("Enemies")
	if isAlive == true && hasBeenAttacked == false:
		animator.play("move")
	elif isAlive == true && hasBeenAttacked == true:
		animator.play("hit")
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		hasBeenAttacked = true
		print("im hit :(")

func updateMovement(delta: float) -> void:
	velocity.y += GRAVITY * delta

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pass #print('hey! listen')
		
