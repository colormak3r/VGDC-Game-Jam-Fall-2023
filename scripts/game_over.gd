extends Control


var level : String = "res://levelone.tscn"


func _on_restart_pressed():
	get_tree().change_scene_to_file(level)
