extends Node2D

@export var SPEED = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += SPEED


func _on_health_component_died() -> void:
	queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("base"):
		queue_free()
