extends Node2D


@export var dimension_1_tile_map : TileMap
@export var dimension_2_tile_map : TileMap

var dimension_1_active : bool = true
var d1_fire_array : Array[Node]
var d2_fire_array : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	d1_fire_array = dimension_1_tile_map.get_children()
	d2_fire_array = dimension_2_tile_map.get_children()
	set_dimension_physic(dimension_1_active)
	set_dimension_visibility(dimension_1_active)

func _process(delta):
	if Input.is_action_just_pressed("swap"):
		swap_dimension()

func swap_dimension():
	dimension_1_active = !dimension_1_active
	set_dimension_physic(dimension_1_active)
	set_dimension_visibility(dimension_1_active)

func set_dimension_physic(value : bool):
	dimension_1_tile_map.set_layer_enabled(0,value)
	dimension_2_tile_map.set_layer_enabled(0,!value)
	for fire in d1_fire_array :
		if fire.has_node("Area2D/CollisionShape2D"):
			fire._enable_collision(value)
	for fire in d2_fire_array :
		if fire.has_node("Area2D/CollisionShape2D"):
			fire._enable_collision(!value)
	
func set_dimension_visibility(value : bool):
	dimension_1_tile_map.visible = value
	dimension_2_tile_map.visible = !value



