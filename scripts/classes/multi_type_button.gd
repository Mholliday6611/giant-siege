extends Button
class_name MultiTypeButton

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			button_pressed = true
			pressed.emit()
		else:
			button_pressed = false
