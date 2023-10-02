extends Area2D

@onready var timer = $"../Timer"
@export var next_level : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		var time : float = timer.get_time_left()
#		PlayerVariables.add_score(250)
		PlayerVariables.jumped_through()
		
		if time > 5:
			PlayerVariables.add_score(500)
			get_tree().change_scene_to_file(next_level)
		else:
			PlayerVariables.add_score(250)
			get_tree().change_scene_to_file(next_level)

		
