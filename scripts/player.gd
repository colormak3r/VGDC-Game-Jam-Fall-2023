extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var gravity : float = 250

@export var spawn_point : Node2D
@export var reset_box : Node2D

@export var center_of_map : Node2D
@export var max_distance_from_center :  float = 10000000

@export var dimension_1_tile_map : TileMap
@export var dimension_2_tile_map : TileMap

@export var timer : Timer
@export var medieval_bg : TextureRect
@export var scifi_bg : TextureRect
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var player = $"."

@onready var jump_audio_stream_player = $"Jump AudioStreamPlayer"

var background_active : bool = true
var respawning : bool = false
var lerp_weight : float = 0

func _ready():
	# Connect the player to dimention 1 fires
	if dimension_1_tile_map.get_children().size() > 0 :
		for fire in dimension_1_tile_map.get_children(): 
			if fire.has_signal("fire_triggered"):
				fire.fire_triggered.connect(_on_fire_triggered)
		
	# Connect the player to dimention 2 fires
	if dimension_2_tile_map.get_children().size() > 0 :
		for fire in dimension_2_tile_map.get_children(): 
			if fire.has_signal("fire_triggered"):
				fire.fire_triggered.connect(_on_fire_triggered)
	BgMusic.play_music()
	# Starting the countdown timer for the current level.
#	timer.start()
		
	# Connect the player to the reset box
	reset_box.resetbox_triggered.connect(_on_resetbox_triggered)

func _physics_process(delta):
	if respawning:
		if lerp_weight < 1:
			player.position = lerp(player.position,spawn_point.position,lerp_weight)
			animated_sprite_2d.rotation_degrees = lerpf(animated_sprite_2d.rotation_degrees, (1 if  animated_sprite_2d.flip_h else -1) * 360,lerp_weight)
			lerp_weight += delta
		else :
			player.position = spawn_point.position 
			animated_sprite_2d.rotation_degrees  = 0
			lerp_weight = 0
			respawning = false
	else :
		if player.position.distance_squared_to(spawn_point.position) > 10000000 :
			print_debug(player.position.distance_squared_to(spawn_point.position))
			reset_spawn()
			pass
		
		# Add the gravity.
		if not is_on_floor():			
			velocity.y += gravity * delta
		
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity
			jump_audio_stream_player.play()
		
		if Input.is_action_just_pressed("swap"):
			swap_background()
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		
		if not is_on_floor():
			animated_sprite_2d.play("Jump")
		else :
			if direction == 0 : 
				animated_sprite_2d.play("Idle")
			else  : 
				animated_sprite_2d.play("Walk")
		
		# Flip sprite by direction
		if direction != 0 :
			animated_sprite_2d.flip_h = direction > 0
		
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		move_and_slide()

	

func _on_resetbox_triggered():
	reset_spawn()
func _on_fire_triggered() :
	reset_spawn()

func reset_spawn():
	animated_sprite_2d.play("Spin")
	respawning = true

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game_over.tscn")

func get_timer():
	return timer

	
func swap_background():
	background_active = !background_active
	set_background_visibility(background_active)
func set_background_visibility(value : bool):
	medieval_bg.visible = value
	scifi_bg.visible = !value
