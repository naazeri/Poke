extends RigidBody2D


func _ready():
#	randomize()
	$AnimatedSprite.playing = true # equal to play()
	
	var mobs_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mobs_types[randi() % mobs_types.size()]


func _process(delta):
#	$Label.text = "%.1f" % rotation
	
	if rotation <= PI and rotation >= PI/2 or rotation >= -PI and rotation <= -PI/2:
#		$Label.text = "%.1f" % rotation
		$AnimatedSprite.flip_v = true
#	else:
#		$Label.text = ""


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # remove node in end of frame not right now so it's safer than free()
