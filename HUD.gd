extends CanvasLayer

signal start_game
signal exit_game


func _ready():
	show_main_menu()


func update_score(score, best_score, old_best_score):
	var text: String = ""

	if best_score < 0 and old_best_score < 0:
		# realtime score
		text = str(score)
	else:
		# result score
		text = "Score: %3d" % score

		if best_score >= 0:
			text += "\nRecord: %3d" % best_score
		if old_best_score > 0 and best_score != old_best_score:
			text += "\nOld Record: %3d" % old_best_score

	$ScoreLabel.text = text


func show_main_menu():
	changeHUDItemsVisible(true)
	$ScoreLabel.hide()
	$BackButton.hide()
	$MessageLabel.text = "Poke"


func show_gameplay():
	changeHUDItemsVisible(false)
	$ScoreLabel.show()


func show_result():
	show_message("Pooffff")
	yield($MessageTimer, "timeout")

#	yield(get_tree().create_timer(1.0), "timeout") # quick timer
	changeHUDItemsVisible(true)
	$MessageLabel.text = "Nice Job"
	$MessageLabel.show()
	$BackButton.hide()


func show_about():
	changeHUDItemsVisible(false)
	$BackButton.show()
	$MessageLabel.text = "Developer: Reza Nazeri\n\nWebsite: naazeri.ir"


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func changeHUDItemsVisible(visible: bool):
	$ScoreLabel.visible = visible
	$StartButton.visible = visible
	$AboutButton.visible = visible
	$ExitButton.visible = visible
	$VersionLabel.visible = visible
	$BackButton.visible = visible


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	if !OS.window_fullscreen and OS.get_name() == "HTML5":
		OS.set_window_fullscreen(true)

	changeHUDItemsVisible(false)
	emit_signal("start_game")


func _on_ExitButton_pressed():
	emit_signal("exit_game")


func _on_AboutButton_pressed():
	show_about()


func _on_BackButton_pressed():
	show_main_menu()
