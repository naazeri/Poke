extends CanvasLayer

signal start_game


func update_score(score, best_score):
	if best_score < 0:
		$ScoreLabel.text = str(score)
	else:
		$ScoreLabel.text = "Score: %3d\nBest Score: %3d" % [score, best_score]


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Pooffff")
	yield($MessageTimer, "timeout")
	
	$MessageLabel.text = "Nice Job"
	$MessageLabel.show()
	
#	yield(get_tree().create_timer(1.0), "timeout") # quick timer
	changeButtonVisible(true)


func changeButtonVisible(visible : bool):
	$StartButton.visible = visible
	$ExitButton.visible = visible


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	changeButtonVisible(false)
	emit_signal("start_game")


func _on_ExitButton_pressed():
	get_tree().quit()


