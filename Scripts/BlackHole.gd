extends RigidBody2D


func _on_start_game():
	queue_free()


func _on_BlackHole_body_entered(body):
	if body.get_name() == 'BlackHole':	
		body.queue_free()
		$Sprite.size.x += 100
		$Sprite.size.y += 100
