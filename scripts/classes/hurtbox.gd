class_name HurtBox extends Area2D

@export var health_component: HealthComponent
@export var is_enemy: bool = true

var is_dragging = false
var touch_index = -1
var grab_offset = Vector2.ZERO

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	input_event.connect(_on_input_event)
	
func _on_area_entered(hit_area: HitBox) -> void:
		if hit_area != null:
			health_component.take_damage(hit_area.damage)
				
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Detect when the object is touched
	if !is_enemy: 
		return
	if event is InputEventScreenTouch or event.is_action("press"):
		#note add a hold timer possibly for grabbing stunned enemy
		#IE if presse for .15 seconds switch off hurtbox switch on grabbox
		if !event.is_pressed():
			print("attacked")
			health_component.take_damage(PlayerManager.damage)
