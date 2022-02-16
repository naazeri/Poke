extends RigidBody2D


func _ready():
	$AnimatedSprite.playing = true  # equal to play()

	var mobs_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mobs_types[randi() % mobs_types.size()]


# func finish_changes():
# 	yield(get_tree().create_timer(0.01), "timeout") # quick timer


# func _process(delta):
# #	$Label.text = "%.1f" % rotation

# if rotation <= PI and rotation >= PI / 2 or rotation >= -PI and rotation <= -PI / 2:
# 	$AnimatedSprite.flip_v = true
# 	$CollisionShape2D.transform.position.y *= -1

#		$Label.text = "%.1f" % rotation
#	else:
#		$Label.text = ""


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # remove node in end of frame not right now so it's safer than free()
