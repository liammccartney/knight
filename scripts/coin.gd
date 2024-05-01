extends Area2D

@onready var manager = %GameManager
@onready var animation_player = $AnimationPlayer
func _on_body_entered(body):
	manager.increment()
	animation_player.play("pickup")
