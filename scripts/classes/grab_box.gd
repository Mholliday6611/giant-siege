extends Area2D
class_name GrabBox

signal enter_grab_mode
signal exit_grab_mode

@export var actor: Node2D
var is_grabbing = false
var touch_index = -1
var grab_offset = Vector2.ZERO
#implement Stacking check to fix bug of multiple citizens ontop of each other

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch or event.is_action("press"):
		if event.is_pressed() and not is_grabbing:
			is_grabbing = true
			touch_index = event.index if event is InputEventScreenTouch else -1
			grab_offset = global_position - event.position

func _input(event):
	if not is_grabbing:
		return
		
	if (event is InputEventScreenDrag and event.index == touch_index) or event is InputEventMouse:
		actor.global_position = event.position + grab_offset
	
	# Release the object when the finger lifts
	if (event is InputEventScreenTouch and event.index == touch_index) or event.is_action("press"):
		if not event.pressed:
			is_grabbing = false
			touch_index = -1
