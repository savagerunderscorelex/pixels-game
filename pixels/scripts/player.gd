extends CharacterBody2D

var CHARACTER_SPEED = 250
var JUMP_SPEED = -CHARACTER_SPEED * 2
var GRAVITY = CHARACTER_SPEED * 3
var isAttacking = false
var isFlippedAttack = false
var inBossArea = false
var attack_damage: int = 20


@onready var hitbox = $SwordHitboxArea
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var attacker: AnimationPlayer = $AnimationPlayer
@onready var swordSlashEffect: AudioStreamPlayer = $SwordSlashEffect
@onready var swordSwingEffect: AudioStreamPlayer = $SwordSwingSound
@onready var currentLevel: Node2D = get_parent()
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	hurtbox.add_to_group("Player Areas")

func _physics_process(delta: float) -> void: # This function takes a float as an input
	get_input()
	update_areas()
	update_movement(delta)
	update_animation()
	move_and_slide() # Can only be used in a Character2D Node

func get_input() -> void: # -> void means returns void, which means that this function does not return a value
	if Input.is_action_just_pressed("jump") and is_on_floor() && inBossArea == false: # If the up buttons are pressed and the sprite is touching a solid object
		velocity.y = JUMP_SPEED # jumping height
	elif Input.is_action_just_pressed("hit"):
		isAttacking = true
		swordSwingEffect.play()
	elif Input.is_action_just_pressed("dive") && is_on_floor() == false:
		if inBossArea == false:
			print("erm diven")
			velocity.y -= JUMP_SPEED
	var direction = Input.get_axis("left", "right") # Gets 2 input actions for input, the right side of the assignment operator returns a value between -1 and 1, -1 for left, 1 for right
	velocity.x = direction * CHARACTER_SPEED # If direction is negative, the velocity direction is left, if direction is positive, the velocity value will make the sprite go right

func update_movement(delta: float) -> void:
	velocity.y += GRAVITY * delta

func update_animation() -> void:
	if isAttacking == false:
		if velocity.x == 0 && inBossArea == false: # Checks if the player is not moving, since the range for directions is -1 to 1, and 0 is no movement
			animator.play("idle") # Makes the current animation the idle animation
		elif velocity.x < 0: # After like an hour of reading godot forums, I got this to work. I didn't follow the tutorial version because it's code would shrink my sprite when it turned left or right
			animator.play("walk") # Also this version is way more easier to understand (and actually works!!)
			animator.flip_h = true # Opposite, makes the sprite flip horizontally, facing left
			get_node('SwordHitboxArea').set_scale(Vector2(-1, 1)) # flips x position of the sword box
		elif velocity.x > 0:
			animator.play("walk")
			animator.flip_h = false # Makes the sprite go back to the original position
			get_node('SwordHitboxArea').set_scale(Vector2(1, 1)) # resets x position of the sword hitbox
	else:
		# Remember (since I had an issue with this earlier): When an if statement is done resolving, it will go to the code next under it
		# I had an issue where I would put the play code in each part of the if statement when it wasn't necessary
		attacker.play("attack1")
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void: # 
	if anim_name == "attack1":
		print("done attacking")
		isAttacking = false

func update_areas():
	hitbox.add_to_group("Sword")
	if currentLevel.is_in_group("Boss Areas"):
		inBossArea = true

func _on_sword_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies") && body.has_method("take_damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		
		body.take_damage(attack)
		
		swordSlashEffect.play()
		print("hit enemy!")
