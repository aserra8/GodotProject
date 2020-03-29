extends RigidBody2D


func _on_start_game():
	queue_free()


func _on_Timer_timeout():
	queue_free()
