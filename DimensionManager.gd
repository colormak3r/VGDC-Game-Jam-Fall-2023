extends Node2D

@onready var player = $"../Player"
@export var dimension_manager : Node2D
@onready var dimension_1_tile_map = $"Dimension 1 TileMap"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_swap_pressed():
	print("Swapped")
	dimension_1_tile_map.clear_layer(1)
