extends Area2D

signal resetbox_triggered

func _on_body_entered(body):
	resetbox_triggered.emit()
