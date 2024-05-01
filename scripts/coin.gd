extends Area2D

@onready var manager = %GameManager

func _on_body_entered(body):
	manager.increment()
	queue_free()
