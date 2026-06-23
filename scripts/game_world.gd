extends Node2D

@onready var gamve_over_ui: CenterContainer = $GamveOverUI
@onready var enemy_spawner: Area2D = $EnemySpawner
@onready var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")

@export var waves: int 
@export var use_waves: bool = true
var wave_number = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gameover.connect(trigger_gameover)
	spawn_waves()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_waves():
	if(wave_number > waves):
		return
#		Add in instructions to end level
	print("Start Wave", wave_number)
	var parent_name = get_tree().current_scene.name
	var wave_scene = "res://scenes/Levels/{level}/waves/wave_{wave}.tscn".format({"level": parent_name, "wave": wave_number})
	var wave = load(wave_scene)
	wave_number += 1
	var wave_instance: Wave = wave.instantiate()
	wave_instance.wave_finished.connect(spawn_waves)
	get_parent().add_child.call_deferred(wave_instance)

func spawn_enemy_randomly():
	if not enemy_scene or not enemy_spawner.collision_shape.shape is RectangleShape2D:
		return
	# 1. Get the rectangle extents and center
	var shape: RectangleShape2D = enemy_spawner.collision_shape.shape as RectangleShape2D
	var extents: Vector2 = shape.size / 2
	var center: Vector2 = enemy_spawner.collision_shape.global_position
	print(center)
	print(extents)
	# 2. Calculate a random position inside the Area2D
	var random_x = randf_range(-extents.x, extents.x)
	var random_y = randf_range(-extents.y, extents.y)
	var spawn_pos = center + Vector2(random_x, random_y)
	print(spawn_pos)
	# 3. Instantiate and place the enemy
	var enemy_instance = enemy_scene.instantiate()
	var enemy_speed = randi_range(1,8)
	enemy_instance.SPEED = enemy_speed
	enemy_instance.global_position = spawn_pos
	# Add to scene (use call_deferred if spawning during physics processing)
	get_parent().add_child(enemy_instance)
	var delay = randf_range(.1,2)
	await get_tree().create_timer(delay).timeout
	
func trigger_gameover():
	gamve_over_ui.visible = true

func _on_button_pressed() -> void:
	GameManager.handle_game_reset()
