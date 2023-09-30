extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity : float = 250
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var spawn_point = $"../SpawnPoint"
@onready var player = $"."

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		animated_sprite_2d.play("Idle")
	else :
		animated_sprite_2d.play("Jump")
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():		
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	# Flip sprite by direction
	if direction != 0 :
		animated_sprite_2d.flip_h = direction > 0
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_reset_box_body_entered(body):
	reset_spawn()

func reset_spawn():
	player.position = spawn_point.position
	
