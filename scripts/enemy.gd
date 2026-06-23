extends Node2D

@export var SPEED = 5
@export var delay_time: int
@export var path_node: Path2D
@onready var health_component: HealthComponent = $HealthComponent

var points: PackedVector2Array = []
var current_point_index: int = 0
var is_waiting = false

signal died
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if delay_time > 0:
		is_waiting = true
		await get_tree().create_timer(delay_time).timeout
		is_waiting = false
	
	if path_node:
		points = path_node.curve.get_baked_points()
		print(points.size())
		print(points[-1] + path_node.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_waiting:
		if !path_node:
			position.y += SPEED
		else:
			if points.is_empty() or current_point_index >= points.size():
				return
			var target_pos = points[current_point_index] + path_node.global_position
			var direction = (target_pos - position).normalized()
			position += direction * SPEED
			print("TARGET:", target_pos)
			if global_position.distance_to(target_pos) < 10.0:
				current_point_index += 1

func _on_health_component_died() -> void:
	died.emit()
	queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("base"):
		died.emit()
		queue_free()
