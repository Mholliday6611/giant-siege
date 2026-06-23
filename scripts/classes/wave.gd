extends Node2D
class_name Wave

@onready var enemy_container = $Enemies
var active_enemies: int = 0
signal wave_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemies = enemy_container.get_children()
	active_enemies = enemies.size()
	for enemy in enemies:
		print(enemy.has_signal("died"))
		if enemy.has_signal("died"):
			enemy.died.connect(_on_enemy_died)


func _on_enemy_died() -> void:
	print("Enemy Died")
	active_enemies -= 1
	
	if active_enemies <= 0:
		_on_all_enemies_dead()
		
func _on_all_enemies_dead() ->void:
	print("All Enemies Died")
	wave_finished.emit()
