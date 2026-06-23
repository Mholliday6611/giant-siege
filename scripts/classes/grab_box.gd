extends Area2D
class_name GrabBox

signal enter_grab_mode
signal exit_grab_mode

func _ready() -> void:
	monitoring = false
