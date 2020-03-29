extends Area2D

signal hit
signal coin
signal speedCoin

var screen_size
export var speed = 400


func _ready():
	hide()
	screen_size = get_viewport_rect().size

	
func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:	
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(body):
	if body.get_name() == 'Coin':
		emit_signal('coin')
		body.queue_free() 
	elif body.get_name() == 'SpeedCoin':
		emit_signal('speedCoin')
		speed = 600
		body.queue_free() 
	else:
		hide()
		emit_signal('hit')
		$CollisionShape2D.set_deferred('disabled', true)


func _on_Main_effect():
	speed = 400
