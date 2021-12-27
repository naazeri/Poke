extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0


func _ready():
#	randomize()
	$AnimatedSprite.playing = true # equal to play()
	
	var mobs_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mobs_types[randi() % mobs_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # remove node in end of frame not right now so it's safer than free()
