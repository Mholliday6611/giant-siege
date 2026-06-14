class_name HurtBox extends Area2D

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(
		func _on_area_entered(hit_area: HitBox) -> void:
			if hit_area != null:
				health_component.take_damage(hit_area.damage)
)
