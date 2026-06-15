extends Node2D

@export var attack: PackedScene = preload("res://scenes/attack.tscn")
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var health_component: HealthComponent = $HealthComponent

var attack_delay = 0.33
var can_attack = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value = health_component.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("press") and can_attack:
		attack_handler()
		

func attack_handler() -> void:
	var attack_instance = attack.instantiate()
	attack_instance.global_position = get_global_mouse_position()
	get_parent().add_child(attack_instance)
	can_attack = false
	await get_tree().create_timer(attack_delay).timeout
	can_attack = true


func _on_health_component_damage_received() -> void:
	print("Hit")
	progress_bar.value = health_component.health
