extends Area2D

signal hit

export var speed = 400.0
var screen_size = Vector2.ZERO
var last_direction = Vector2.ZERO


func _ready():
	hide()
	screen_size = get_viewport_rect().size


func _process(delta):
#	var direction:Vector2 = Vector2.ZERO # uncomment if using keyboard
	
#	if Input.is_action_pressed("move_right"):
#		direction += Vector2.RIGHT
#	if Input.is_action_pressed("move_left"):
#		direction += Vector2.LEFT
#
#	if Input.is_action_pressed("move_down"):
#		direction += Vector2.DOWN
#	if Input.is_action_pressed("move_up"):
#		direction += Vector2.UP
	
	# this sets the nodes position to the mouse position each frame	
	var direction = get_viewport().get_mouse_position()
	position = direction
	
	if direction.length() > 0:
		# are moving (this condition happend if using keyboard not with mouse or touch)
#		direction = direction.normalized() # uncomment if using keyboard
		$AnimatedSprite.play()
	else:
		# not moving
		$AnimatedSprite.stop()

#	position += direction * speed * delta # uncomment if using keyboard
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
#	var is_moving_right = direction.x - last_direction.x > 0
#	var is_moving_up = direction.y - last_direction.y < 0
	
	$AnimatedSprite.animation = "run"

	if direction.x - last_direction.x != 0:
		$AnimatedSprite.flip_h = direction.x - last_direction.x < 0
	
	last_direction = direction

	 # uncomment if using keyboard
#	if direction.x != 0:
#		$AnimatedSprite.animation = "right"
#		$AnimatedSprite.flip_h = direction.x < 0
#		$AnimatedSprite.flip_v = false
#	elif direction.y != 0:
#		$AnimatedSprite.animation = "up"		
#		$AnimatedSprite.flip_v = direction.y > 0


func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false # don't need set_deferred. physics don't calculate anything


func _on_Player_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true) # it's safer. wait until end of physics calculation
	emit_signal("hit")
	
