extends Node2D

var in_grab_mode = false
var offset = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	#if in_grab_mode:
		#global_position = get_global_mouse_position() - offset

func _on_grab_box_enter_grab_mode() -> void:
	print("in grab mode")
	in_grab_mode = true
	offset = get_global_mouse_position() - global_position


func _on_grab_box_exit_grab_mode() -> void:
	print("Exit grab mode")
	in_grab_mode = false
