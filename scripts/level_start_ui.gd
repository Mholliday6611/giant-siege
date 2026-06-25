extends CenterContainer

signal level_start_animation_finished



func _on_level_start_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "LevelStart":
		level_start_animation_finished.emit()
