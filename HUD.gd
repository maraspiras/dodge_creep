extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text # set the text as the argument of show_message
	$MessageLabel.show() # show the message label
	$MessageTimer.start() # start the message timer
	
func game_over():
	show_message("Game Over") # us the show message function but add the "Game Over" string
	yield($MessageTimer, "timeout") # after message timer has gone 2 seconds the bottom statement will show
	$StartButton.show() # show the start button
	$MessageLabel.text = "Dodge the\nCreeps"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
