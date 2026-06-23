extends Node

var is_game_over = false

signal gameover

func handle_gameover():
	gameover.emit()
	get_tree().paused = true
	
func handle_game_reset():
	get_tree().paused = false
	get_tree().reload_current_scene()

func start_game(type):
	if type == "campaign":
		get_tree().change_scene_to_file("res://scenes/Levels/Level1/level_1.tscn")
#		load scene
	else:
		pass
