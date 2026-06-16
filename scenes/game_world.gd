extends Node2D

@onready var gamve_over_ui: CenterContainer = $GamveOverUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gameover.connect(trigger_gameover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger_gameover():
	gamve_over_ui.visible = true


func _on_button_pressed() -> void:
	GameManager.handle_game_reset()
