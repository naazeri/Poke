extends Node

export (PackedScene) var mob_scene
var score = 0
var best_score = 0
var save_file_path = "user://savegame.save"
export var mob_min_speed = 150.0
export var mob_max_speed = 250.0
var new_mob_max_speed = 0


func _ready():
	randomize()
	load_best_score()

	# this line confines the cursor to the game window
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	_on_ColorTimer_timeout()


func new_game():
	new_mob_max_speed = mob_max_speed
	score = 0
	$HUD.update_score(score, -1, -1)
	$HUD.show_gameplay()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	$StartTimer.start()
	$Music.play()
	$HUD.show_message("Get ready...")
	
	yield($StartTimer, "timeout")
	
	$ScoreTimer.start()
	$MobTimer.start()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_result()
	$Music.stop()
	$DeathSound.play()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	var old_best_score = -1
	
	if need_save_best_score():
		old_best_score = best_score
		best_score = score
		save_best_score()

	$HUD.update_score(score, best_score, old_best_score)


func _on_MobTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2 # rotate 90 degree clockwise
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	new_mob_max_speed += 1
#	print(new_mob_max_speed)
	var velocity = Vector2(rand_range(mob_min_speed, new_mob_max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score, -1, -1)
#	mob_scene.get_node("Mob").max_speed *= 1.2


func need_save_best_score():
	return score > best_score


func save_best_score():
	var data = Dictionary()
	data["best_score"] = score
	
	var save_file = File.new()
	save_file.open(save_file_path, File.WRITE)
#	save_file.store_string(to_json(data))
	save_file.store_var(data, true)
	save_file.close()

func load_best_score():
	var save_file = File.new()
	
	if not save_file.file_exists(save_file_path):
		return
	
	save_file.open(save_file_path, File.READ)
#	var text = save_file.get_as_text()
	var data = save_file.get_var(true)
#	print("load data: ", data)
	
	if data != null:
#		var data = parse_json(text)
		best_score = data["best_score"]
#		print("bs set:", best_score)
	else:
		best_score = 0
	
	save_file.close()


func _on_ColorTimer_timeout():
	var newColor1 = Color(randf(), randf(), randf(), 1.0)
	var newColor2 = Color(randf(), randf(), randf(), 1.0)
	var newColor3 = Color(randf(), randf(), randf(), 1.0)
#	$Background1.modulate = newColor
	$Tween.interpolate_property($Background1, "modulate", $Background1.modulate, newColor1, $ColorTimer.wait_time, Tween.TRANS_LINEAR)
	$Tween.interpolate_property($Background2, "modulate", $Background2.modulate, newColor2, $ColorTimer.wait_time, Tween.TRANS_LINEAR)
	$Tween.interpolate_property($Background3, "modulate", $Background3.modulate, newColor3, $ColorTimer.wait_time, Tween.TRANS_LINEAR)
	$Tween.start()
