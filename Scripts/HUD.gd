extends CanvasLayer

signal start_game

	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
	
func show_game_over():
	show_message('Game Over')
	
	yield($MessageTimer, "timeout")
	
	$MessageLabel.text = 'Dodge the\nCreeps!'
	$MessageLabel.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$BlackHoleLabel.show()
	$AddButton.show()
	$SubtractButton.show()
	$CheckButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_coin(time):
	$CoinLabel.text = str(time)
	

func _on_StartButton_pressed():
	$StartButton.hide()
	$BlackHoleLabel.hide()
	$AddButton.hide()
	$SubtractButton.hide()
	$CheckButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_SubtractButton_pressed():
	if int($BlackHoleLabel.text) > 0:
		$BlackHoleLabel.text = str(int($BlackHoleLabel.text) - 1)


func _on_AddButton_pressed():
	if int($BlackHoleLabel.text) < 10:
			$BlackHoleLabel.text = str(int($BlackHoleLabel.text) + 1)
