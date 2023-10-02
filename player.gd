extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var gravity : float = 250

@export var dimension_1_tile_map : TileMap
@export var dimension_2_tile_map : TileMap

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var spawn_point = $"../SpawnPoint"
@onready var collision_shape_2d = $CollisionShape2D
@onready var player = $"."
@onready var timer = $"../Timer"

func _ready():
	for fire in dimension_1_tile_map.get_children(): 
		fire.fire_triggered.connect(_on_fire_triggered)
	for fire in dimension_2_tile_map.get_children(): 
		fire.fire_triggered.connect(_on_fire_triggered)
	timer.start()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		animated_sprite_2d.play("Walk")
	else :
		animated_sprite_2d.play("Jump")
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():		
		velocity.y = jump_velocity
	
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

func _on_fire_triggered() :
	reset_spawn()

func reset_spawn():
	
	player.position = spawn_point.position



func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")
