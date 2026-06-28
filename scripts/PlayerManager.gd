extends Node

var damage = 10
var is_dragging = false

signal start_grabbing(area: GrabBox) #might move this to an event bus script
signal end_grabbing

func handle_start_grabbing(area: GrabBox):
	#We want to notify the player when am object begins a drag
	#Kind of annoyed that I have to do it this way
	if !is_dragging:
		is_dragging = true
		start_grabbing.emit(area)

func handle_end_grabbing():
	is_dragging = false
	end_grabbing.emit()
