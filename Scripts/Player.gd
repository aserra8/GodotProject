extends Area2D

signal hit
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
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
		
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func on_Player_body_entered(body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred('disables', true)
