extends Node

var is_game_over = false

signal gameover
signal start_grabbing(area: GrabBox) #might move this to an event bus script
signal end_grabbing

var is_dragging = false

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

func handle_start_grabbing(area: GrabBox):
	#We want to notify the player when am object begins a drag
	#Kind of annoyed that I have to do it this way
	if !is_dragging:
		is_dragging = true
		start_grabbing.emit(area)

func handle_end_grabbing():
	is_dragging = false
	end_grabbing.emit()
	
