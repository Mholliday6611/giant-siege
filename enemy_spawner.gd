extends Area2D

@export var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
@export var enemy_amount = 5
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var has_spawned = false

func _physics_process(delta: float) -> void:
	if !has_spawned:
		for i in range(enemy_amount):
			spawn_enemy()
		has_spawned = true

func spawn_enemy():
	if not enemy_scene or not collision_shape.shape is RectangleShape2D:
		return
	# 1. Get the rectangle extents and center
	var shape: RectangleShape2D = collision_shape.shape as RectangleShape2D
	var extents: Vector2 = shape.size / 2
	var center: Vector2 = global_position
	
	# 2. Calculate a random position inside the Area2D
	var random_x = randf_range(0, extents.x)
	var random_y = randf_range(0, extents.y)
	var spawn_pos = center + Vector2(random_x, random_y)
	# 3. Instantiate and place the enemy
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = spawn_pos
	print(enemy_instance)
	# Add to scene (use call_deferred if spawning during physics processing)
	get_parent().add_child(enemy_instance)
	
