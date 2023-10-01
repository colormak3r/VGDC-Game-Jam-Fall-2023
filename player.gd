extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var gravity : float = 250

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var spawn_point = $"../SpawnPoint"
@onready var collision_shape_2d = $CollisionShape2D
@onready var player = $"."

var is_on_dimension1: bool = true

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
		velocity.y = jump_velocity
		
#	if Input.is_action_just_pressed("swap") and  is_on_dimension1:
#		is_on_dimension1 = false
#		player.set_collision_mask_value(2, true)
#	else:
#		is_on_dimension1 = true
#		player.set_collision_mask_value(1, true)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	# Flip sprite by direction
	if direction != 0 :
		animated_sprite_2d.flip_h = direction > 0
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	

func _on_reset_box_body_entered(body):
	reset_spawn()

func reset_spawn():
	player.position = spawn_point.position
	
