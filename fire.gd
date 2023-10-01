extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D

signal fire_triggered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if(!(body is TileMap)):
		fire_triggered.emit()

func _enable_collision(value : bool) :
	collision_shape_2d.set_deferred("disabled", !value)
