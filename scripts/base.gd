extends Node2D

@export var attack: PackedScene = preload("res://scenes/attack.tscn")
@onready var health_bar: ProgressBar = $ProgressBar
@onready var health_component: HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = health_component.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _on_health_component_damage_received() -> void:
	health_bar.value = health_component.health


func _on_health_component_died() -> void:
	health_bar.value = health_component.health
	GameManager.handle_gameover()
