extends Node

var is_game_over = false

signal gameover

func handle_gameover():
	gameover.emit()
	get_tree().paused = true
	
func handle_game_reset():
	get_tree().paused = false
	get_tree().reload_current_scene()
