extends Area2D


func _on_body_entered(body):
	print('cha-ching')
	queue_free()
