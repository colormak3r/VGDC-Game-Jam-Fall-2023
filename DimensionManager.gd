extends Node2D

@export var dimension_1_tile_map : TileMap
@export var dimension_2_tile_map : TileMap

var dimension_1_active : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():	
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
	pass
	
func set_dimension_visibility(value : bool):
	dimension_1_tile_map.visible = value
	dimension_2_tile_map.visible = !value
