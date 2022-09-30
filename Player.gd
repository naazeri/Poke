extends Area2D

signal hit

export var speed = 400.0
var screen_size = Vector2.ZERO
var last_mouse_position = Vector2.ZERO
var drag_enabled = false
# var os_name
# var windows_os = "Windows"


func _ready():
	hide()
	screen_size = get_viewport_rect().size
	# os_name = OS.get_name()


func _physics_process(delta):
	handle_movement(delta)


func handle_movement(delta):
	# if not drag_enabled:
	$AnimatedSprite.play()
	$AnimatedSprite.animation = "run"
	# return

	var mouse_position = get_viewport().get_mouse_position()
	# var movement = mouse_position
	var movement = mouse_position - last_mouse_position

	# position = movement
	position += movement

	var move_direction = movement.x
	if move_direction != 0:
		$AnimatedSprite.flip_h = move_direction < 0
	#		direction = direction.normalized() # uncomment if using keyboard

	# limit position to screen size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# if not drag_enabled:
	last_mouse_position = mouse_position


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drag_enabled = event.is_pressed()
			if drag_enabled:
				last_mouse_position = get_viewport().get_mouse_position()


#	position += direction * speed * delta # uncomment if using keyboard
#	var is_moving_right = direction.x - last_direction.x > 0
#	var is_moving_up = direction.y - last_direction.y < 0

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
	$CollisionShape2D.disabled = false  # don't need set_deferred. physics don't calculate anything


func _on_Player_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)  # it's safer. wait until end of physics calculation
	emit_signal("hit")
